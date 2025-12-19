import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Drawer gradient
  static const Color drawerBg1 = Color(0xFFB012A5);
  static const Color drawerBg2 = Color(0xFF8F0CA0);

  // Drawer text/icons
  static const Color drawerText = Colors.white;
  static const Color drawerTextMuted = Colors.white70;
  static const Color drawerIcon = Colors.white;

  // Drawer states (same opacity as your old drawer)
  static final Color drawerSelectedTile = Colors.white.withAlpha(180);
  static final Color drawerExpandedGroup = Colors.white.withAlpha(100);

  // Header chip
  static final Color drawerHeaderChip = Colors.white.withAlpha(160);
  static final Color drawerHeaderLogoBg = Colors.white.withAlpha(150);

  static const purple = Color(0xFFA020A0);
  static const pageBg = Color(0xFFF4F6FB);
  static const cardBg = Colors.white;

  static const success = Color(0xFF22C55E);
  static const danger = Color(0xFFEF4444);
  static const infoChipBg = Color(0xFFBDEFF2);
  static const infoChipText = Color(0xFF0F766E);
}
