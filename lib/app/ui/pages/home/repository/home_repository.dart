import 'package:flutter/material.dart';
import 'package:market_nest_app/app/data/api/api_path.dart';
import 'package:market_nest_app/app/data/rest_api_service.dart';
import 'package:market_nest_app/app/ui/pages/category/model/category_model.dart';

class HomeRepository extends RestApiService {
  Future<List<CategoryModel>> fetchCategories({String? search}) async {
    try {
      final queryParameters = {
        if (search != null && search.isNotEmpty) 'Search': search,
      };
      final response = await get(ApiPath.getCategories, body: queryParameters);
      
      // Access the 'data' field in the response
      List<dynamic> body = response['data'];
      debugPrint('Category: $body');
      return body.map((dynamic item) => CategoryModel.fromJson(item)).toList();
      
    } catch (e) {
      rethrow;
    }
  }
}

