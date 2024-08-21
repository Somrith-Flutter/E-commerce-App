import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:market_nest_app/app/data/api/api_path.dart';
import 'package:market_nest_app/app/data/models/user_models.dart';

class AuthRepo{

  Future<String> loginRepo({required String emailAddress, required String password}) async {
    try{
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}/${ApiPath.login}'));
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

  Future<Map<String, dynamic>?> registerRepo({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String confirmPassword,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}/${ApiPath.register}'));
    request.body = json.encode({
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "confirmPassword": password,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();


    final responseBody = await response.stream.bytesToString();
    if (response.statusCode == 201) {
      var json = jsonDecode(responseBody);
      return json;
    } else {
      debugPrint(response.reasonPhrase);
    }
    return null;
  }

  Future<Map<String, dynamic>?> forgotPasswordRepo({required String email}) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}/${ApiPath.forgetPassword}'));
    request.body = json.encode({
      "email": email
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(responseBody);
      return json;
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
    };
    var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}/${ApiPath.setNewPassword}'));
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

  Future<List<UserModel>?> getMeRepo({required String userToken}) async {
    print("token repo $userToken");
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('${ApiPath.baseUrl}/${ApiPath.getMe}'));
    request.body = json.encode({
      "token": userToken
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      List<UserModel> userModel = [];
      Map<String, dynamic> json = jsonDecode(body);
      userModel.add(UserModel.fromJson(json));
      return userModel;
    }
    else {
      debugPrint(body);
      debugPrint(response.reasonPhrase);
    }
    return null;
  }

  Future<Map<String, dynamic>?> confirmViaEmailRepo({ required String email }) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}/${ApiPath.confirmViaEmail}'));
    request.body = json.encode({
      "email": email
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      debugPrint(body);
      final json = jsonDecode(body);
      return json;
    }
    else {
      debugPrint("======= ${response.reasonPhrase}");
      return null;
    }
  }
}