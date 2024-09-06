import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:market_nest_app/app/data/api/api_path.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/data/rest_api_service.dart';
import 'package:market_nest_app/app/ui/pages/category/model/category_model.dart';
import 'package:market_nest_app/app/ui/pages/product/model/product_model.dart';
import 'package:http/http.dart' as http;

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

  Future<List<ProductModel>> fetchedProductByLength({String? limitItem}) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${accessToken.$}'
      };
      var request = http.Request('GET', Uri.parse("${ApiPath.baseUrl}/${ApiPath.getProductByLength}"));
      request.body = json.encode({
        "limit": limitItem.toString()
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
        print("Error in get request: $e");
      }
    }
    return [];
  }
}

