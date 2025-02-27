import 'package:flutter/material.dart';

class PointsWithColor extends StatelessWidget {
  final Color? colour;
  final margin;
  const PointsWithColor({super.key, this.colour, this.margin});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 9.0,
      width: 9.0,
      margin: margin,
      decoration: BoxDecoration(
          color: colour, borderRadius: const BorderRadius.all(Radius.circular(10.0))),
    );
  }
}

class Points extends StatelessWidget {
  const Points({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3.0, top: 10.0),
      decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
//              margin: EdgeInsets.only(left: 100.0),

      height: 3.0,
      width: 3.0,
    );
  }
}
