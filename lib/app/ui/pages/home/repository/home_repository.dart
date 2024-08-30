import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:market_nest_app/app/data/api/api_path.dart';
import 'package:market_nest_app/app/data/rest_api_service.dart';
import 'package:market_nest_app/app/ui/pages/category/model/category_model.dart';
import 'package:market_nest_app/app/ui/pages/product/model/product_model.dart';

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

  Future<List<ProductModel>> fetchedProductByLength({String? search}) async {
    try {
      final queryParameters = {
        'limit': 2, 
        if (search != null && search.isNotEmpty) 'Search': search,
      };

      final response = await get(ApiPath.getProductByLength, body: queryParameters);

      if (response['data'] is List) {
        List<dynamic> body = response['data'];
        debugPrint('Product by length$body');
        return body.map((dynamic item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception("Unexpected response format");
      }

    } catch (e) {
      if (kDebugMode) {
        print("Error in get request: $e");
      }
      rethrow;
    }
  }
}

