import 'package:flutter/cupertino.dart';
import 'package:market_nest_app/app/data/rest_api_service.dart';
import 'package:market_nest_app/app/ui/pages/product/model/product_model.dart';
import 'package:market_nest_app/common/constants/api_path.dart';

class MyCartRepository extends RestApiService{

  Future<List<ProductModel>> fetchCartList() async {
    try {
      final response = await get(ApiPath.getCarts,);

      if (response['data'] is List) {
        List<dynamic> body = response['data'];
        debugPrint('Carts: $body');
        return body.map((dynamic item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception("Unexpected response format");
      }

    } catch (e) {
      rethrow;
    }
  }
}