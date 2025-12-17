import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:MyTelevision/controller/navbar/dashboard/dashboard_controller.dart';

import '../backend/local_storage/local_storage.dart';
import '../utils/basic_screen_imports.dart';
import 'language_model.dart';
import 'language_service.dart';

class LanguageController extends GetxController {
  RxString selectedLanguage = "".obs; // Selected language is English
  RxString defLangKey = "".obs; // Default language is English

  @override
  void onInit() {
    fetchLanguages().then((value) => getDefaultKey());
    super.onInit();
  }

  List<Language> languages = [];
  var isLoadingValue = false.obs;

  bool get isLoading => isLoadingValue.value;
  static const String selectedLanguageKey = 'selectedLanguage';

  Future<void> fetchLanguages() async {
    isLoadingValue.value = true;
    try {
      final languageService = LanguageService();
      languages = await languageService.fetchLanguages();

      // Check if API returned empty list, if so, load local fallback
      if (languages.isEmpty) {
        debugPrint(
          'API returned empty language list, loading local fallback...',
        );
        await _loadLocalLanguageData();
      }

      isLoadingValue.value = false;
    } catch (e) {
      debugPrint('Error fetching language data: $e');
      // On error, also try loading local fallback
      debugPrint('Loading local fallback due to error...');
      await _loadLocalLanguageData();
      isLoadingValue.value = false;
    }
  }

  Future<void> _loadLocalLanguageData() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/default_languages.json',
      );
      final Map<String, dynamic> data = json.decode(response);
      final List<dynamic> languageDataList = data["data"]["languages"];
      languages = languageDataList
          .map((json) => Language.fromJson(json))
          .toList();
      debugPrint(
        'Local language fallback loaded successfully: ${languages.length} languages found.',
      );
    } catch (e) {
      debugPrint('Error loading local language fallback: $e');
    }
  }

  // >> get default language key
  String getDefaultKey() {
    isLoadingValue.value = true;

    // Safety check: if languages list is empty, return default 'fr'
    if (languages.isEmpty) {
      defLangKey.value = 'fr';
      isLoadingValue.value = false;
      return 'fr';
    }

    // Try to find a language with status == true
    Language selectedLang;
    try {
      // Prioritize French as default
      selectedLang = languages.firstWhere(
        (lang) => lang.code == 'fr',
        orElse: () => languages.firstWhere(
          (lang) => lang.status == true,
          orElse: () => languages.isNotEmpty
              ? languages.first
              : Language(
                  name: 'French',
                  code: 'fr',
                  status: true,
                  translateKeyValues: {},
                  dir: 'ltr',
                ),
        ),
      );
    } catch (e) {
      // Ultimate fallback if something goes wrong
      selectedLang = languages.isNotEmpty
          ? languages.first
          : Language(
              name: 'French',
              code: 'fr',
              status: true,
              translateKeyValues: {},
              dir: 'ltr',
            );
    }

    defLangKey.value = selectedLang.code;

    // Load selected language from cache
    final box = GetStorage();
    selectedLanguage.value = box.read(selectedLanguageKey) ?? defLangKey.value;
    isLoadingValue.value = false;
    return selectedLang.code;
  }

  void changeLanguage(String newLanguage) {
    selectedLanguage.value = newLanguage;
    final box = GetStorage();
    box.write(selectedLanguageKey, newLanguage);
    LocalStorage.saveRtl(type: languageDirection == 'rtl' ? true : false);

    Get.find<DashboardController>().getHomeInfoProcess(
      newLanguage: newLanguage,
    );
    Get.find<DashboardController>().getSubscriptionInfoProcess(
      newLanguage: newLanguage,
    );
    update();
  }

  String getTranslation(String key) {
    if (languages.isEmpty) {
      return key;
    }

    try {
      // Find selected language object
      Language? selectedLang;
      try {
        selectedLang = languages.firstWhere(
          (lang) => lang.code == selectedLanguage.value,
          orElse: () => languages.firstWhere(
            (lang) => lang.code == defLangKey.value,
            orElse: () => languages.isNotEmpty ? languages.first : languages[0],
          ),
        );
      } catch (e) {
        // Double safety for empty list though previously checked
        return key;
      }

      // Find default (English) language object
      Language? defaultLanguage;
      try {
        defaultLanguage = languages.firstWhere(
          (lang) => lang.code == 'en',
          orElse: () => languages.isNotEmpty ? languages.first : languages[0],
        );
      } catch (e) {
        return key;
      }

      String? value = selectedLang.translateKeyValues[key];

      // If translation missing in selected language, try default language
      if (value == null || value.isEmpty) {
        value = defaultLanguage.translateKeyValues[key];
      }

      // If still missing, return key
      return value ?? key;
    } catch (e) {
      // Fallback in case of any list iteration error
      return key;
    }
  }

  /// Get text direction
  TextDirection get languageDirection {
    // avoid recursive updates if called during build
    if (languages.isEmpty) {
      return TextDirection.ltr;
    }
    try {
      final selectedLang = languages.firstWhere(
        (lang) => lang.code == selectedLanguage.value,
        orElse: () => languages.firstWhere(
          (lang) => lang.code == defLangKey.value,
          orElse: () => languages.first,
        ),
      );
      // LocalStorage.saveRtl(type: selectedLang.dir == 'rtl' ? true : false); // consider moving to changeLanguage
      return selectedLang.dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr;
    } catch (e) {
      return TextDirection.ltr;
    }
  }
}
