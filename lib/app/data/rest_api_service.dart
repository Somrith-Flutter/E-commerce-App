import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:market_nest_app/app/data/api/api_path.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';

class RestApiService {
  Future<dynamic> get(String url, {Map<String, dynamic>? body}) async {
  try {
    var uri = Uri.parse('${ApiPath.baseUrl}/$url');
    if (body != null) {
      uri = uri.replace(queryParameters: body);
    }
    final response = await http.get(
      uri,
      headers: {
        'Accept': '*/*',
        'Authorization': 'Bearer ${accessToken.$}', // Make sure the token is correctly formatted
      },
    );

    // Debug print the raw response
    debugPrint('Response Status: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');

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
