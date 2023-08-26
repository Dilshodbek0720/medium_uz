import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medium_uz/data/local/storage_repository.dart';
import 'package:medium_uz/data/models/universal_data.dart';
import 'package:medium_uz/utils/constants/constants.dart';
import '../models/articles/articles_model.dart';
import '../models/user/user_model.dart';

class ApiService{

  final _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          "Content-Type": "application/json",
        },
        connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
        receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeout),
        sendTimeout: Duration(seconds: TimeOutConstants.sendTimeout),
      )
  );

  ApiService(){
    _init();
  }

  _init(){
    _dio.interceptors.add(
        InterceptorsWrapper(
            onError: (error,handler) async{
              //error.response.statusCode
              debugPrint("ERRORGA KIRDI:${error.message} and ${error.response}");
              return handler.next(error);
            },
            onRequest: (requestOptions, handler) async{
              debugPrint("SO'ROV  YUBORILDI :${requestOptions.path}");
              requestOptions.headers.addAll({"token": StorageRepository.getString("token")});
              // return handler.resolve(Response(requestOptions: requestOptions, data: {"name": "ali", "age": 26}));
              return handler.next(requestOptions);
            },
            onResponse: (response, handler) async{
              debugPrint("JAVOB  KELDI :${response.requestOptions.path}");
              return handler.next(response);
            }
        )
    );
  }
//----------------------- AUTHENTICATION -------------------------

  Future<UniversalData> sendCodeToGmail({
    required String gmail,
    required String password,
  })async{
    Response response;
    try{
      response = await _dio.post(
        '/gmail',
        data: {
          "gmail": gmail,
          "password": password,
        },
      );

      if((response.statusCode! >= 200) && (response.statusCode! < 300)){
        return UniversalData(data: response.data["message"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> confirmCode({required String code}) async {
    Response response;
    try {
      response = await _dio.post(
        '/password',
        data: {"checkPass": code},
      );

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["message"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> registerUser({
    required UserModel userModel
  }) async {
    Response response;
    _dio.options.headers = {
      "Accept": "multipart/form-data",
    };
    try {
      response = await _dio.post(
        '/register',
        data: await userModel.getFormData(),
      );
      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["data"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
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
      response = await _dio.post(
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
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

//----------------------- PROFILE -------------------------


  Future<UniversalData> getProfileData() async{
    Response response;
    try{
      response = await _dio.get('/users');

      if((response.statusCode! >= 200) && (response.statusCode! < 300)){
        return UniversalData(data: UserModel.fromJson(response.data["data"]));
      }
      return UniversalData(error: "Other Error");
    }on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }


//----------------------- ARTICLES -------------------------

  Future<UniversalData> getAllArticles() async {
    Response response;
    try {
      response = await _dio.get('/articles');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(
            data: (response.data["data"] as List?)
                ?.map((e) => ArticleModel.fromJson(e))
                .toList() ??
                []);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

}