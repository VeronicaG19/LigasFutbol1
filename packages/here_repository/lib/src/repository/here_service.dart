import 'dart:convert';

import 'package:here_repository/src/exceptions/here_exception.dart';

import '../../here_repository.dart';
import 'package:http/http.dart' as http;

import '../endpoints.dart';

class HereService{

  Future<ApiHereResponseAddresses> getAddres(String apiKey, String addres) async{
     final request = await http.get(Uri.parse('${Endpoints.getApiHereSearchData}?apiKey=$apiKey&searchtext=$addres'),)
        .timeout(
          const Duration(seconds: 60),
          onTimeout: () =>
              throw HereException.fromCode(HereExceptionType.unknownException),
        );

    if (request.statusCode == 200) {
      print(request.body);
      final addres = jsonDecode(request.body);
      
      return ApiHereResponseAddresses.fromJson(addres);
    } else if (request.statusCode == 401 || request.statusCode == 400) {
      throw HereException.fromCode(HereExceptionType.unauthorized);
    } else if (request.statusCode == 500) {
      throw HereException.fromCode(HereExceptionType.serverException);
    } else {
      throw HereException.fromCode(
          HereExceptionType.unknownException);
    }
  }


  Future<ReverseHeoApiHere> getReverseGeo(String apiKey, String latLengt) async{
    print('${Endpoints.getReverseGeo}?at=$latLengt&lang=es-MX&apiKey=$apiKey');
     final request = await http.get(Uri.parse('${Endpoints.getReverseGeo}?at=$latLengt&lang=en-US&apiKey=$apiKey'),)
        .timeout(
          const Duration(seconds: 60),
          onTimeout: () =>
              throw HereException.fromCode(HereExceptionType.unknownException),
        );

    if (request.statusCode == 200) {
      print(request.body);
      final addres = jsonDecode(utf8.decode(request.bodyBytes));
      
      return ReverseHeoApiHere.fromJson(addres);
    } else if (request.statusCode == 401 || request.statusCode == 400) {
      throw HereException.fromCode(HereExceptionType.unauthorized);
    } else if (request.statusCode == 500) {
      throw HereException.fromCode(HereExceptionType.serverException);
    } else {
      throw HereException.fromCode(
          HereExceptionType.unknownException);
    }
  }
}