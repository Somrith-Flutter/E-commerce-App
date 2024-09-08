import 'package:flutter/material.dart';
import 'package:market_nest_app/common/constants/api_path.dart';
import 'package:market_nest_app/app/data/rest_api_service.dart';
import 'package:market_nest_app/app/ui/pages/product/model/product_model.dart';

class ProductRepository extends RestApiService {
  Future<List<ProductModel>> fetchProducts({required int subCategoryId, String? search}) async {
    try {
      final queryParameters = {
        'sub_category_id': subCategoryId,
        if (search != null && search.isNotEmpty) 'Search': search,
      };

      final response = await get(ApiPath.getProducts, body: queryParameters);

      if (response['data'] is List) {
        List<dynamic> body = response['data'];
        debugPrint('Products: $body');
        return body.map((dynamic item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception("Unexpected response format");
      }

    } catch (e) {
      rethrow;
    }
  }
}
