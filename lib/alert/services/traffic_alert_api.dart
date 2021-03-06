import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:info_traffic_976/alert/models/traffic_alert.dart';
import 'package:info_traffic_976/core/models/httpresponse.dart';
import 'package:info_traffic_976/alert/providers/add_alert_provider.dart';

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
          final TrafficAlert trafficAlert =
              TrafficAlert.fromJson(e as Map<String, dynamic>);
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

  static Future<HTTPResponse<TrafficAlert>> createTrafficAlert({
    required double lon,
    required double lat,
    required int alertId,
  }) async {
    try {
      final _url = '${dotenv.env['SERVER_LOCATION']}/create-traffic-alert/';
      var jsonMap = <String, dynamic>{
        'lat': num.parse(lat.toStringAsFixed(8)),
        'lon': num.parse(lon.toStringAsFixed(8)),
        'alert_id': alertId,
      };
      String jsonString = json.encode(jsonMap);
      final response = await http.post(
        Uri.parse(_url),
        body: jsonString,
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        // ignore: prefer_final_locals
        // ignore: implicit_dynamic_variable
        final body = jsonDecode(response.body);
        print(body);
        TrafficAlert trafficAlertList =
            TrafficAlert.fromJson(body as Map<String, dynamic>);
        // ignore: avoid_dynamic_calls
        /// ignore: implicit_dynamic_parameter, avoid_dynamic_calls
        return HTTPResponse<TrafficAlert>(
          isSuccessful: true,
          data: trafficAlertList,
          message: 'Request Successful',
          statusCode: response.statusCode,
        );
      } else {
        return HTTPResponse<TrafficAlert>(
          isSuccessful: false,
          data: TrafficAlert(0, 0),
          message:
              'Invalid data received from the server! Please try again in a moment.',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      print('SOCKET EXCEPTION OCCURRED');
      return HTTPResponse<TrafficAlert>(
        isSuccessful: false,
        data: TrafficAlert(0, 0),
        message: 'Unable to reach the internet! Please try again in a moment.',
        statusCode: -1,
      );
    } on FormatException {
      print('JSON FORMAT EXCEPTION OCCURRED');
      return HTTPResponse<TrafficAlert>(
        isSuccessful: false,
        data: TrafficAlert(0, 0),
        message:
            'Invalid data received from the server! Please try again in a moment.',
        statusCode: -1,
      );
    } catch (e) {
      print('UNEXPECTED ERROR');
      print(e.toString());
      return HTTPResponse<TrafficAlert>(
        isSuccessful: false,
        data: TrafficAlert(0, 0),
        message: 'Something went wrong! Please try again in a moment!',
        statusCode: -1,
      );
    }
  }
}
