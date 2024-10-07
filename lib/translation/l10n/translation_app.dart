import 'package:get/get_navigation/src/root/internacionalization.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'hello': 'Hello',
      'shippingAddress': 'Shipping Address',
      'orderHistory': 'Order History',
      'paymentMethod': 'Payment Method',
      'personalInformation': 'Personal Information',
      'privacyPolicy': 'Privacy Policy',
      'supportInformation': 'Support & Information',
    },

    'km': {
      'hello': 'សួស្តី',
      'shippingAddress': 'អាសយដ្ឋានដឹកជញ្ជូន',
      'orderHistory': 'ប្រវត្តិនៃការបញ្ជាទិញ',
      'paymentMethod': 'វិធីសាស្រ្តទូទាត់',
      'privacyPolicy': 'គោលការណ៍ឯកជនភាព',
      'supportInformation': 'ជំនួយ និងព័ត៌មាន',
      'personalInformation': 'ព័ត៌មានផ្ទាល់ខ្លួន',
    },
  };
}
