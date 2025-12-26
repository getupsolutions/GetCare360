import 'dart:math';
import 'package:flutter/material.dart';
import 'package:getcare360/features/Admin/AdminAccount/presentation/screen/admin_page.dart';
import 'package:getcare360/features/Admin/Agency/presentation/screen/agency_page.dart';
import 'package:getcare360/features/Admin/Dashboard/presentation/widget/card_shell.dart';
import 'package:getcare360/features/Admin/Dashboard/presentation/widget/home_tile.dart';
import 'package:getcare360/core/widget/navigator_helper.dart';
import 'package:getcare360/features/Admin/HomeCare/presentation/screen/home_care_page.dart';
import 'package:getcare360/features/Admin/Ndis/presentation/screen/ndis_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBDBDC4), // grey backdrop like screenshot
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final h = constraints.maxHeight;

              // Responsive card sizing
              final cardWidth = w >= 1200
                  ? 760.0
                  : w >= 900
                  ? 720.0
                  : min(w * 0.92, 720.0);

              final cardPadding = w < 500 ? 16.0 : 22.0;

              // Grid sizing (2 columns always, like screenshot)
              final gap = w < 500 ? 12.0 : 18.0;
              final tileHeight = w < 500 ? 88.0 : 102.0;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: max(16, h * 0.06),
                  horizontal: 12,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: cardWidth),
                  child: CardShell(
                    padding: cardPadding,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                "Welcome to Triniti Home Care",
                                style: TextStyle(
                                  fontSize: w < 500 ? 16 : 18,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1F1F2D),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const GetupAiLogo(),
                          ],
                        ),

                        const SizedBox(height: 14),
                        Divider(height: 1, color: const Color(0xFFE7E7EE)),
                        const SizedBox(height: 18),

                        // 2x2 tiles
                        GridView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: gap,
                                crossAxisSpacing: gap,
                                mainAxisExtent: tileHeight,
                              ),
                          children: [
                            HomeTile(
                              bg: const Color(0xFFBFD6F5),
                              icon: Icons.accessible,
                              title: "NDIS",
                              onTap: () {
                                NavigatorHelper.push(context, NdisPage());
                              },
                            ),
                            HomeTile(
                              bg: const Color(0xFFF5D1F4),
                              icon: Icons.apartment,
                              title: "Agency",
                              onTap: () {
                                debugPrint("Agency Clicked");
                                NavigatorHelper.push(context, AgencyPage());
                              },
                            ),
                            HomeTile(
                              bg: const Color(0xFF4D7EF7),
                              icon: Icons.person,
                              title: "Home Care",
                              titleColor: Colors.black,
                              onTap: () {
                                NavigatorHelper.push(context, HomeCare());
                              },
                            ),
                            HomeTile(
                              bg: const Color(0xFFF6DB9C),
                              icon: Icons.account_balance_wallet_outlined,
                              title: "Admin Account",
                              onTap: () {
                                NavigatorHelper.push(context, AdminPage());
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
