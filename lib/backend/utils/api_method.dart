import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../utils/system_maintenance_controller.dart';
import '../local_storage/local_storage.dart';
import '../model/common/error_message_model.dart';
import '../model/common/maintenance_model.dart';
import 'custom_snackbar.dart';
import 'logger.dart';

final log = logger(ApiMethod);

Map<String, String> basicHeaderInfo() {
  return {
    HttpHeaders.acceptHeader: "application/json, text/plain, */*",
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptLanguageHeader: "en-US,en;q=0.9,fr;q=0.8",
    HttpHeaders.userAgentHeader:
        "Mozilla/5.0 (Linux; Android 13; SM-G991B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36",
    "X-Requested-With": "XMLHttpRequest",
  };
}

Future<Map<String, String>> bearerHeaderInfo() async {
  String? accessToken = LocalStorage.getToken();

  Map<String, String> headers = {
    HttpHeaders.acceptHeader: "application/json, text/plain, */*",
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptLanguageHeader: "en-US,en;q=0.9,fr;q=0.8",
    HttpHeaders.userAgentHeader:
        "Mozilla/5.0 (Linux; Android 13; SM-G991B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36",
    "X-Requested-With": "XMLHttpRequest",
  };

  if (accessToken != null && accessToken.isNotEmpty) {
    headers[HttpHeaders.authorizationHeader] = "Bearer $accessToken";
  }

  return headers;
}

class ApiMethod {
  ApiMethod({required this.isBasic});

  bool isBasic;

