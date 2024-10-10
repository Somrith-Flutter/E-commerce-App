import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/common/constants/api_path.dart';
import 'package:market_nest_app/app/data/rest_api_service.dart';
import 'package:market_nest_app/app/ui/pages/product/model/product_model.dart';

class ProductRepository extends RestApiService {
  Future<List<ProductModel>> fetchProducts({required String subCategoryId, String? search}) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${accessToken.$}'
      };
      var request = http.Request('GET', Uri.parse('${ApiPath.baseUrl()}/${ApiPath.getProducts}'));
      request.body = json.encode({
        "sub_category_id": subCategoryId,
        "keyword": search ?? ""
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final bodyResponse = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        var json = jsonDecode(bodyResponse);
        List<ProductModel> p = [];
        for(var re in json['data']){
          p.add(ProductModel.fromJson(re));
        }
        return p;
      }
      else {
        debugPrint(response.reasonPhrase);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return [];
  }

  Future<dynamic> addToCart({required int id, required int quantity}) async {
    try {
      final queryParameters = {
        "product_id": id,
        "quantity": quantity,
      };
      await post(ApiPath.addToCart, queryParameters);
    } catch (e) {
      debugPrint('Error in adding to cart: $e');
      rethrow;
    }
  }
}