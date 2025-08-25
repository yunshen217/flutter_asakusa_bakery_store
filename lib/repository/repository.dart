import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart' show NotifyType;

import '../common/Global.dart';
import '../common/custom_widget.dart';
import 'baseInterceptors.dart';

typedef Response<T> = void Function(T result);
typedef SuccessRequestDown<T> = void Function(int total, int progress);
typedef ChooseSureCallBack = void Function();
typedef ErrorResponse = void Function(Object? error, StackTrace stackTrace, String? errorDetail);

final backEndRepository = BackEndRepository();

///バックエンドインターフェースとアドレス
class BackEndRepository {
  BackEndRepository._();

  final Dio _dio = Dio();

  //interceptors
  BackEndRepository() {
    _dio.interceptors.add(BaseInterceptors(_dio));
    // _dio.interceptors.add(LogInterceptor());
  }

  //header start
  static final Map<String, dynamic> _optionsMap = {
    "userId": Global.token,
    'ContentType': ContentType.parse("application/json;charset=UTF-8"),
    // "responseType": ResponseType.json,
    "Authorization": 'Bearer ${Global.userInfo?.accessToken ?? ""}',
    "client-id": Global.userInfo!.clientId ?? "",
    "X-API-KEY": "58ea70404a4b6652708245af107811ee6903ca2c9fa82f676306dac75f8b65ae"
  };

  final Options _options = Options(headers: _optionsMap);
  final Options _optionsNoToken = Options(headers: {});

  //header end

  // Future<void> doPost(String url,
  //     {Response? successRequest, ErrorResponse? errorRequest, Map<String, dynamic>? params}) async {
  //   await _dio.post(url, data: params ?? {}, options: getAuthOptions()).then((value) {
  //     successRequest!(jsonDecode(value.toString()));
  //   }).onError((error, stackTrace) {
  //     print(stackTrace);
  //     if (errorRequest != null) {
  //       errorRequest(error, stackTrace);
  //     }
  //   });
  // }
  Future<void> doPost(
    String url, {
    required Response? successRequest,
    ErrorResponse? errorRequest,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    print('url = $url');
    print('params = $params');
    try {
      Options requestOption;
      if (headers != null) {
        requestOption = Options(headers: headers);
      } else if (url == Constant.getCreditCardToken) {
        requestOption = getAuthOptionsForCreditCard();
      } else {
        requestOption = getAuthOptions();
      }
      print(requestOption.headers.toString());
      final response =
          await _dio.post(url, data: params ?? {}, options: requestOption);

      print("✅ リクエストが成功しました：${response.statusCode} - ${response.data}");

      successRequest!(response.data); 
    } catch (error, stackTrace) {
      print("❌ Request an exception: $error");
      print("📍 Stack information: $stackTrace");

      String? errorDetail;
      if (error is DioException) {
        if (error.response?.data != null) {
          final dynamic data = error.response!.data;

          // 2. Handle different types of response data
          if (data is Map<String, dynamic>) {
            // Scenario 1: Dio has automatically resolved to Map
            errorDetail = data['message'] as String?; // Replace your field name
          } else if (data is String) {
            //Case 2: The response is a string, try to parse manually
            try {
              final parsed = jsonDecode(data) as Map<String, dynamic>;
              errorDetail = parsed['message'] as String?;
            } catch (e) {
              errorDetail = "Original error message: $data";
            }
          }
        }
      }
      if (errorRequest != null) {
        errorRequest(error, stackTrace, errorDetail);
      }
    }
  }

  Future<void> upFile(
      String url, List<dynamic> filePaths, Response successRequest,
      {ErrorResponse? errorRequest, dynamic params}) async {
    //print(filePaths.map((dynamic path) async => await MultipartFile.fromFile(path)).toList());
    var files = [];
    for (var element in filePaths) {
      var form = await MultipartFile.fromFile(element);
      files.add(form);
    }
    var formData = FormData.fromMap({'multipartFile': files});
    await _dio
        .post(url, data: formData, options: getAuthOptions())
        .then((value) {
      successRequest(jsonDecode(value.toString()));
    }).onError((error, stackTrace) {
      customWidget.toastShow("Data upload failed", notifyType: NotifyType.error);
      print(error);
    });
  }

  Future<void> doGet(String url,
      {Response? successRequest,
      ErrorResponse? errorRequest,
      bool isChangeHeader = false,
      Map<String, dynamic>? params}) async {
        print("doGet-url =============== $url");
        print("doGet-params =============== $params");
    await _dio
        .get(url, queryParameters: params, options:isChangeHeader?getAuthOptionsWithMerchantId(): getAuthOptions())
        .then((value) {
      successRequest!(jsonDecode(value.toString()));
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  Future<dynamic> doGetAsync(String url, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(url,
          queryParameters: params, options: getAuthOptions());
      return jsonDecode(response.toString());
    } catch (e) {
      print("doGetAsync error: $e");
      rethrow; // 让 FutureBuilder 能捕获这个异常
    }
  }

  Future<void> doDel(String url,
      {Response? successRequest,
      ErrorResponse? errorRequest,
      Map<String, dynamic>? params}) async {
    await _dio
        .delete(url, queryParameters: params, options: getAuthOptions())
        .then((value) {
      successRequest!(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  Future<void> doPut(String url,
      {Response? successRequest,
      ErrorResponse? errorRequest,
      bool isMapData = true,
      List? paramList,
      Map<String, dynamic>? params}) async {
    await _dio.put(url, data:isMapData? params:paramList, options: getAuthOptions()).then((value) {
      successRequest!(value.data);
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}

Options getAuthOptions() {
  return Options(headers: {
    "Authorization": 'Bearer ${Global.userInfo?.accessToken ?? ""}',
    "client-id": Global.userInfo?.clientId ?? "",
    "Content-Type": "application/json;charset=UTF-8"
  });
}

Options getAuthOptionsWithMerchantId() {
  print('''
{
    "Authorization": 'Bearer ${Global.userInfo?.accessToken ?? ""}',
    "client-id": Global.userInfo?.clientId ?? "",
    "Content-Type": "application/json;charset=UTF-8",
    "merchantId":"1816640958868602882"
  }''');
  return Options(headers: {
    "Authorization": 'Bearer ${Global.userInfo?.accessToken ?? ""}',
    "client-id": Global.userInfo?.clientId ?? "",
    "Content-Type": "application/json;charset=UTF-8",
    "merchantId":"1816640958868602882"
  });
}

Options getAuthOptionsForCreditCard() {
  return Options(headers: {
    "Content-Type": "application/json;charset=UTF-8",
    "Accept": "application/json",
  });
}
