import 'package:shared_value/shared_value.dart';

final SharedValue<String> accessToken = SharedValue(
  key: "token",
  autosave: true,
  value: "",
);

enum Status { progress, success, fail, error }