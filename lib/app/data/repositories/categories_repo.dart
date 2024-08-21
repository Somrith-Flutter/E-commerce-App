import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:market_nest_app/app/data/api/api_path.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/data/models/categories_model.dart';

class CategoriesRepo{

  Future<List<CategoriesModel>?> categories() async {
    try{
      var headers = {
        'Authorization': 'Bearer ${accessToken.$}'
      };
      var request = http.Request('GET', Uri.parse('${ApiPath.baseUrl}/${ApiPath.getCategories}'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final body = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        List<CategoriesModel> categoriesModel = [];
        var json = jsonDecode(body);
        print("============jsondata${json}");
        for(var result in json['data']){
          categoriesModel.add(CategoriesModel.fromJson(result));
        }
        return categoriesModel;
      }
      else {
        debugPrint("else error ${response.reasonPhrase}");
        return null;
      }
    }catch (e){
      debugPrint("=====GetCategories*** $e");
    }
    return null;
  }





}