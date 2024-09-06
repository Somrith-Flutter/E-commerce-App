import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/controllers/auth_controller.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/ui/global_widgets/loading_widget.dart';
import 'package:market_nest_app/app/ui/pages/authentication_page/register_page.dart';

class DeactivateAccount extends StatelessWidget {
  const DeactivateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (logic) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Platform.isAndroid
                  ? CupertinoIcons.arrow_left
                  : CupertinoIcons.back)),
          title: const Text("Deactivate Account",
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
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.person, color: Colors.redAccent,),
                  const Gap(20),
                  Text(logic.newUserModel!.name.toString(),
                    style: const TextStyle(fontSize: 16, color: Colors.redAccent),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.email, color: Colors.redAccent,),
                  const Gap(20),
                  Text(logic.newUserModel!.email.toString(),
                    style: const TextStyle(
                        fontSize: 16,
                      color: Colors.redAccent
                    ),
                  ),
                ],
              ),
              const Gap(20),
              const Text("Things to check when deleting your account!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              const Gap(20),
              _buildBulletPoint("You can't login in to application with this account after deleting it."),
              _buildBulletPoint("When you open this application again we required you register first."),
              _buildBulletPoint("After deleting an account everything in this account, and also payment history or some action with you will deleted."),
              _buildBulletPoint("Remember, this action will not recover."),

              const Gap(50),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    showLoadingDialog(context, label: "Deleting...");

                    Future.delayed(const Duration(milliseconds: 700), () async {
                      await logic.removeUserController(userId: logic.newUserModel!.id.toString());
                      if(logic.status == Status.success){
                        Get.off(const RegisterPage());
                      }
                    });
                  },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      )
                    ),
                  child: const Text("Delete Account",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• "),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
