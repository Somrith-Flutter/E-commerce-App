import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/config/app_object_list.dart';
import 'package:market_nest_app/app/controllers/lang_controller.dart';
import 'package:market_nest_app/app/ui/global_widgets/leading_app_bar_widget.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final LanguageController _languageController = Get.find<LanguageController>();
  LanguageController get lang => _languageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leadingAppBarWidget(cc: context),
        title: const Text("Language App",
          style: TextStyle(fontSize: 16),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.transparent,
            height: 4.0,
            child: const Divider(
              thickness: 1.0,
              color: Colors.grey,
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: appLangs.length,
          itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
             try{
               await lang.changeAppLanguage(index);
               IconSnackBar.show(
                 snackBarStyle: SnackBarStyle(
                   labelTextStyle: TextStyle(
                     color: Get.isDarkMode ? Colors.white : Colors.black
                   )
                 ),
                 context, label: "Language change to ${appLangs[index]['label']}",
                 snackBarType: SnackBarType.success,
                 duration: const Duration(seconds: 3)
               );
               Get.back();
             }catch(e){
               debugPrint(e.toString());
             }
            },
            child: _buildListFlags(
              flag: appLangs[index]['flag'],
              label: appLangs[index]['label'],
              key: index,
            ),
          );
        },),
      ),
    );
  }

  Widget _buildListFlags({required String flag, required String label, int key = 0}) {
    return ListTile(
      leading: Image.asset(flag,
        height: 24,
      ),
      title: Text(label),
      trailing: Icon(
        CupertinoIcons.check_mark_circled_solid,
        color: key == lang.isCheckLang.value ? Colors.green : Colors.transparent,
      ),
    );
  }
}
