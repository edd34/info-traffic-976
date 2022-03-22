import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:info_traffic_976/core/models/httpresponse.dart';
import 'package:info_traffic_976/alert/models/alert_table.dart';

class AlertAPIHelper {
  static Future<HTTPResponse<List<AlertTable>>> getAlertTable() async {
    try {
      final response = await get(
        '127.0.0.1:8000/get-alert-table/' as Uri,
      );
      if (response.statusCode == 200) {
        // ignore: prefer_final_locals
        // ignore: implicit_dynamic_variable
        final body = jsonDecode(response.body);
        List<AlertTable> alertTableList = [];
        // ignore: avoid_dynamic_calls
        /// ignore: implicit_dynamic_parameter, avoid_dynamic_calls
        body.forEach((e) {
          // ignore: omit_local_variable_types
          var alertTable = AlertTable.fromJson(e);
          alertTableList.add(alertTable);
        });
        return HTTPResponse<List<AlertTable>>(
          isSuccessful: true,
          data: alertTableList,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<List<AlertTable>>(
          isSuccessful: false,
          data: [],
          message:
              'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<List<AlertTable>>(
        isSuccessful: false,
        data: [],
        message: 'Unable to reach the internet! Please try again in a moment.',
        statusCode: -1,
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<List<AlertTable>>(
        isSuccessful: false,
        data: [],
        message:
            'Invalid data received from the server! Please try again in a moment.',
        statusCode: -1,
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<List<AlertTable>>(
        isSuccessful: false,
        data: [],
        message: 'Something went wrong! Please try again in a moment!',
        statusCode: -1,
      );
    }
  }
}
