import 'dart:async';

import 'package:get/get.dart';
import 'package:market_nest_app/modules/app/controllers/auth_controller.dart';
import 'package:market_nest_app/modules/app/data/globle_variable/public_variable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _auth = Get.find<AuthController>();

class CountdownTimer {
  final BehaviorSubject<Duration> _remainingTimeSubject = BehaviorSubject<Duration>();
  Stream<Duration> get remainingTimeStream => _remainingTimeSubject.stream;
  StreamSubscription<Duration>? _subscription;

  CountdownTimer() {
    _startCountdown();
  }

  Future<void> _startCountdown() async {
    final prefs = await SharedPreferences.getInstance();
    DateTime? nextTarget;

    // Retrieve the saved target time
    final savedTargetTime = prefs.getString('targetTime');
    if (savedTargetTime != null) {
      nextTarget = DateTime.parse(savedTargetTime);
    } else {
      final now = DateTime.now();
      if (limitTime.$ == 3) {
        nextTarget = now.add(const Duration(minutes: 15));
      } else if (limitTime.$ == 4) {
        nextTarget = DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
      } else {
        nextTarget = now.add(const Duration(seconds: 10));
      }
      await prefs.setString('targetTime', nextTarget.toIso8601String());
    }

    Duration remainingTime = nextTarget.difference(DateTime.now());
    if (remainingTime.isNegative) {
      await _handleTimeEnd(prefs);
      return;
    }
    _remainingTimeSubject.add(remainingTime);
    _subscription = Stream.periodic(const Duration(seconds: 1), (_) {
      remainingTime = nextTarget!.difference(DateTime.now());
      return remainingTime;
    }).listen((remainingTime) async {
      _remainingTimeSubject.add(remainingTime);
      if (remainingTime <= Duration.zero || remainingTime.inMilliseconds <= 500) {
        await _handleTimeEnd(prefs);
        _subscription?.cancel();
      }
    });
  }

  Future<void> _handleTimeEnd(SharedPreferences prefs) async {
    _remainingTimeSubject.add(Duration.zero);
    _auth.timerTrigger();
    await prefs.remove('targetTime');
    print("Countdown has ended.");
  }

  void dispose() {
    _subscription?.cancel();
    _remainingTimeSubject.close();
  }
}