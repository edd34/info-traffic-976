import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:info_traffic_976/alert/models/traffic_alert.dart';
import 'package:info_traffic_976/core/models/httpresponse.dart';

class TrafficAlertAPIHelper {
  static Future<HTTPResponse<List<TrafficAlert>>> getTrafficAlert() async {
    try {
      final _url = '${dotenv.env['SERVER_LOCATION']}/get-traffic-alert/';
      print(_url);
      final response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        // ignore: prefer_final_locals
        // ignore: implicit_dynamic_variable
        final body = jsonDecode(response.body);
        print(body);
        List<TrafficAlert> trafficAlertList = [];
        // ignore: avoid_dynamic_calls
        /// ignore: implicit_dynamic_parameter, avoid_dynamic_calls
        body.forEach((e) {
          // ignore: omit_local_variable_types
          final TrafficAlert trafficAlert = TrafficAlert.fromJson(e);
          trafficAlertList.add(trafficAlert);
        });
        return HTTPResponse<List<TrafficAlert>>(
          isSuccessful: true,
          data: trafficAlertList,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<List<TrafficAlert>>(
          isSuccessful: false,
          data: [],
          message:
              'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<List<TrafficAlert>>(
        isSuccessful: false,
        data: [],
        message: 'Unable to reach the internet! Please try again in a moment.',
        statusCode: -1,
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<List<TrafficAlert>>(
        isSuccessful: false,
        data: [],
        message:
            'Invalid data received from the server! Please try again in a moment.',
        statusCode: -1,
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<List<TrafficAlert>>(
        isSuccessful: false,
        data: [],
        message: 'Something went wrong! Please try again in a moment!',
        statusCode: -1,
      );
    }
  }
}
