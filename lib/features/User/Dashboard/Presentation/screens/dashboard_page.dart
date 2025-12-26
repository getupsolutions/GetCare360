import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getcare360/core/constant/app_color.dart';
import 'package:getcare360/core/widget/user_side_drawer.dart';
import 'package:getcare360/features/User/Dashboard/Data/Model/drawer_model.dart';
import 'package:getcare360/features/User/Dashboard/Presentation/Bloc/drawer_bloc.dart';
import 'package:getcare360/features/User/Dashboard/Presentation/Widgets/navigation_file.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static const _drawerWidth = 270.0;

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DrawerBloc>().add(
        const DrawerRouteSelected(DrawerRouteKey.dashboard),
      );
    });
  }

  void _handleNavigation(DrawerRouteKey route) {
    handleNavigation(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final desktop = isDesktop(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF3F5F9),
      drawer: desktop
          ? null
          : SideDrawer(
              headerName: "Akriti Pandey",
              headerSub: "THC-3485",
              onNavigate: _handleNavigation,
            ),
      body: SafeArea(
        child: Row(
          children: [
            if (desktop)
              SizedBox(
                width: _drawerWidth,
                child: SideDrawer(
                  headerName: "Akriti Pandey",
                  headerSub: "THC-3485",
                  asPermanent: true,
                  onNavigate: _handleNavigation,
                ),
              ),
            Expanded(
              child: Column(
                children: [
                  _TopBar(
                    onMenuTap: desktop
                        ? null
                        : () => _scaffoldKey.currentState?.openDrawer(),
                    userName: "Akriti Pandey",
                    notificationCount: 121,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1300),
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                          children: const [
                            _DashboardHeader(),
                            SizedBox(height: 14),
                            _ActionCardsRow(),
                            SizedBox(height: 26),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Footer like screenshot
                  Container(
                    height: 44,
                    width: double.infinity,
                    alignment: Alignment.center,
                    color: AppColors.sideBg, // purple strip
                    child: const Text(
                      "2025 © All rights reserved",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* -----------------------
   TOP BAR (matches image)
------------------------*/
class _TopBar extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final String userName;
  final int notificationCount;

  const _TopBar({
    required this.onMenuTap,
    required this.userName,
    required this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final compact = w < 520;

    return Material(
      color: Colors.white,
      elevation: 0.5,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            if (onMenuTap != null)
              IconButton(
                onPressed: onMenuTap,
                icon: const Icon(Icons.menu),
                tooltip: "Menu",
              ),

            // Logo
            const SizedBox(width: 6),
            const _Brand(),

            const Spacer(),

            if (!compact)
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.fullscreen),
                tooltip: "Fullscreen",
              ),

            _NotificationButton(count: notificationCount),

            const SizedBox(width: 10),
            _ProfileChip(name: userName),
          ],
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          "getup",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        Text(
          "ai",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Color(0xFFDB2777),
          ),
        ),
      ],
    );
  }
}

class _NotificationButton extends StatelessWidget {
  final int count;
  const _NotificationButton({required this.count});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
          tooltip: "Notifications",
        ),
        if (count > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                count > 999 ? "999+" : "$count",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ProfileChip extends StatelessWidget {
  final String name;
  const _ProfileChip({required this.name});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final small = w < 420;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(radius: 12, backgroundColor: Color(0xFFE5E7EB)),
          if (!small) ...[
            const SizedBox(width: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 140),
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/* -----------------------
   HEADER (Dashboard + pill)
------------------------*/
class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Dashboard",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Text(
            "Dashboard",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

/* -----------------------
   ACTION CARDS (3 cards)
------------------------*/
class _ActionCardsRow extends StatelessWidget {
  const _ActionCardsRow();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        // breakpoints
        int columns = 1;
        if (c.maxWidth >= 1100) {
          columns = 3;
        } else if (c.maxWidth >= 720) {
          columns = 2;
        }

        const spacing = 16.0;
        final cardW = (c.maxWidth - (columns - 1) * spacing) / columns;

        final items = <_DashCardData>[
          _DashCardData(
            title: "Available Shift",
            subtitle: "Click here",
            bg: const Color(0xFFFFC04D),
            iconBg: const Color(0xFFB8841B),
            icon: Icons.person_outline,
            onTap: () {},
          ),
          _DashCardData(
            title: "My Roster",
            subtitle: "Click here",
            bg: const Color(0xFF5B88FF),
            iconBg: const Color(0xFF2E5FD6),
            icon: Icons.phone_iphone,
            onTap: () {},
          ),
          _DashCardData(
            title: "Clock in & Clock Out",
            subtitle: "Click here",
            bg: const Color(0xFFFF3C86),
            iconBg: const Color(0xFFB31656),
            icon: Icons.menu_book_outlined,
            onTap: () {},
          ),
        ];

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: items
              .map(
                (e) => SizedBox(
                  width: cardW,
                  child: _DashActionCard(data: e),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _DashCardData {
  final String title;
  final String subtitle;
  final Color bg;
  final Color iconBg;
  final IconData icon;
  final VoidCallback onTap;

  _DashCardData({
    required this.title,
    required this.subtitle,
    required this.bg,
    required this.iconBg,
    required this.icon,
    required this.onTap,
  });
}

class _DashActionCard extends StatelessWidget {
  final _DashCardData data;
  const _DashActionCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: data.bg,
      borderRadius: BorderRadius.circular(12),
      elevation: 2,
      shadowColor: Colors.black12,
      child: InkWell(
        onTap: data.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 92,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  color: data.iconBg.withOpacity(0.35),
                  shape: BoxShape.circle,
                ),
                child: Icon(data.icon, color: Colors.white, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      data.subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
