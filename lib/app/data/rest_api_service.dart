import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:market_nest_app/common/constants/api_path.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';

class RestApiService {
  Future<dynamic> get(String url, {Map<String, dynamic>? body}) async {
    try {
      var uri = Uri.parse('${ApiPath.baseUrl}/$url');
      var request = http.Request('GET', uri);

      request.headers.addAll({
        'Accept': '*/*',
        'Authorization': 'Bearer ${accessToken.$}', 
        'Content-Type': 'application/json',
      });

      if (body != null) {
        request.body = jsonEncode(body);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('Error in get request: $e');
      rethrow;
    }
  }


  Future<void> post(String url, dynamic body, {Map<String, dynamic>? params}) async {
    try {
      var uri = Uri.parse('${ApiPath.baseUrl}/$url');
      if (params != null) {
        uri = uri.replace(queryParameters: params.map((key, value) => MapEntry(key, value.toString())));
      }

      debugPrint('Posting to: $uri');
      debugPrint('Body: ${jsonEncode(body)}');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint('Data posted successfully');
      } else {
        debugPrint('Failed to post data: ${response.statusCode}, ${response.body}');
        throw Exception('Failed to post data');
      }
    } catch (e) {
      debugPrint('Exception caught in postRequest: $e');
      rethrow;
    }
  }

  Future<void> put(String url, dynamic body) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiPath.baseUrl}/$url'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<void> delete(String url) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiPath.baseUrl}/$url'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
