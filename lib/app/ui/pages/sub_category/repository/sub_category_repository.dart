import 'package:flutter/material.dart';
import 'package:market_nest_app/common/constants/api_path.dart';
import 'package:market_nest_app/app/data/rest_api_service.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/model/sub_category_model.dart';

class SubCategoryRepository extends RestApiService {
  Future<List<SubCategoryModel>> fetchSubCategories({int? categoryId ,String? search}) async {
    try {
      final queryParameters = {
        'category_id': categoryId, 
        if (search != null && search.isNotEmpty) 'Search': search,
      };

      final response = await get(ApiPath.getSubCategories, body: queryParameters);

      if (response['data'] is List) {
        List<dynamic> body = response['data'];
        debugPrint('Sub category$body');
        return body.map((dynamic item) => SubCategoryModel.fromJson(item)).toList();
      } else {
        throw Exception("Unexpected response format");
      }

    } catch (e) {
      rethrow;
    }
  }
}

