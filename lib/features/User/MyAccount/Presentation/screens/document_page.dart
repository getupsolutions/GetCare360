import 'package:flutter/material.dart';
import 'package:getcare360/core/constant/app_color.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class MyAccountDocumentsPage extends StatefulWidget {
  const MyAccountDocumentsPage({super.key});

  @override
  State<MyAccountDocumentsPage> createState() => _MyAccountDocumentsPageState();
}

class _MyAccountDocumentsPageState extends State<MyAccountDocumentsPage> {
  final tabs = const <_DocTab>[
    _DocTab(key: _DocTabKey.points100, label: "100 points ID"),
    _DocTab(key: _DocTabKey.covid, label: "Covid 19 Certificate"),
    _DocTab(key: _DocTabKey.qual, label: "Qualification Certificates"),
    _DocTab(key: _DocTabKey.relevant, label: "Other Relevant Documents"),
    _DocTab(key: _DocTabKey.additional, label: "Additional files"),
  ];

  _DocTabKey active = _DocTabKey.points100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: CustomAppBar(title: 'My Account Documents', centerTitle: true),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
            children: [
              _TabsBar(
                tabs: tabs,
                active: active,
                onChanged: (k) => setState(() => active = k),
              ),
              const SizedBox(height: 14),
              _TabBody(active: active),
              const SizedBox(height: 16),
              const _FooterInfoCard(
                email: "admin@triniticare.com.au",
                text:
                    "If there are any changes to details, please upload the relevant documents in the appropriate section. "
                    "Please note that any changes in tax preferences or banking details must be emailed to ",
              ),
              const SizedBox(height: 14),
              const _UsefulLinksCard(),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------------- Tabs strip (top) ---------------- */

enum _DocTabKey { points100, covid, qual, relevant, additional }

class _DocTab {
  final _DocTabKey key;
  final String label;
  const _DocTab({required this.key, required this.label});
}

class _TabsBar extends StatelessWidget {
  final List<_DocTab> tabs;
  final _DocTabKey active;
  final ValueChanged<_DocTabKey> onChanged;

  const _TabsBar({
    required this.tabs,
    required this.active,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF6F3FF),
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(
        height: 52,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemCount: tabs.length,
          separatorBuilder: (_, __) =>
              const VerticalDivider(width: 1, thickness: 1),
          itemBuilder: (context, i) {
            final t = tabs[i];
            final isActive = t.key == active;

            return InkWell(
              onTap: () => onChanged(t.key),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isActive
                          ? AppColors.brandPurple
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Text(
                  t.label,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: isActive
                        ? AppColors.brandPurple
                        : Colors.blueGrey.shade700,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/* ---------------- Body per tab ---------------- */

class _TabBody extends StatelessWidget {
  final _DocTabKey active;
  const _TabBody({required this.active});

  @override
  Widget build(BuildContext context) {
    switch (active) {
      case _DocTabKey.points100:
        return const _Points100Tab();
      case _DocTabKey.covid:
        return const _CovidTab();
      case _DocTabKey.qual:
        return const _QualificationTab();
      case _DocTabKey.relevant:
        return const _RelevantTab();
      case _DocTabKey.additional:
        return const _AdditionalTab();
    }
  }
}

/* ---------- Shared header (title + button) ---------- */

class _PageHeader extends StatelessWidget {
  final String title;
  final bool requiredStar;
  final String subtitle;
  final String actionText;
  final VoidCallback onAction;

  const _PageHeader({
    required this.title,
    required this.requiredStar,
    required this.subtitle,
    required this.actionText,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final stacked = w < 720;

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (requiredStar)
              const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Text(
                  "*",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    final btn = SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00C2A8),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onAction,
        child: Text(
          actionText,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );

    if (stacked) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              left,
              const SizedBox(height: 12),
              Align(alignment: Alignment.centerLeft, child: btn),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: left),
            const SizedBox(width: 12),
            btn,
          ],
        ),
      ),
    );
  }
}

/* ---------- Document card grid + card widget ---------- */

class _DocItem {
  final String title;
  final bool required;
  final String? addedOn;
  final bool showEditView;
  final bool showAddOnly;
  final Color tint;

  const _DocItem({
    required this.title,
    this.required = false,
    this.addedOn,
    this.showEditView = true,
    this.showAddOnly = false,
    required this.tint,
  });
}

class _DocGrid extends StatelessWidget {
  final List<_DocItem> items;
  const _DocGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        int cols = 1;
        if (c.maxWidth >= 1100)
          cols = 3;
        else if (c.maxWidth >= 760)
          cols = 2;

        const spacing = 14.0;
        final w = (c.maxWidth - (cols - 1) * spacing) / cols;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: items
              .map(
                (e) => SizedBox(
                  width: w,
                  child: _DocCard(item: e),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _DocCard extends StatelessWidget {
  final _DocItem item;
  const _DocCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: item.tint,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                if (item.required)
                  const Text(
                    "*",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Added On",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(":", style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.addedOn ?? "-",
                    style: TextStyle(
                      color: Colors.red.shade400,
                      fontWeight: FontWeight.w800,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (item.showAddOnly)
                  _SmallBtn(
                    label: "Add",
                    bg: AppColors.brandPurple,
                    fg: Colors.white,
                    onTap: () {},
                  ),
                if (!item.showAddOnly && item.showEditView) ...[
                  _SmallBtn(
                    label: "Edit",
                    bg: AppColors.brandPurple,
                    fg: Colors.white,
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  _SmallBtn(
                    label: "View",
                    bg: const Color(0xFF00C2A8),
                    fg: Colors.white,
                    onTap: () {},
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallBtn extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;

  const _SmallBtn({
    required this.label,
    required this.bg,
    required this.fg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(horizontal: 18),
        ),
        onPressed: onTap,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}

/* ---------------- Individual tabs (match screenshots) ---------------- */

class _Points100Tab extends StatelessWidget {
  const _Points100Tab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PageHeader(
          title: "100 points ID",
          requiredStar: true,
          subtitle: "Please add atleast three 100 points documents",
          actionText: "Add 100 points id",
          onAction: () {},
        ),
        const SizedBox(height: 14),
        const _NotesCard(
          bullets: [
            "The 100 point identification check must be completed and uploaded.",
            "Only certified copies of documents should be submitted to meet the 100-point check requirements.",
            "Identification must be current and should include at least one type of photographic ID and identification that contains a signature and date of birth.",
            "The point score of the documents produced must total at least 100 points.",
          ],
        ),
        const SizedBox(height: 14),
        _DocGrid(
          items: const [
            _DocItem(
              title:
                  "Current passport from another country or diplomatic documents (70)",
              required: false,
              addedOn: "15 Dec 2024 11:43 AM",
              tint: Color(0xFFE6FBFF),
            ),
            _DocItem(
              title:
                  "Identification card issued to a student at a tertiary education institution (40)",
              addedOn: "17 Dec 2024 10:11 AM",
              tint: Color(0xFFE6FBFF),
            ),
            _DocItem(
              title: "Current telephone, water, gas or electricity bill (25)",
              addedOn: "18 Dec 2024 07:47 AM",
              tint: Color(0xFFE6FBFF),
            ),
          ],
        ),
      ],
    );
  }
}

class _CovidTab extends StatelessWidget {
  const _CovidTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PageHeader(
          title: "Covid 19 Immunization Certificate",
          requiredStar: true,
          subtitle: "",
          actionText: "Add Covid 19 Certificate",
          onAction: () {},
        ),
        const SizedBox(height: 14),
        _DocGrid(
          items: const [
            _DocItem(
              title: "Covid 19 immunization",
              required: false,
              addedOn: "17 Dec 2024 10:12 AM",
              tint: Color(0xFFFFF1E8),
            ),
          ],
        ),
      ],
    );
  }
}

class _QualificationTab extends StatelessWidget {
  const _QualificationTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PageHeader(
          title: "Qualification Certificates",
          requiredStar: true,
          subtitle: "Certified copies required",
          actionText: "Add Qualification Certificates",
          onAction: () {},
        ),
        const SizedBox(height: 14),
        _DocGrid(
          items: const [
            _DocItem(
              title: "CERTIFICATE IV in Ageing Support",
              required: false,
              addedOn: "17 Dec 2024 10:17 AM",
              tint: Color(0xFFFFF1E8),
            ),
            _DocItem(
              title: "Placement completion",
              required: false,
              addedOn: "17 Dec 2024 10:17 AM",
              tint: Color(0xFFFFF1E8),
            ),
          ],
        ),
      ],
    );
  }
}

class _RelevantTab extends StatelessWidget {
  const _RelevantTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Card(
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Other Relevant Documents",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        _DocGrid(
          items: const [
            _DocItem(
              title: "Police Check",
              required: true,
              addedOn: "17 Dec 2024 10:21 AM",
              tint: Color(0xFFFFF1E8),
            ),
            _DocItem(
              title: "NDIS Workers Screening",
              required: true,
              addedOn: "17 Dec 2024 10:27 AM",
              tint: Color(0xFFFFF1E8),
            ),
            _DocItem(
              title: "WWCC",
              required: true,
              addedOn: "17 Dec 2024 10:28 AM",
              tint: Color(0xFFFFF1E8),
            ),
            _DocItem(
              title: "First Aid certificate",
              required: true,
              addedOn: "17 Dec 2024 10:47 AM",
              tint: Color(0xFFFFF1E8),
            ),
            _DocItem(
              title: "Infection Control Certificate",
              required: true,
              addedOn: "17 Dec 2024 04:46 PM",
              tint: Color(0xFFFFF1E8),
            ),
            _DocItem(
              title: "Resume- must have referees",
              required: true,
              addedOn: "19 Dec 2024 01:16 PM",
              tint: Color(0xFFFFF1E8),
            ),
            _DocItem(
              title: "NDIS Worker Orientation Module",
              required: true,
              addedOn: "17 Dec 2024 04:54 PM",
              tint: Color(0xFFFFF1E8),
            ),
            _DocItem(
              title: "Manual Handling Certificate",
              required: false,
              addedOn: "-",
              showAddOnly: true,
              tint: Color(0xFFFFF1E8),
            ),
            _DocItem(
              title: "Pre- existing conditions",
              required: false,
              addedOn: "17 Dec 2024 05:09 PM",
              tint: Color(0xFFFFF1E8),
            ),
            _DocItem(
              title: "Superannuation Standard choice form",
              required: true,
              addedOn: "17 Dec 2024 05:09 PM",
              tint: Color(0xFFFFF1E8),
            ),
            _DocItem(
              title: "Tax file number declaration form",
              required: true,
              addedOn: "17 Dec 2024 08:32 PM",
              tint: Color(0xFFFFF1E8),
            ),
            _DocItem(
              title: "Statutory declaration form",
              required: false,
              addedOn: "-",
              showAddOnly: true,
              tint: Color(0xFFFFF1E8),
            ),
          ],
        ),
      ],
    );
  }
}

class _AdditionalTab extends StatelessWidget {
  const _AdditionalTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PageHeader(
          title: "Additional files",
          requiredStar: false,
          subtitle: "Please upload any document you like",
          actionText: "Add additional files",
          onAction: () {},
        ),
        const SizedBox(height: 14),
        const Card(child: SizedBox(height: 80)),
      ],
    );
  }
}