  // Get method
  Future<Map<String, dynamic>?> get(
    String url, {
    int code = 200,
    int duration = 120,
    bool showResult = false,
    bool isNotStream = true,
  }) async {
    log.i(
      '|📍📍📍|----------------- [[ GET ]] method details start -----------------|📍📍📍|',
    );
    log.i(url);
    log.i(
      '|📍📍📍|----------------- [[ GET ]] method details ended -----------------|📍📍📍|',
    );

    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(Duration(seconds: duration));

      log.i(
        '|📒📒📒|-----------------[[ GET ]] method response start -----------------|📒📒📒|',
      );

      if (showResult) {
        log.i(response.body.toString());
      }

      log.i(response.statusCode);

      log.i(
        '|📒📒📒|-----------------[[ GET ]] method response end -----------------|📒📒📒|',
      );

      bool isMaintenance = response.statusCode == 503;
      // Check Unauthorized
      if (response.statusCode == 401) {
        LocalStorage.signOut();
      }
      // Check Server Error
      if (response.statusCode == 500) {
        CustomSnackBar.error('Server error');
      }

      _maintenanceCheck(isMaintenance, response.body);

      if (response.statusCode == code) {
        return _safeDecode(response.body);
      } else {
        log.e('🐞🐞🐞 Error Alert On Status Code 🐞🐞🐞');

        log.e('unknown error hitted in status code ${response.body}');

        final decoded = _safeDecode(response.body);
        if (decoded != null) {
          try {
            ErrorResponse res = ErrorResponse.fromJson(decoded);
            if (isMaintenance) {
            } else {
              if (isNotStream) {
                CustomSnackBar.error(res.message.error.join(''));
              }
            }
          } catch (e) {
            log.e('Error parsing error response: $e');
            if (!isMaintenance && isNotStream)
              CustomSnackBar.error(decoded.toString());
          }
        } else {
          // Unexpected error body format (e.g., list or non-json)
          log.e('Unexpected error body format or non-json: ${response.body}');
          if (!isMaintenance && isNotStream)
            CustomSnackBar.error(response.body.toString());
        }

        return null;
      }
    } on SocketException {
      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');
      if (isNotStream) {
        CustomSnackBar.error('Check your Internet Connection and try again!');
      }
      return null;
    } on TimeoutException {
      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');

      log.e('Time out exception$url');
      if (isNotStream) {
        CustomSnackBar.error('Something Went Wrong! Try again');
      }
      return null;
    } on http.ClientException catch (err, stackrace) {
      log.e('🐞🐞🐞 Error Alert Client Exception🐞🐞🐞');

      log.e('client exception hitted');

      log.e(err.toString());

      log.e(stackrace.toString());

      return null;
    } catch (e) {
      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');

      log.e('❌❌❌ unlisted error received');

      log.e("❌❌❌ $e");

      return null;
    }
  }

  // Post Method
  Future<Map<String, dynamic>?> post(
    String url,
    Map<String, dynamic> body, {
    int code = 201,
    int duration = 200,
    bool showResult = false,
  }) async {
    try {
      log.i(
        '|📍📍📍|-----------------[[ POST ]] method details start -----------------|📍📍📍|',
      );

      log.i(url);

      log.i(body);

      log.i(
        '|📍📍📍|-----------------[[ POST ]] method details end ------------|📍📍📍|',
      );

      final response = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(body),
            headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(Duration(seconds: duration));

      log.i(
        '|📒📒📒|-----------------[[ POST ]] method response start ------------------|📒📒📒|',
      );

      if (showResult) {
        log.i(response.body.toString());
      }

      log.i(response.statusCode);

      log.i(
        '|📒📒📒|-----------------[[ POST ]] method response end --------------------|📒📒📒|',
      );
      bool isMaintenance = response.statusCode == 503;

      _maintenanceCheck(isMaintenance, response.body);

      // Check Unauthorized
      if (response.statusCode == 401) {
        LocalStorage.signOut();
      }
      // Check Server Error
      if (response.statusCode == 500) {
        CustomSnackBar.error('Server error');
      }

      if (response.statusCode == code) {
        return _safeDecode(response.body);
      } else {
        log.e('🐞🐞🐞 Error Alert On Status Code 🐞🐞🐞');

        log.e('unknown error hitted in status code ${response.body}');

        final decoded = _safeDecode(response.body);
        if (decoded != null) {
          try {
            ErrorResponse res = ErrorResponse.fromJson(decoded);
            if (!isMaintenance)
              CustomSnackBar.error(res.message.error.join(''));
          } catch (e) {
            log.e('Error parsing error response: $e');
            if (!isMaintenance) CustomSnackBar.error(decoded.toString());
          }
        } else {
          // Unexpected error body format (e.g., list or non-json)
          log.e('Unexpected error body format or non-json: ${response.body}');
          if (!isMaintenance) CustomSnackBar.error(response.body.toString());
        }

        return null;
      }
    } on SocketException {
      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      CustomSnackBar.error('Check your Internet Connection and try again!');

      return null;
    } on TimeoutException {
      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');

      log.e('Time out exception$url');

      CustomSnackBar.error('Something Went Wrong! Try again');

      return null;
    } on http.ClientException catch (err, stackrace) {
      log.e('🐞🐞🐞 Error Alert Client Exception🐞🐞🐞');

      log.e('client exception hitted');

      log.e(err.toString());

      log.e(stackrace.toString());

      return null;
    } catch (e) {
      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');

      log.e('❌❌❌ unlisted error received');

      log.e("❌❌❌ $e");

      return null;
    }
  }

  // Post Method
  Future<Map<String, dynamic>?> multipart(
    String url,
    Map<String, String> body,
    String filepath,
    String filedName, {
    int code = 200,
    bool showResult = false,
  }) async {
    try {
      log.i(
        '|📍📍📍|-----------------[[ Multipart ]] method details start -----------------|📍📍📍|',
      );

      log.i(url);

      log.i(body);
      log.i(filepath);

      log.i(
        '|📍📍📍|-----------------[[ Multipart ]] method details end ------------|📍📍📍|',
      );

      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(body)
        ..headers.addAll(isBasic ? basicHeaderInfo() : await bearerHeaderInfo())
        ..files.add(await http.MultipartFile.fromPath(filedName, filepath));
      var response = await request.send();
      var jsonData = await http.Response.fromStream(response);

      log.i(
        '|📒📒📒|-----------------[[ POST ]] method response start ------------------|📒📒📒|',
      );

      log.i(jsonData.body.toString());

      log.i(response.statusCode);

      log.i(
        '|📒📒📒|-----------------[[ POST ]] method response end --------------------|📒📒📒|',
      );
      bool isMaintenance = response.statusCode == 503;

      _maintenanceCheck(isMaintenance, jsonData);

      if (response.statusCode == code) {
        return _safeDecode(jsonData.body);
      } else {
        log.e('🐞🐞🐞 Error Alert On Status Code 🐞🐞🐞');

        log.e('unknown error hitted in status code ${jsonData.body}');

        final decoded = _safeDecode(jsonData.body);
        if (decoded != null) {
          try {
            ErrorResponse res = ErrorResponse.fromJson(decoded);
            if (!isMaintenance)
              CustomSnackBar.error(res.message.error.toString());
          } catch (e) {
            log.e('Error parsing multipart error response: $e');
            if (!isMaintenance) CustomSnackBar.error(decoded.toString());
          }
        } else {
          log.e(
            'Unexpected multipart error body format or non-json: ${jsonData.body}',
          );
          if (!isMaintenance) CustomSnackBar.error(jsonData.body.toString());
        }

        return null;
      }
    } on SocketException {
      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      CustomSnackBar.error('Check your Internet Connection and try again!');

      return null;
    } on TimeoutException {
      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');

      log.e('Time out exception$url');

      CustomSnackBar.error('Something Went Wrong! Try again');

      return null;
    } on http.ClientException catch (err, stackrace) {
      log.e('🐞🐞🐞 Error Alert Client Exception🐞🐞🐞');

      log.e('client exception hitted');

      log.e(err.toString());

      log.e(stackrace.toString());

      return null;
    } catch (e) {
      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');

      log.e('❌❌❌ unlisted error received');

      log.e("❌❌❌ $e");

      return null;
    }
  }

  // multipart multi file Method
  Future<Map<String, dynamic>?> multipartMultiFile(
    String url,
    Map<String, String> body, {
    int code = 200,
    bool showResult = false,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {
    try {
      log.i(
        '|📍📍📍|-----------------[[ Multipart ]] method details start -----------------|📍📍📍|',
      );

      log.i(url);

      if (showResult) {
        log.i(body);
        log.i(pathList);
        log.i(fieldList);
      }

      log.i(
        '|📍📍📍|-----------------[[ Multipart ]] method details end ------------|📍📍📍|',
      );
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(body)
        ..headers.addAll(
          isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
        );

      for (int i = 0; i < fieldList.length; i++) {
        request.files.add(
          await http.MultipartFile.fromPath(fieldList[i], pathList[i]),
        );
      }

      var response = await request.send();
      var jsonData = await http.Response.fromStream(response);

      log.i(
        '|📒📒📒|-----------------[[ POST ]] method response start ------------------|📒📒📒|',
      );

      log.i(jsonData.body.toString());

      log.i(response.statusCode);

      log.i(
        '|📒📒📒|-----------------[[ POST ]] method response end --------------------|📒📒📒|',
      );
      bool isMaintenance = response.statusCode == 503;
      // Check Server Error
      if (response.statusCode == 500) {
        CustomSnackBar.error('Server error');
      }
      _maintenanceCheck(isMaintenance, jsonData);

      if (response.statusCode == code) {
        return _safeDecode(jsonData.body);
      } else {
        log.e('🐞🐞🐞 Error Alert On Status Code 🐞🐞🐞');

        log.e('unknown error hitted in status code ${jsonData.body}');

        final decoded = _safeDecode(jsonData.body);
        if (decoded != null) {
          try {
            ErrorResponse res = ErrorResponse.fromJson(decoded);
            if (!isMaintenance)
              CustomSnackBar.error(res.message.error.toString());
          } catch (e) {
            log.e('Error parsing multipart error response: $e');
            if (!isMaintenance) CustomSnackBar.error(decoded.toString());
          }
        } else {
          log.e(
            'Unexpected multipart error body format or non-json: ${jsonData.body}',
          );
          if (!isMaintenance) CustomSnackBar.error(jsonData.body.toString());
        }

        // CustomSnackBar.error(
        //     jsonDecode(response.body)['message']['error'].toString());
        return null;
      }
    } on SocketException {
      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      CustomSnackBar.error('Check your Internet Connection and try again!');

      return null;
    } on TimeoutException {
      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');

      log.e('Time out exception$url');

      CustomSnackBar.error('Something Went Wrong! Try again');

      return null;
    } on http.ClientException catch (err, stackrace) {
      log.e('🐞🐞🐞 Error Alert Client Exception🐞🐞🐞');

      log.e('client exception hitted');

      log.e(err.toString());

      log.e(stackrace.toString());

      return null;
    } catch (e) {
      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');

      log.e('❌❌❌ unlisted error received');

      log.e("❌❌❌ $e");

      return null;
    }
  }

  // Delete Method
  Future<Map<String, dynamic>?> delete(
    String url, {
    int code = 200,
    int duration = 120,
    bool showResult = false,
  }) async {
    log.i(
      '|📍📍📍|----------------- [[ DELETE ]] method details start -----------------|📍📍📍|',
    );
    log.i(url);
    log.i(
      '|📍📍📍|----------------- [[ DELETE ]] method details end -------------------|📍📍📍|',
    );

    try {
      final response = await http
          .delete(
            Uri.parse(url),
            headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(Duration(seconds: duration));

      log.i(
        '|📒📒📒|-----------------[[ DELETE ]] method response start ----------------|📒📒📒|',
      );

      if (showResult) {
        log.i(response.body.toString());
      }

      log.i(response.statusCode);

      log.i(
        '|📒📒📒|-----------------[[ DELETE ]] method response end -----------------|📒📒📒|',
      );

      bool isMaintenance = response.statusCode == 503;

      // Check Unauthorized
      if (response.statusCode == 401) {
        LocalStorage.signOut();
      }

      // Check Server Error
      if (response.statusCode == 500) {
        CustomSnackBar.error('Server error');
      }

      _maintenanceCheck(isMaintenance, response.body);

      if (response.statusCode == code) {
        return jsonDecode(response.body);
      } else {
        log.e('🐞🐞🐞 Error Alert On Status Code 🐞🐞🐞');

        log.e(
          'unknown error hitted in status code ${jsonDecode(response.body)}',
        );

        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          try {
            ErrorResponse res = ErrorResponse.fromJson(decoded);
            if (!isMaintenance)
              CustomSnackBar.error(res.message.error.join(''));
          } catch (e) {
            log.e('Error parsing delete error response: $e');
            if (!isMaintenance) CustomSnackBar.error(decoded.toString());
          }
        } else {
          log.e('Unexpected delete error body format: $decoded');
          if (!isMaintenance) CustomSnackBar.error(decoded.toString());
        }

        return null;
      }
    } on SocketException {
      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');
      CustomSnackBar.error('Check your Internet Connection and try again!');
      return null;
    } on TimeoutException {
      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');
      log.e('Time out exception$url');
      CustomSnackBar.error('Something Went Wrong! Try again');
      return null;
    } on http.ClientException catch (err, stacktrace) {
      log.e('🐞🐞🐞 Error Alert Client Exception🐞🐞🐞');
      log.e('client exception hitted');
      log.e(err.toString());
      log.e(stacktrace.toString());
      return null;
    } catch (e) {
      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');
      log.e('❌❌❌ unlisted error received');
      log.e("❌❌❌ $e");
      return null;
    }
  }

  void _maintenanceCheck(bool isMaintenance, var jsonData) {
    if (isMaintenance) {
      Get.find<SystemMaintenanceController>().maintenanceStatus.value = true;
      try {
        final decoded = jsonDecode(
          jsonData is http.Response ? jsonData.body : jsonData.toString(),
        );
        MaintenanceModel maintenanceModel = MaintenanceModel.fromJson(decoded);
        MaintenanceDialog().show(maintenanceModel: maintenanceModel);
      } catch (e) {
        log.e('Error parsing maintenance response: $e');
      }
    } else {
      Get.find<SystemMaintenanceController>().maintenanceStatus.value = false;
    }
  }

  Map<String, dynamic>? _safeDecode(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      } else if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      } else {
        log.e('Expected Map but got ${decoded.runtimeType}: $decoded');
        return null;
      }
    } catch (e) {
      log.e('Failed to decode JSON: $e');
      log.e('Body was: $body');
      return null;
    }
  }
}
