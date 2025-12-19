import 'package:flutter/material.dart';

class Responsive {
  static double w(BuildContext c) => MediaQuery.of(c).size.width;

  static bool isMobile(BuildContext c) => w(c) < 600;
  static bool isTablet(BuildContext c) => w(c) >= 600 && w(c) < 1024;
  static bool isDesktop(BuildContext c) => w(c) >= 1024;
}
