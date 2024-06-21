import 'package:flutter/material.dart';

class LinearProgress extends StatelessWidget {
  final Color color;
  LinearProgress({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(color: color);
  }
}
