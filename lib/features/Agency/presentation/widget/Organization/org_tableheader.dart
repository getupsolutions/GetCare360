import 'package:flutter/material.dart';

class OrgTableHeader extends StatelessWidget {
  final bool isTablet;
  const OrgTableHeader({super.key, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: Color(0xFF3B3B3B),
    );

    // Tablet shows fewer columns (prevents cramped UI)
    if (isTablet) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: const Row(
          children: [
            SizedBox(width: 50, child: Text("SL\nNo.", style: style)),
            SizedBox(width: 200, child: Text("Name", style: style)),
            SizedBox(width: 240, child: Text("Contact", style: style)),
            SizedBox(width: 160, child: Text("Status", style: style)),
            SizedBox(width: 160, child: Text("Action", style: style)),
          ],
        ),
      );
    }

    // Desktop full header
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: const Row(
        children: [
          SizedBox(width: 50, child: Text("SL\nNo.", style: style)),
          SizedBox(width: 200, child: Text("Name", style: style)),
          SizedBox(width: 260, child: Text("Contact", style: style)),
          SizedBox(width: 260, child: Text("Services", style: style)),
          SizedBox(width: 220, child: Text("Group", style: style)),
          SizedBox(width: 120, child: Text("Reg.\nDate", style: style)),
          SizedBox(width: 130, child: Text("Status", style: style)),
          SizedBox(width: 160, child: Text("Action", style: style)),
        ],
      ),
    );
  }
}
