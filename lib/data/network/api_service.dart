import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:medium_uz/data/local/storage_repository.dart';
import 'package:medium_uz/data/models/universal_data.dart';
import 'package:medium_uz/data/models/websites/website_model.dart';
import 'package:medium_uz/data/network/widgets/dio_custom_error.dart';
import 'package:medium_uz/utils/constants/constants.dart';
import '../models/articles/articles_model.dart';
import '../models/user/user_model.dart';

class ApiService{

  final _dioSecure = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Content-Type": "application/json",
      },
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeout),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeout),
    ),
  );

  final _dioOpen = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Content-Type": "application/json",
      },
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeout),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeout),
    ),
  );

  ApiService(){
    _init();
  }

  _init() {
    _dioSecure.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          //error.response.statusCode
          debugPrint("ERRORGA KIRDI:${error.message} and ${error.response}");
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          debugPrint("SO'ROV  YUBORILDI :${requestOptions.path}");
          requestOptions.headers
              .addAll({"token": StorageRepository.getString("token")});
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint("JAVOB  KELDI :${response.requestOptions.path}");
          return handler.next(response);
        },
      ),
    );

    _dioOpen.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          //error.response.statusCode
          debugPrint("ERRORGA KIRDI:${error.message} and ${error.response}");
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          debugPrint("SO'ROV  YUBORILDI :${requestOptions.path}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint("JAVOB  KELDI :${response.requestOptions.path}");
          return handler.next(response);
        },
      ),
    );
  }

//----------------------- AUTHENTICATION -------------------------

  Future<UniversalData> sendCodeToGmail({
    required String gmail,
    required String password,
  }) async {
    Response response;
    try {
      response = await _dioOpen.post(
        '/gmail',
        data: {
          "gmail": gmail,
          "password": password,
        },
      );

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["message"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      return DioCustomError.getDioCustomError(e);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> confirmCode({required String code}) async {
    Response response;
    try {
      response = await _dioOpen.post(
        '/password',
        data: {"checkPass": code},
      );

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["message"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      return DioCustomError.getDioCustomError(e);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> registerUser({required UserModel userModel}) async {
    Response response;
    _dioSecure.options.headers = {
      "Accept": "multipart/form-data",
    };
    try {
      response = await _dioOpen.post(
        '/register',
        data: await userModel.getFormData(),
      );
      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["data"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      return DioCustomError.getDioCustomError(e);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> loginUser({
    required String gmail,
    required String password,
  }) async {
    Response response;
    try {
      response = await _dioOpen.post(
        '/login',
        data: {
          "gmail": gmail,
          "password": password,
        },
      );

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["data"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      return DioCustomError.getDioCustomError(e);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

//----------------------- PROFILE -------------------------



  Future<UniversalData> getProfileData() async {
    Response response;
    try {
      response = await _dioSecure.get('/users');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: UserModel.fromJson(response.data["data"]));
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      return DioCustomError.getDioCustomError(e);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  //----------------------- WEBSITES -------------------------

  Future<UniversalData> createWebsite(
      {required WebsiteModel websiteModel}) async {
    Response response;
    _dioSecure.options.headers = {
      "Accept": "multipart/form-data",
    };
    try {
      response = await _dioSecure.post(
        '/sites',
        data: await websiteModel.getFormData(),
      );
      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["data"]);
      }
      return UniversalData(error: "Other Error");
    } on SocketException catch (e) {
      return UniversalData(error: e.toString());
    } on DioException catch (e) {
      return DioCustomError.getDioCustomError(e);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> getWebsites() async {
    Response response;
    try {
      response = await _dioOpen.get('/sites');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(
          data: (response.data["data"] as List?)
              ?.map((e) => WebsiteModel.fromJson(e))
              .toList() ??
              [],
        );
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      return DioCustomError.getDioCustomError(e);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> getWebsiteById(int id) async {
    Response response;
    try {
      response = await _dioOpen.get('/sites/$id');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(
            data: WebsiteModel.fromJson(response.data["data"]));
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      return DioCustomError.getDioCustomError(e);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  //----------------------- ARTICLES -------------------------

  Future<UniversalData> getAllArticles() async {
    Response response;
    try {
      response = await _dioSecure.get('/articles');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(
            data: (response.data["data"] as List?)
                ?.map((e) => ArticleModel.fromJson(e))
                .toList() ??
                []);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      return DioCustomError.getDioCustomError(e);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> createArticle(
      {required ArticleModel articleModel}) async {
    Response response;
    _dioSecure.options.headers = {
      "Accept": "multipart/form-data",
    };
    try {
      response = await _dioSecure.post(
        '/articles',
        data: await articleModel.getFormData(),
      );
      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["data"]);
      }
      return UniversalData(error: "Other Error");
    } on SocketException catch (e) {
      return UniversalData(error: e.toString());
    } on DioException catch (e) {
      return DioCustomError.getDioCustomError(e);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> getArticleById(int id) async {
    Response response;
    try {
      response = await _dioSecure.get('/articles/$id');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(
            data: ArticleModel.fromJson(response.data["data"]));
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      return DioCustomError.getDioCustomError(e);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}