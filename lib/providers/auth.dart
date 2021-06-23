import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  Future<void> signup(String email, String password) async {
    final key = dotenv.env['firebase_web_api_key'].toString();
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$key');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException('${responseData['error']['message']}');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    final key = dotenv.env['firebase_web_api_key'].toString();
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$key');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException('${responseData['error']['message']}');
      }
    } catch (error) {
      throw error;
    }
  }
}
