import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:market_nest_app/constants/api_path.dart';
import 'package:market_nest_app/modules/app/data/api/app_endpoint.dart';
import 'package:market_nest_app/modules/app/data/globle_variable/public_variable.dart';

class AuthRepo{

  Future<String> loginRepo({required String emailAddress, required String password}) async {
    try{
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}/${AppEndpoint.login}'));
      request.body = json.encode({
        "email": emailAddress,
        "password": password
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final res = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        debugPrint(res);
        final json = jsonDecode(res);
        return json['token'];
      }
      else {
        debugPrint("else error ${response.reasonPhrase}");
        return "";
      }
    }catch(e){
      debugPrint("================*** $e");
    }
    return "";
  }

  Future<String> registerRepo({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String confirmPassword,
  }) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}/${AppEndpoint.register}'));
    request.body = json.encode({
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "confirmPassword": password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return jsonDecode(responseBody);
    } else {
      debugPrint(response.reasonPhrase);
    }
    return "";
  }

  Future<String?> forgotPasswordRepo({required String email}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${accessToken.$}'
    };
    var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}/${AppEndpoint.forgetPassword}'));
    request.body = json.encode({
      "email": email
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final json = jsonDecode(responseBody);
      debugPrint("============&&& $responseBody");
      return json['varify_via_code'];
    }
    else {
      debugPrint(response.reasonPhrase);
      return null;
    }
  }

  Future<String?> resetPassword({
    required String newPassword,
    required String uid,
    required String confirm
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${accessToken.$}'
    };
    var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}/${AppEndpoint.setNewPassword}'));
    request.body = json.encode({
      "uid": uid,
      "newPassword": newPassword,
      "confirmViaPass": confirm
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var json = jsonDecode(body);
      return json;
    }
    else {
      debugPrint(response.reasonPhrase);
      return null;
    }
  }
}