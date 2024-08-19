import 'package:shared_value/shared_value.dart';

final SharedValue<String> accessToken = SharedValue(
  key: "token",
  autosave: true,
  value: "",
);

final SharedValue<int> limitTime = SharedValue(
  key: "timer",
  autosave: true,
  value: 1,
);

final SharedValue<bool> ended = SharedValue(
  key: "ended",
  autosave: true,
  value: false,
);

enum Status { progress, success, fail, error }