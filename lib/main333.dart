// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:one_desk/screens/login/login.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// import 'constants/colors/colors.dart';
// import 'cubit/theme/theme_cubit.dart';
// import 'cubit/theme/theme_state.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Initialize Hive
//   await Hive.initFlutter();
//
//   // Open Hive box for storing theme data
//   await Hive.openBox('themeBox');
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(create: (_)=> ThemeCubit(),
//
//     child: BlocBuilder<ThemeCubit, ThemeState>(
//       builder: (context, state) {
//         return  MaterialApp(
//           theme: ThemeData(
//             useMaterial3: true,
//             appBarTheme: AppBarTheme(
//               backgroundColor: state.maybeWhen(
//                 lightMode: () => Colors.white,
//                 darkMode: () => Colors.black,
//                 orElse: () => Colors.white,
//               ),
//             ),
//           ),
//           home: const Login(),
//         );
//       },
//     ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//



import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DistanceTracker(),
    );
  }
}

class DistanceTracker extends StatefulWidget {
  @override
  _DistanceTrackerState createState() => _DistanceTrackerState();
}

class _DistanceTrackerState extends State<DistanceTracker> {
  Position? _previousPosition;
  double _totalDistance = 0.0;
  bool _isTracking = false;
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;
  DateTime? _startTime;
  StreamSubscription<Position>? _positionStream;

  @override
  void dispose() {
    _timer?.cancel();
    _positionStream?.cancel();
    super.dispose();
  }

  Future<bool> _checkPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('GPS yoqilmagan. Iltimos, yoqing.')),
      );
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Joylashuv ruxsati rad etildi.')),
        );
        return false;
      }
    }
    return true;
  }

  void _startTracking() async {
    if (await _checkPermissions()) {
      setState(() {
        _isTracking = true;
        _totalDistance = 0.0;
        _elapsedTime = Duration.zero;
        _startTime = DateTime.now();
      });

      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedTime = DateTime.now().difference(_startTime!);
        });
      });

      _positionStream = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 5,
        ),
      ).listen((Position position) {
        if (_previousPosition != null) {
          double distanceInMeters = Geolocator.distanceBetween(
            _previousPosition!.latitude,
            _previousPosition!.longitude,
            position.latitude,
            position.longitude,
          );
          setState(() {
            _totalDistance += distanceInMeters / 1000;
          });
        }
        _previousPosition = position;
      });
    }
  }

  void _stopTracking() {
    setState(() {
      _isTracking = false;
    });
    _timer?.cancel();
    _positionStream?.cancel();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Taksi Masofa Hisoblagich')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Yurilgan masofa: ${_totalDistance.toStringAsFixed(2)} km',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Vaqt: ${_formatDuration(_elapsedTime)}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 40),
            if (!_isTracking)
              ElevatedButton(
                onPressed: _startTracking,
                child: Text('Boshlash'),
              ),
            if (_isTracking)
              ElevatedButton(
                onPressed: _stopTracking,
                child: Text('Tugatish'),
              ),
          ],
        ),
      ),
    );
  }
}