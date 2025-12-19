import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_drawer.dart';
import 'package:getcare360/core/widget/dashboard_card.dart';
import 'package:getcare360/core/widget/navigator_helper.dart';
import 'package:getcare360/features/Dashboard/presentation/screen/home_page.dart';
import 'package:getcare360/features/HomeCare/presentation/widget/homecare_menu_list.dart';

class HomeCare extends StatefulWidget {
  const HomeCare({super.key});

  @override
  State<HomeCare> createState() => _HomeCareState();
}

class _HomeCareState extends State<HomeCare> {
  String _selected = "dashboard";

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 980;

    final scaffold = Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: isDesktop
            ? null
            : Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black87),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                ),
              ),
        title: const Text(
          "Admin - Dashboard",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black87),
          ),
          const SizedBox(width: 8),
          const Padding(
            padding: EdgeInsets.only(right: 14),
            child: Row(
              children: [
                Text(
                  "Hi, Triniti Admin",
                  style: TextStyle(color: Colors.black87),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFFB012A5),
                  child: Text(
                    "T",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      drawer: isDesktop
          ? null
          : Drawer(
              child: UniversalCustomDrawer(
                style: UniversalDrawerStyle.purple(),
                items: homecareDrawerItems,
                selectedKey: _selected,
                onSelect: (key) {
                  if (key == "dashboard") {
                    NavigatorHelper.pushAndRemoveUntil(
                      context,
                      const HomePage(),
                    );
                    return;
                  }
                  setState(() => _selected = key);
                  Navigator.pop(context);
                },
                title: "getup",
                subtitle: "Admin Panel",
              ),
            ),

      body: isDesktop
          ? Row(
              children: [
                UniversalCustomDrawer(
                  style: UniversalDrawerStyle.purple(),
                  items: homecareDrawerItems,
                  selectedKey: _selected,
                  onSelect: (key) => setState(() => _selected = key),
                  title: "getup",
                  subtitle: "Admin Panel",
                ),
                Expanded(child: _BodyArea(selectedKey: _selected)),
              ],
            )
          : _BodyArea(selectedKey: _selected),
    );

    return scaffold;
  }
}

/// Example content area (replace with your real pages)
class _BodyArea extends StatelessWidget {
  final String selectedKey;
  const _BodyArea({required this.selectedKey});

  @override
  Widget build(BuildContext context) {
    // For your screenshot-like dashboard cards
    if (selectedKey == "dashboard") {
      return Padding(
        padding: const EdgeInsets.all(18),
        child: LayoutBuilder(
          builder: (ctx, c) {
            final w = c.maxWidth;
            final isWide = w >= 900;
            return Wrap(
              spacing: 18,
              runSpacing: 18,
              children: [
                DashboardCard(
                  width: isWide ? (w / 2) - 18 : w,
                  title: "Staffs",
                  icon: Icons.group,
                ),
              ],
            );
          },
        ),
      );
    }

    // Generic placeholder for navigation destinations
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          "Selected: $selectedKey",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
