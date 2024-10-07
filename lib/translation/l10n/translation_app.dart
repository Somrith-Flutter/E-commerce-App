import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'languages/en.dart';
import 'languages/km.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': en,
    'km': km
  };
}
