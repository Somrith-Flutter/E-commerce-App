import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/data/models/colors_model.dart';
import 'package:market_nest_app/common/constants/api_path.dart';

class ColorsRepository {
  Future<List<ColorsModel>> listColorRepository({required String productIds}) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${accessToken.$}'
      };
      var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl()}/${ApiPath.listColors}'));
      request.body = json.encode({
        "product_id": productIds
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var body = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        List<ColorsModel> model = [];
        var json = jsonDecode(body);
        for(var i in json['data']){
          model.add(ColorsModel.fromJson(i));
        }
        return model;
      }
    } catch (e) {
      if(kDebugMode){
        print("colors repository error $e");
      }
    }
    return [];
  }
}