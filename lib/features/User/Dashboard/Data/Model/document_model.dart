import 'package:flutter/material.dart';

class NavItem {
  final String label;
  final IconData icon;
  final bool active;
  final bool indent;
  final bool sectionHeader;

  const NavItem({
    required this.label,
    required this.icon,
    this.active = false,
    this.indent = false,
    this.sectionHeader = false,
  });
}

class DocTabItem {
  final String key;
  final String label;

  const DocTabItem({required this.key, required this.label});
}
