import 'package:flutter/material.dart';
import 'package:getcare360/core/constant/app_color.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';
// If you want Drawer like the screenshot, uncomment:
// import 'package:getcare360/core/widget/user_side_drawer.dart';
// import 'package:getcare360/features/User/Dashboard/Data/Model/drawer_model.dart';
// import 'package:getcare360/features/User/Dashboard/Presentation/Widgets/navigation_file.dart';

class SignedDocumentsPage extends StatelessWidget {
  const SignedDocumentsPage({super.key});

  static const _maxWidth = 1300.0;

  @override
  Widget build(BuildContext context) {
    final docs = const <SignedDocItem>[
      SignedDocItem(title: "Employment Contract - Assistant in Nursing"),
      SignedDocItem(title: "NDIS Code of Conduct"),
      SignedDocItem(title: "Offer of Employment"),
      SignedDocItem(title: "Position Description - Assistant in Nursing"),
      SignedDocItem(title: "Worker Confidentiality Statement"),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),

      // If you want drawer like screenshot:
      // drawer: SideDrawer(
      //   headerName: "Akriti Pandey",
      //   headerSub: "THC-3485",
      //   onNavigate: (route) => handleNavigation(context, route),
      // ),
      appBar: CustomAppBar(title: 'Signed Documents', centerTitle: true),

      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxWidth),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
            children: [
              const _HeaderRow(
                title: "Signed Documents",
                breadcrumb: "Dashboard  >  Signed Documents",
              ),
              const SizedBox(height: 14),

              _SignedDocsGrid(
                items: docs,
                onOpen: (doc) {
                  // TODO: open/view document
                  // Navigator.push(...);
                },
              ),
              const SizedBox(height: 22),

              // Footer purple strip like your app (optional)
              Container(
                height: 44,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.sideBg,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
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
      ),
    );
  }
}

/* ----------------------- UI PARTS ------------------------ */

class SignedDocItem {
  final String title;
  const SignedDocItem({required this.title});
}

class _HeaderRow extends StatelessWidget {
  final String title;
  final String breadcrumb;

  const _HeaderRow({required this.title, required this.breadcrumb});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final small = c.maxWidth < 640;

        final titleWidget = Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
        );

        final crumb = Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.home_outlined, size: 16, color: Colors.grey.shade700),
              const SizedBox(width: 8),
              Text(
                breadcrumb,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );

        if (small) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget,
              const SizedBox(height: 10),
              Align(alignment: Alignment.centerLeft, child: crumb),
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: titleWidget),
            crumb,
          ],
        );
      },
    );
  }
}

class _SignedDocsGrid extends StatelessWidget {
  final List<SignedDocItem> items;
  final void Function(SignedDocItem doc) onOpen;

  const _SignedDocsGrid({required this.items, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        // Breakpoints tuned for web/desktop like screenshot
        int cols = 1;
        if (c.maxWidth >= 1100)
          cols = 3;
        else if (c.maxWidth >= 720)
          cols = 2;

        const spacing = 16.0;
        final w = (c.maxWidth - (cols - 1) * spacing) / cols;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: items
              .map(
                (doc) => SizedBox(
                  width: w,
                  child: _SignedDocCard(
                    title: doc.title,
                    onTap: () => onOpen(doc),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _SignedDocCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _SignedDocCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF00E0C3), // teal like screenshot
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      shadowColor: Colors.black12,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 92,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Click here to view",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ----------------------- TOP APP BAR WIDGETS ------------------------ */

class _BrandTitle extends StatelessWidget {
  const _BrandTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          "getup",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        Text(
          "ai",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color(0xFFDB2777),
          ),
        ),
      ],
    );
  }
}

class _NotificationBadge extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const _NotificationBadge({required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onTap,
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
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _UserChip extends StatelessWidget {
  final String name;
  const _UserChip({required this.name});

  @override
  Widget build(BuildContext context) {
    final small = MediaQuery.of(context).size.width < 420;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(radius: 11, backgroundColor: Color(0xFFE5E7EB)),
          if (!small) ...[
            const SizedBox(width: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 160),
              child: Text(
                name,
                maxLines: 1,
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
