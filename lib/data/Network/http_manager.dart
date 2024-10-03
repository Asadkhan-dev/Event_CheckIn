import 'dart:developer';
import 'package:event_manager/data/Network/api_urls.dart';
import 'package:event_manager/data/Network/response_handler.dart';
import 'package:event_manager/data/model/event_api_dto.dart';

class HTTPManager {
  final ResponseHandler _handler = ResponseHandler();
  String api_key ="mLRp7Q37Al9LJDEbZDBS585uq9GdUVzt";
  // String api_key ="iSCo4Lq1cpZW-b3HPxW79DOoIlNuH2BOtVZVD8qe";

  Future<EventListDTO> getEvents() async {
    try {
      var url =  "${ApplicationURLs.GET_EVENTS}?apikey=$api_key";
      // var url =AppConstants.apiBaseUrl+ApplicationURLs.GET_EVENTS;
      log(url);
      final response = await _handler.get(Uri.parse(url));
      print(response.toString());
      EventListDTO responseModel = EventListDTO.fromJson(response);
      return responseModel;
    } catch (e) {
      // handle the error here
      log('Error: $e');
      rethrow; // rethrow the error if you want to propagate it
    }
  }
}