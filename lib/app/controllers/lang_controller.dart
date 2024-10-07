import 'dart:ui';
import 'package:get/get.dart';
import 'package:market_nest_app/translation/l10n/intl_en.dart';
import 'package:market_nest_app/translation/l10n/intl_kh.dart';
import 'package:market_nest_app/translation/l10n/abs_lang.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController implements GetxService {
  var getCurrentLanguage = Locale('en').obs;
  RxInt isCheckLang = 0.obs;

  List<Language> langs = [
    KH(),  // Khmer
    EN()   // English
  ];

  Future<void> changeAppLanguage(int index) async {
    Language selectedLang = langs[index];
    getCurrentLanguage.value = Locale(selectedLang.languageCode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', selectedLang.languageCode);
    Get.updateLocale(Locale(selectedLang.languageCode));
    isCheckLang.value = index;
  }
  Future<void> loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLangCode = prefs.getString('language_code');

    if (savedLangCode != null) {
      getCurrentLanguage.value = Locale(savedLangCode);
      isCheckLang.value = langs.indexWhere((lang) => lang.languageCode == savedLangCode);

      Get.updateLocale(Locale(savedLangCode));
    } else {
      getCurrentLanguage.value = Locale('en');
      isCheckLang.value = 1;
      Get.updateLocale(Locale('en'));
    }
  }
}