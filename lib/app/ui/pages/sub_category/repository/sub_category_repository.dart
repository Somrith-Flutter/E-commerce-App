import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/common/constants/api_path.dart';
import 'package:market_nest_app/app/data/rest_api_service.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/model/sub_category_model.dart';
import 'package:http/http.dart' as http;

class SubCategoryRepository extends RestApiService {
  Future<List<SubCategoryModel>> fetchSubCategories(
      {int? categoryId, String? search}) async {
    try {
      final queryParameters = {
        'category_id': categoryId,
        if (search != null && search.isNotEmpty) 'Search': search,
      };

      final response =
          await get(ApiPath.getSubCategories, body: queryParameters);

      if (response['data'] is List) {
        List<dynamic> body = response['data'];
        return body
            .map((dynamic item) => SubCategoryModel.fromJson(item))
            .toList();
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SubCategoryModel>> getBannerSlideRepository({required String active}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${accessToken.$}'
    };
    var request = http.Request(
        'POST', Uri.parse('${ApiPath.baseUrl()}/${ApiPath.getBannerSlide}'));
    request.body = json.encode({"active_slide": active});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      List<SubCategoryModel> l = [];
      var json = jsonDecode(body);

      for(var i in json['data']){
        l.add(SubCategoryModel.fromJson(i));
      }
      return l;
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
    return [];
  }
}
