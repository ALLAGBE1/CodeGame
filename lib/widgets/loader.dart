import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitFadingCircle(
      color: Colors.blueAccent,
      duration: Duration(milliseconds: 1200),
      size: 100.0,
    );
  }
}
