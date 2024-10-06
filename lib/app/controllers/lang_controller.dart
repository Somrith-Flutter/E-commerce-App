import 'package:get/get.dart';
import 'package:market_nest_app/translation/l10n/intl_en.dart';
import 'package:market_nest_app/translation/l10n/intl_kh.dart';
import 'package:market_nest_app/translation/l10n/languages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController implements GetxService {
  Rx<Language> _getCurrentLanguage = KH().obs;
  Language get lang => _getCurrentLanguage.value;
  RxInt isCheckLang = 0.obs;
  List<Language> langs = [
    KH(),
    EN()
  ];

  Future<Language?>? changeAppLanguage({required int index}) async {
    _getCurrentLanguage = langs[index].obs;
    isCheckLang.value = index;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedLanguageIndex', index);
    await loadSavedLanguage();
    update();
    return  null;
  }

  Future<void> loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedIndex = prefs.getInt('selectedLanguageIndex');

    if (savedIndex != null) {
      _getCurrentLanguage = langs[savedIndex].obs;
      isCheckLang.value = savedIndex;
      update();
    }
  }
}