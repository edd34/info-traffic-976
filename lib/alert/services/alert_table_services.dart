import 'package:dio/dio.dart';

class AlertTableService {
  static const String _url = '127.0.0.1:8000/get-alert-table/';
  static Future browse() async {
    try {
      final response = await Dio().get(_url);
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
