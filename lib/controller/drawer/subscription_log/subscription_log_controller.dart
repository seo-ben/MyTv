import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/model/drawer/transaction/transaction_log_model.dart';
import '../../../backend/services/transactions/transaction_log_services.dart';
import '../../../backend/utils/api_method.dart';

class SubscriptionLogController extends GetxController
    with TransactionApiServices {
  @override
  onInit() {
    super.onInit();
    // Charger les transactions seulement si l'utilisateur est connecté
    if (LocalStorage.isLoggedIn()) {
      transactionGetProcess();
    } else {
      // Pour les invités, initialiser un modèle vide
      _initializeEmptyModel();
    }
  }

  void _initializeEmptyModel() {
    _transactionModel = TransactionModel(
      message: Message(success: []),
      type: '',
      data: Data(
        instructions: Instructions(slug: '', status: ''),
        transactionTypes: [],
        transactions: [],
      ),
    );
    _isLoading.value = false;
  }

  /// >> set loading process & Transaction Model
  final _isLoading = false.obs;
  late TransactionModel _transactionModel;

  /// >> get loading process & Transaction Model
  bool get isLoading => _isLoading.value;

  TransactionModel get transactionModel => _transactionModel;

  ///* Get Transaction in process
  Future<TransactionModel> transactionGetProcess() async {
    _isLoading.value = true;
    update();
    await transactionGetApi()
        .then((value) {
          _transactionModel = value!;
          debugPrint(
            "controller =======> ${_transactionModel.data.transactions.length}",
          );
          _isLoading.value = false;
          update();
        })
        .catchError((onError) {
          log.e(onError);
        });
    _isLoading.value = false;
    update();
    return _transactionModel;
  }

  final RxInt expandedIndex = 100.obs;

  void toggleExpansion(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1; // Close if already open
    } else {
      expandedIndex.value = index; // Open the selected item
    }
  }
}
