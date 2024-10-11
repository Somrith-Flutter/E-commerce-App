import 'dart:async';
import 'package:get/get.dart';
import 'package:market_nest_app/app/controllers/auth_controller.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _auth = Get.find<AuthController>();

class CountdownTimer {
  final BehaviorSubject<Duration> _remainingTimeSubject = BehaviorSubject<Duration>();
  Stream<Duration> get remainingTimeStream => _remainingTimeSubject.stream;
  StreamSubscription<Duration>? _subscription;
  bool _isTimerRunning = false; // To track if the timer is already running

  CountdownTimer() {
    _startCountdown();
  }

  Future<void> _startCountdown() async {
    if (_isTimerRunning) {
      // Prevent the countdown from starting again if it's already running
      return;
    }

    _isTimerRunning = true; // Mark the timer as running

    final prefs = await SharedPreferences.getInstance();
    DateTime? nextTarget;
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
        nextTarget = now.add(const Duration(seconds: 30));
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
      if (remainingTime <= Duration.zero) {
        await _handleTimeEnd(prefs);
      } else {
        _remainingTimeSubject.add(remainingTime);
      }
    });
  }

  Future<void> _handleTimeEnd(SharedPreferences prefs) async {
    if (!_isTimerRunning) return;

    _subscription?.cancel();
    _remainingTimeSubject.add(Duration.zero);
    _auth.timerTrigger();
    await prefs.remove('targetTime');

    _isTimerRunning = false;
  }

  Future<void> clear() async {
    _subscription?.cancel();
    _remainingTimeSubject.add(Duration.zero);
    _isTimerRunning = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('targetTime');
  }

  void dispose() {
    _subscription?.cancel();
    _remainingTimeSubject.close();
  }
}

