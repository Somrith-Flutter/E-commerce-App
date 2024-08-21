import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/data/models/categories_model.dart';

import '../data/repositories/categories_repo.dart';

class CategoriesController extends GetxController{

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();
  final statusController = TextEditingController();
  final isSildeController = TextEditingController();
  final categories = CategoriesRepo();
  List<CategoriesModel> newCategories = [];
  Status status = Status.progress;

  void getCategories ()async{
    try{
      await categories.categories().then((categories){
        if(categories != null){
          newCategories = categories;
          status = Status.success;
        };
        status = Status.fail;
      });
    }catch(e){
      debugPrint("============= $e");
    }
  }
}