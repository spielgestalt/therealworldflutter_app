import 'dart:io';

import 'package:therealworldflutter_app/models/page_response.dart';
import 'package:therealworldflutter_app/models/content_response.dart';
import 'package:dio/dio.dart';
class PageApiProvider {

  final String _endpoint = "http://192.168.1.59:8080/api";
  //Dio _dio;
  Dio _dio = Dio();

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
        options.headers["Authorization"] = "Bearer eNl6zzw/49aDYSeU5YkLQg==";
        return options;
      }
    ));
  }

  Future<PageResponse> getPage() async {
    try {
      Response response = await _dio.get("$_endpoint/pages");
      return PageResponse.fromJson(response.data);
    } on DioError catch(error){
      if (error.response.statusCode == 401) {
        print("Du auth");
        return getPage();
      }

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
}