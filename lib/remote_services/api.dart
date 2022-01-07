import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';

class Network {
  final String _url = 'https://tutor.oddatech.com/api/';
  var token;

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    token = localStorage.getString('token');
  }

  getpassedData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);

    await _getToken();
    return await http.post(uri, body: jsonEncode(data), headers: _setHeaders());
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);
    return await http.post(uri, body: jsonEncode(data), headers: _setHeaders());
  }
}
