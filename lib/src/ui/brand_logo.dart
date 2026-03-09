import 'package:flutter/material.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.size = 180});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/logo.png', width: size, height: size, fit: BoxFit.contain);
  }
}