/* ---------------- Notes + footer info + useful links ---------------- */

class _NotesCard extends StatelessWidget {
  final List<String> bullets;
  const _NotesCard({required this.bullets});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Notes", style: TextStyle(fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            ...bullets.map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(Icons.circle, size: 6),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(b, style: const TextStyle(height: 1.35)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterInfoCard extends StatelessWidget {
  final String text;
  final String email;
  const _FooterInfoCard({required this.text, required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey.shade800, height: 1.35),
            children: [
              TextSpan(text: text),
              TextSpan(
                text: email,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const TextSpan(text: "."),
            ],
          ),
        ),
      ),
    );
  }
}

class _UsefulLinksCard extends StatelessWidget {
  const _UsefulLinksCard();

  @override
  Widget build(BuildContext context) {
    final links = const [
      _LinkChip("Ausmed", Color(0xFF6D28D9)),
      _LinkChip("NDIS Orientation Module", Color(0xFFFF7A45)),
      _LinkChip("First aid and CPR for RNS only", Color(0xFF00C2A8)),
      _LinkChip("NDIS Screening Check", Color(0xFF3B82F6)),
      _LinkChip("Police Checks", Color(0xFF6D28D9)),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please find useful links below",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F2FB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Wrap(spacing: 14, runSpacing: 12, children: links),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkChip extends StatelessWidget {
  final String label;
  final Color color;
  const _LinkChip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(horizontal: 18),
        ),
        onPressed: () {},
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}
