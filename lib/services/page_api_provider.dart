import 'dart:io';

import 'package:therealworldflutter_app/models/page_response.dart';
import 'package:therealworldflutter_app/models/content_response.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCredentials{
  final String userName;
  final String password;
  LoginCredentials(this.userName, this.password);
}

typedef Future<LoginCredentials> DoLogin();
const TOKEN_KEY = 'api_token2';
class PageApiProvider {


  final String _endpoint = "http://192.168.1.59:8080/api";
  //Dio _dio;
  Dio _dio = Dio();
  DoLogin doLogin;

  PageApiProvider() {
    //_dio = Dio();
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (Options options) async {
        if((options as RequestOptions).path.endsWith("login") == false ) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String token = prefs.getString(TOKEN_KEY);
          if (token != null) {
            //options.headers["Authorization"] = "Bearer eNl6zzw/49aDYSeU5YkLQg==";
            options.headers["Authorization"] = "Bearer $token";
          }

        } else {
          print("Loginpath");
        }
        return options;
      }
    ));
  }

  Future<PageResponse> getPage() async {
    try {
      Response response = await _dio.get("$_endpoint/pages");
      return PageResponse.fromJson(response.data);
    } on DioError catch(error){
      if (error.response != null && error.response.statusCode == 401) {
        print("Du auth");
        if (doLogin != null) {
          LoginCredentials loginCredentials = await doLogin();
          String token = await _doLogin(loginCredentials);
          print(token);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString(TOKEN_KEY, token);
        }
        return getPage();
      }
      return PageResponse.withError("$error");
    } catch (error, stacktrace){

      print("Exception occured: $error stackTrace: $stacktrace");
      return PageResponse.withError("$error");
    }
  }
  
  Future<ContentResponse> getContent(String pageId) async {
    try {
      Response response = await _dio.get("$_endpoint/pages/$pageId/contents");
      return ContentResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ContentResponse.withError("$error");
    }
  }

  Future<String> _doLogin(LoginCredentials loginCredentials) async {
    try {
      Response response = await _dio.post("$_endpoint/login", options:
        Options(headers:
        {
          'authorization': basicAuthenticationHeader(loginCredentials.userName, loginCredentials.password)
        }));
      print(response.data);
      return response.data['string'];

    } catch(error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
    return "error";
  }


}

String basicAuthenticationHeader(String username, String password) {
  return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
}