int getColorFromName(String colorName) {
  switch (colorName.toLowerCase()) {
    case 'red':
      return 0xFFFF0000;
    case 'blue':
      return 0xFF0000FF;
    case 'green':
      return 0xFF00FF00;
    case 'yellow':
      return 0xFFFFFF00;
    case 'black':
      return 0xFF000000;
    case 'white':
      return 0xFFFFFFFF;
    case 'purple':
      return 0xFF800080;
    case 'orange':
      return 0xFFFFA500;
    case 'pink':
      return 0xFFFFC0CB;
    case 'cyan':
      return 0xFF00FFFF;
    case 'magenta':
      return 0xFFFF00FF;
    case 'brown':
      return 0xFFA52A2A;
    case 'lime':
      return 0xFF00FF00;
    case 'gray':
      return 0xFF808080;
    case 'maroon':
      return 0xFF800000;
    case 'olive':
      return 0xFF808000;
    case 'navy':
      return 0xFF000080;
    case 'teal':
      return 0xFF008080;
    case 'aqua':
      return 0xFF00FFFF;
    case 'silver':
      return 0xFFC0C0C0;
    case 'gold':
      return 0xFFFFD700;
    case 'coral':
      return 0xFFFF7F50;
    case 'khaki':
      return 0xFFF0E68C;
    case 'plum':
      return 0xFFDDA0DD;
    case 'orchid':
      return 0xFFDA70D6;
    case 'salmon':
      return 0xFFFA8072;
    case 'indigo':
      return 0xFF4B0082;
    case 'violet':
      return 0xFFEE82EE;
    case 'turquoise':
      return 0xFF40E0D0;
    case 'peru':
      return 0xFFCD853F;
    case 'tan':
      return 0xFFD2B48C;
    case 'chocolate':
      return 0xFFD2691E;
    case 'sienna':
      return 0xFFA0522D;
    case 'orchid':
      return 0xFFDA70D6;
    case 'azure':
      return 0xFFF0FFFF;
    case 'lavender':
      return 0xFFE6E6FA;
    case 'beige':
      return 0xFFF5F5DC;
    case 'wheat':
      return 0xFFF5DEB3;
    case 'mint':
      return 0xFF98FF98;
    case 'aliceblue':
      return 0xFFF0F8FF;
    case 'bisque':
      return 0xFFFFE4C4;
    case 'blanchedalmond':
      return 0xFFFFEBCD;
    case 'lightcyan':
      return 0xFFE0FFFF;
    case 'powderblue':
      return 0xFFB0E0E6;
    case 'peachpuff':
      return 0xFFFFDAB9;
    case 'mistyrose':
      return 0xFFFFE4E1;
    case 'lightpink':
      return 0xFFFFB6C1;
    case 'crimson':
      return 0xFFDC143C;
    case 'darkorange':
      return 0xFFFF8C00;
    case 'darkred':
      return 0xFF8B0000;
    case 'darkblue':
      return 0xFF00008B;
    case 'darkgreen':
      return 0xFF006400;
    case 'darkviolet':
      return 0xFF9400D3;
    case 'darkcyan':
      return 0xFF008B8B;
    case 'darkmagenta':
      return 0xFF8B008B;
    case 'lightcoral':
      return 0xFFF08080;
    case 'lightsalmon':
      return 0xFFFFA07A;
    case 'lightseagreen':
      return 0xFF20B2AA;
    case 'lightsteelblue':
      return 0xFFB0C4DE;
    case 'mediumaquamarine':
      return 0xFF66CDAA;
    case 'mediumblue':
      return 0xFF0000CD;
    case 'mediumorchid':
      return 0xFFBA55D3;
    case 'mediumpurple':
      return 0xFF9370DB;
    case 'mediumseagreen':
      return 0xFF3CB371;
    case 'mediumslateblue':
      return 0xFF7B68EE;
    case 'mediumspringgreen':
      return 0xFF00FA9A;
    case 'mediumturquoise':
      return 0xFF48D1CC;
    case 'mediumvioletred':
      return 0xFFC71585;
    case 'midnightblue':
      return 0xFF191970;
    case 'royalblue':
      return 0xFF4169E1;
    case 'springgreen':
      return 0xFF00FF7F;
    case 'steelblue':
      return 0xFF4682B4;
    case 'forestgreen':
      return 0xFF228B22;
    case 'seagreen':
      return 0xFF2E8B57;
    case 'dodgerblue':
      return 0xFF1E90FF;
    case 'limegreen':
      return 0xFF32CD32;
    case 'lightgray':
      return 0xFFD3D3D3;
    case 'slateblue':
      return 0xFF6A5ACD;
    case 'tomato':
      return 0xFFFF6347;
    case 'sandybrown':
      return 0xFFF4A460;
    case 'hotpink':
      return 0xFFFF69B4;
    case 'deeppink':
      return 0xFFFF1493;
    case 'darkkhaki':
      return 0xFFBDB76B;
    case 'palegreen':
      return 0xFF98FB98;
    case 'lightskyblue':
      return 0xFF87CEFA;
    case 'slategray':
      return 0xFF708090;
    case 'darkslategray':
      return 0xFF2F4F4F;
    case 'rosybrown':
      return 0xFFBC8F8F;
    case 'thistle':
      return 0xFFD8BFD8;
    case 'gainsboro':
      return 0xFFDCDCDC;
    case 'lightgoldenrodyellow':
      return 0xFFFAFAD2;
    case 'honeydew':
      return 0xFFF0FFF0;
    case 'ivory':
      return 0xFFFFFFF0;
    case 'snow':
      return 0xFFFFFAFA;
    case 'lemonchiffon':
      return 0xFFFFFACD;
    case 'papayawhip':
      return 0xFFFFEFD5;
    case 'oldlace':
      return 0xFFFDF5E6;
    case 'seashell':
      return 0xFFFFF5EE;
    case 'lightyellow':
      return 0xFFFFFFE0;
    case 'floralwhite':
      return 0xFFFFFAF0;
    case 'ghostwhite':
      return 0xFFF8F8FF;
    case 'antiquewhite':
      return 0xFFFAEBD7;
    case 'linen':
      return 0xFFFAF0E6;
    case 'darkgoldenrod':
      return 0xFFB8860B;
    case 'dimgray':
      return 0xFF696969;
    case 'darkslateblue':
      return 0xFF483D8B;
    default:
      return 0xFF000000; // Fallback to black if unknown color
  }
}