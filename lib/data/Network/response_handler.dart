// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:event_manager/core/constants/app_constants.dart';
import 'package:http/http.dart' as http;

import 'app_exceptions.dart';

// ignore: non_constant_identifier_names
String MESSAGE_KEY = 'message';

class ResponseHandler {
  Map<String, String> setTokenHeader() {
     return {'Authorization': 'Bearer ${AppConstants.apptoken}'};
  }
  Future get(Uri url) async {

    var head = <String, String>{};
    head['content-type'] = 'application/json; charset=utf-8';
    head.addAll(setTokenHeader());
   // ignore: prefer_typing_uninitialized_variables
    var responseJson;
    try {
      final response = await http.get(url, headers: head).timeout(const Duration(seconds: 45));
      responseJson = json.decode(response.body.toString());
      return responseJson;
    } on TimeoutException {
      throw FetchDataException("There is something wrong with your internet connection");
    } on SocketException {
      throw FetchDataException('Please turn on your data or connect wifi network');
    }
  }

}
