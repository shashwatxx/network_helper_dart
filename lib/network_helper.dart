import 'dart:io';

import 'package:dio/dio.dart';

class NetworkUtil {
  static getData(String url) async {
    try {
      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        print(response.data);
        return response.data;
      }
    } catch (e) {
      print(e);
    }
  }

  static postData(String url, dynamic data) async {
    try {
      var response = await Dio().post(
        url,
        data: data,
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return response;
      }
    } catch (e) {
      print(e);
    }
  }
}
