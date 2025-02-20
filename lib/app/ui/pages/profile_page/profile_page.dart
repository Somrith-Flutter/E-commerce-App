import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/controllers/auth_controller.dart';
import 'package:market_nest_app/app/controllers/lang_controller.dart';
import 'package:market_nest_app/app/controllers/theme_controller.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/data/helpers.dart';
import 'package:market_nest_app/app/ui/pages/authentication_page/forgot_password.dart';
import 'package:market_nest_app/app/ui/pages/authentication_page/login_page.dart';
import 'package:market_nest_app/app/ui/pages/language_screen.dart';
import 'package:market_nest_app/app/ui/pages/profile_page/widgets/deactivate_account.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';
import 'package:market_nest_app/app/ui/pages/profile_page/widgets/faq.dart';
import 'package:market_nest_app/app/ui/pages/profile_page/widgets/order_history.dart';
import 'package:market_nest_app/app/ui/pages/profile_page/widgets/payment.dart';
import 'package:market_nest_app/app/ui/pages/profile_page/widgets/shipping_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<PackageInfo> _packageInfoFuture;
  final _auth = Get.find<AuthController>();
  final LanguageController _languageController = Get.find<LanguageController>();
  LanguageController get lang => _languageController;

  AuthController get auth => _auth;
  final _timer = CountdownTimer();
  final ThemeController _theme = Get.put(ThemeController());

  @override
  void initState() {
    super.initState();
    _packageInfoFuture = _loadPackageInfo();
  }

  Future<PackageInfo> _loadPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            _buildProfileContent(),
          ],
        ),
      );
    });
  }

  Widget _buildSliverAppBar() {
    const profileUrl =
        'https://i.pinimg.com/564x/86/a8/ef/86a8ef5ff3a046bfd168695b6e9d6608.jpg';

    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 175,
      pinned: true,
      floating: true,
      snap: true,
      backgroundColor: AppColors.cyan,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          bool isExpanded = constraints.biggest.height > 175;
          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(isExpanded ? 28 : 0),
            title: _buildProfileHeader(profileUrl, isExpanded),
            background: _buildHeaderBackground(),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(String profileUrl, bool isExpanded) {
    return Container(
      padding: EdgeInsets.only(
        left: isExpanded ? 0 : 10,
        bottom: isExpanded ? 25 : 5,
        top: isExpanded ? 25 : 0,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(profileUrl),
          ),
          const Gap(7),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _auth.newUserModel != null &&
                        _auth.newUserModel.toString().isNotEmpty
                    ? _auth.newUserModel!.name.toString()
                    : "Unknown",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                _auth.newUserModel != null &&
                        _auth.newUserModel.toString().isNotEmpty
                    ? _auth.newUserModel!.email.toString()
                    : "Unknown",
                style: const TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBackground() {
    return Container(
      color: AppColors.cyan,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            color: !_theme.isDarkMode.value
                ? AppColors.primaryWhite
                : AppColors.primaryBlack,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("personalInformation".tr),
            _buildProfileOption(Icons.location_on_outlined, "shippingAddress".tr,
                onTap: () {
              Get.to(const ShippingAddressScreen());
            }),
            const Divider(),
            _buildProfileOption(Icons.payment_outlined, "paymentMethod".tr,
                onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaymentMethodScreen()));
            }),
            const Divider(),
            _buildProfileOption(Icons.history_outlined, "orderHistory".tr,
                onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderHistoryScreen()));
            }),
            const Divider(),
            _buildSectionTitle("supportInformation".tr),
            _buildProfileOption(Icons.privacy_tip_outlined, "privacyPolicy".tr,
                onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
            }),
            const Divider(),
            _buildProfileOption(
                Icons.description_outlined, 'term_&_condition'.tr, onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => TermsConditionsScreen()));
            }),
            const Divider(),
            _buildProfileOption(Icons.help_outline, 'faqs'.tr, onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FAQScreen()));
            }),
            const Divider(),
            _buildSectionTitle('account_management'.tr),
            _buildDarkThemeToggle(),
            const Divider(),
            _buildProfileOption(Icons.lock_outline, 'change_password'.tr,
                onTap: () {
              Get.to(const ForgotPasswordScreen(
                fixedWidget: 0,
                isFromChangePassword: true,
              ));
            }),
            const Divider(),
            _buildProfileOption(Icons.language_outlined, 'languages'.tr, onTap: () {
              Get.to(const LanguageScreen());
            }),
            const Divider(),
            FutureBuilder<PackageInfo>(
              future: _packageInfoFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildProfileOption(
                      Icons.build_circle_outlined, 'version'.tr,
                      trailing: 'Loading...');
                } else if (snapshot.hasError) {
                  return _buildProfileOption(
                      Icons.build_circle_outlined, 'version'.tr,
                      trailing: 'Error');
                } else {
                  return _buildProfileOption(
                      Icons.build_circle_outlined, 'version'.tr,
                      trailing: snapshot.data?.version ?? 'Unknown');
                }
              },
            ),
            const Divider(),
            _buildProfileOption(Icons.logout, 'logout'.tr, onTap: () {
              _timer.clear();
              logout(context);
            }, color: Colors.redAccent),

            if(_auth.userModel?.role.toString() == "admin")...[
              const Divider(),
              _buildProfileOption(CupertinoIcons.delete, 'deactivate_account'.tr,
                onTap: () {
                  Get.to(const DeactivateAccount());
                }, color: Colors.redAccent, colorText: Colors.redAccent),
            ]

          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    IconData icon,
    String title, {
    String trailing = '',
    VoidCallback? onTap,
    Color? color = Colors.grey,
    Color? colorText,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: colorText),
      ),
      trailing: trailing.isEmpty
          ? const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          : Text(trailing, style: const TextStyle(fontSize: 18)),
      onTap: onTap,
    );
  }

  Widget _buildDarkThemeToggle() {
    return ListTile(
      leading: Icon(_theme.isDarkMode.value
          ? Icons.dark_mode
          : Icons.light_mode),
      title: Text(
        _theme.isDarkMode.value
            ? "dark_mode".tr
            : "light_mode".tr,
      ),
      trailing: Obx(
        () => Switch(
          value: _theme.isDarkMode.value,
          onChanged: (value) {
            _theme.switchTheme();
          },
          activeColor: Colors.white,
          inactiveThumbColor: Colors.grey,
          activeTrackColor: _theme.isDarkMode.value
            ? Colors.green
            : Colors.grey,
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'confirm'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          backgroundColor: AppColors.cyan,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'are_you_sure'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 30),
              const Divider(
                thickness: 1,
                color: Colors.white,
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        await auth.logout();

                        if (accessToken.$.isEmpty) {
                          auth.clearSetter();
                          Get.off(const LoginPage());
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                      ),
                      child: Text(
                        'accept'.tr,
                        style: const TextStyle(
                          color: AppColors.cyan,
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                      ),
                      child: Text(
                        'cancel'.tr,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
