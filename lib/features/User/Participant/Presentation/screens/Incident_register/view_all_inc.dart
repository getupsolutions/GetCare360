import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

// ✅ Replace with your actual custom appbar import
// import 'package:getcare360/core/widget/custom_app_bar.dart';

class Incident {
  final String dateCompleted;
  final String refCode;
  final String completedBy;
  final String position;
  final String dateTime;
  final String location;

  const Incident({
    required this.dateCompleted,
    required this.refCode,
    required this.completedBy,
    required this.position,
    required this.dateTime,
    required this.location,
  });
}

class IncidentRegisterPage extends StatefulWidget {
  const IncidentRegisterPage({super.key});

  @override
  State<IncidentRegisterPage> createState() => _IncidentRegisterPageState();
}

class _IncidentRegisterPageState extends State<IncidentRegisterPage> {
  static const _allIncidents = <Incident>[
    Incident(
      dateCompleted: "01-01-2025",
      refCode: "THC 3101",
      completedBy: "Aastha tiwari",
      position: "DCW",
      dateTime: "01-01-2025 08:45 PM",
      location: "Rawson road",
    ),
    Incident(
      dateCompleted: "01-01-2025",
      refCode: "THC 3101",
      completedBy: "Aastha tiwari",
      position: "DCW",
      dateTime: "01-01-2025 07:00 AM",
      location: "Rawson road",
    ),
  ];

  final _searchCtrl = TextEditingController();

  int _rowsPerPage = 10;
  int _page = 1;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFFEFF2F6);

    final query = _searchCtrl.text.trim().toLowerCase();
    final filtered = query.isEmpty
        ? _allIncidents
        : _allIncidents.where((e) {
            return e.dateCompleted.toLowerCase().contains(query) ||
                e.refCode.toLowerCase().contains(query) ||
                e.completedBy.toLowerCase().contains(query) ||
                e.position.toLowerCase().contains(query) ||
                e.dateTime.toLowerCase().contains(query) ||
                e.location.toLowerCase().contains(query);
          }).toList();

    final total = filtered.length;
    final totalPages = (total / _rowsPerPage).ceil().clamp(1, 999);

    if (_page > totalPages) _page = totalPages;

    final start = (_page - 1) * _rowsPerPage;
    final end = (start + _rowsPerPage).clamp(0, total);
    final pageItems = filtered.sublist(start.clamp(0, total), end);

    return Scaffold(
      backgroundColor: bg,

      // ✅ As requested
      appBar: const CustomAppBar(title: 'Incident Register', centerTitle: true),

      bottomNavigationBar: const _FooterBar(),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
            children: [
              _PageHeaderRow(
                title: "Incident Register",
                breadcrumb: "Dashboard  >  Incident Register",
              ),
              const SizedBox(height: 12),

              _CardShell(
                child: Column(
                  children: [
                    // Card top bar: "All Incidents" + tiny icons
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 12, 10, 10),
                      child: Row(
                        children: [
                          const Text(
                            "All Incidents",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF374151),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            tooltip: "Refresh",
                            onPressed: () {},
                            icon: const Icon(Icons.refresh, size: 18),
                            color: Colors.blueGrey,
                          ),
                          IconButton(
                            tooltip: "Close",
                            onPressed: () {},
                            icon: const Icon(Icons.close, size: 18),
                            color: Colors.blueGrey,
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: Colors.grey.shade200),

                    // ✅ Controls row: show entries + search (responsive + no overflow)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                      child: LayoutBuilder(
                        builder: (context, c) {
                          final stacked = c.maxWidth < 720;

                          final left = Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text(
                                "Show",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 86,
                                  maxWidth: 120,
                                ),
                                child: SizedBox(
                                  height: 36,
                                  child: DropdownButtonFormField<int>(
                                    initialValue: _rowsPerPage,
                                    isExpanded:
                                        true, // ✅ important (prevents internal overflow)
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                    ),
                                    items: const [10, 25, 50, 100]
                                        .map(
                                          (n) => DropdownMenuItem(
                                            value: n,
                                            child: Text(
                                              "$n",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) {
                                      if (v == null) return;
                                      setState(() {
                                        _rowsPerPage = v;
                                        _page = 1;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const Text(
                                "entries",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          );

                          final right = Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text(
                                "Search:",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  // ✅ stays nice on desktop, still fits on small screens
                                  minWidth: math.min(220, c.maxWidth),
                                  maxWidth: stacked ? c.maxWidth : 320,
                                ),
                                child: SizedBox(
                                  height: 36,
                                  child: TextField(
                                    controller: _searchCtrl,
                                    onChanged: (_) => setState(() => _page = 1),
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );

                          if (stacked) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                left,
                                const SizedBox(height: 12),
                                right,
                              ],
                            );
                          }

                          return Row(
                            children: [
                              Expanded(child: left),
                              right,
                            ],
                          );
                        },
                      ),
                    ),

                    // Table
                    // ✅ Vertical cards (NO horizontal scroll)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
                      child: _IncidentsCardListVertical(
                        rows: pageItems,
                        onEdit: (i) {},
                        onDelete: (i) {},
                      ),
                    ),

                    // Footer: showing entries + pagination
                    Divider(height: 1, color: Colors.grey.shade200),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                      child: LayoutBuilder(
                        builder: (context, c) {
                          final stacked = c.maxWidth < 720;

                          final info = Text(
                            total == 0
                                ? "Showing 0 to 0 of 0 entries"
                                : "Showing ${start + 1} to $end of $total entries",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          );

                          final pager = _Pager(
                            page: _page,
                            totalPages: totalPages,
                            onPrev: _page > 1
                                ? () => setState(() => _page--)
                                : null,
                            onNext: _page < totalPages
                                ? () => setState(() => _page++)
                                : null,
                            onTapPage: (p) => setState(() => _page = p),
                          );

                          if (stacked) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                info,
                                const SizedBox(height: 10),
                                pager,
                              ],
                            );
                          }

                          return Row(
                            children: [
                              Expanded(child: info),
                              pager,
                            ],
                          );
                        },
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

class _IncidentsCardListVertical extends StatelessWidget {
  final List<Incident> rows;
  final ValueChanged<Incident> onEdit;
  final ValueChanged<Incident> onDelete;

  const _IncidentsCardListVertical({
    required this.rows,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          "No incidents found",
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // parent ListView scrolls
      itemCount: rows.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final e = rows[index];

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _kv("Date Completed", e.dateCompleted),
              const SizedBox(height: 10),
              _kv("Reference Code", e.refCode),
              const SizedBox(height: 10),
              _kv("Completed By", e.completedBy),
              const SizedBox(height: 10),
              _kv("Position", e.position),
              const SizedBox(height: 10),
              _kv("Date & Time", e.dateTime),
              const SizedBox(height: 10),
              _kv("Location", e.location),
              const SizedBox(height: 12),

              // ✅ Actions row at bottom
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _ActionIcon(
                    bg: const Color(0xFFBBF7D0),
                    fg: const Color(0xFF16A34A),
                    icon: Icons.edit,
                    onTap: () => onEdit(e),
                  ),
                  const SizedBox(width: 10),
                  _ActionIcon(
                    bg: const Color(0xFFFECACA),
                    fg: const Color(0xFFDC2626),
                    icon: Icons.delete_outline,
                    onTap: () => onDelete(e),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _kv(String k, String v) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          k.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          v,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }
}

/* --------------------- WIDGETS --------------------- */

class _PageHeaderRow extends StatelessWidget {
  final String title;
  final String breadcrumb;

  const _PageHeaderRow({required this.title, required this.breadcrumb});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final stacked = w < 720;

    final bread = Container(
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

    if (stacked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          bread,
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
          ),
        ),
        bread,
      ],
    );
  }
}

class _IncidentsTable extends StatelessWidget {
  final List<Incident> rows;
  final ValueChanged<Incident> onEdit;
  final ValueChanged<Incident> onDelete;

  const _IncidentsTable({
    required this.rows,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle headStyle() =>
        const TextStyle(fontWeight: FontWeight.w900, fontSize: 12);

    return DataTable(
      headingRowHeight: 44,
      dataRowMinHeight: 44,
      dataRowMaxHeight: 52,
      columnSpacing: 18,
      horizontalMargin: 6,
      columns: [
        DataColumn(label: Text("DATE COMPLETED", style: headStyle())),
        DataColumn(label: Text("REFERENCE CODE", style: headStyle())),
        DataColumn(label: Text("COMPLETED BY", style: headStyle())),
        DataColumn(label: Text("POSITION", style: headStyle())),
        DataColumn(label: Text("DATE & TIME", style: headStyle())),
        DataColumn(label: Text("LOCATION", style: headStyle())),
        DataColumn(label: Text("ACTION", style: headStyle())),
      ],
      rows: rows.map((e) {
        return DataRow(
          cells: [
            DataCell(
              Text(
                e.dateCompleted,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            DataCell(
              Text(e.refCode, style: TextStyle(color: Colors.grey.shade700)),
            ),
            DataCell(
              Text(
                e.completedBy,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            DataCell(
              Text(e.position, style: TextStyle(color: Colors.grey.shade700)),
            ),
            DataCell(
              Text(e.dateTime, style: TextStyle(color: Colors.grey.shade700)),
            ),
            DataCell(
              Text(e.location, style: TextStyle(color: Colors.grey.shade700)),
            ),
            DataCell(
              Row(
                children: [
                  _ActionIcon(
                    bg: const Color(0xFFBBF7D0),
                    fg: const Color(0xFF16A34A),
                    icon: Icons.edit,
                    onTap: () => onEdit(e),
                  ),
                  const SizedBox(width: 8),
                  _ActionIcon(
                    bg: const Color(0xFFFECACA),
                    fg: const Color(0xFFDC2626),
                    icon: Icons.delete_outline,
                    onTap: () => onDelete(e),
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final Color bg;
  final Color fg;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionIcon({
    required this.bg,
    required this.fg,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 26,
        width: 26,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: fg),
      ),
    );
  }
}

class _Pager extends StatelessWidget {
  final int page;
  final int totalPages;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;
  final ValueChanged<int> onTapPage;

  const _Pager({
    required this.page,
    required this.totalPages,
    required this.onPrev,
    required this.onNext,
    required this.onTapPage,
  });

  @override
  Widget build(BuildContext context) {
    final purple = const Color(0xFF6A0B6D);

    Widget btn(String text, {VoidCallback? onTap, bool active = false}) {
      return SizedBox(
        height: 34,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: active ? purple : Colors.white,
            foregroundColor: active ? Colors.white : Colors.black87,
            side: BorderSide(color: Colors.grey.shade300),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      );
    }

    final pages = <int>[];
    final start = (page - 2).clamp(1, totalPages);
    final end = (page + 2).clamp(1, totalPages);
    for (int p = start; p <= end; p++) {
      pages.add(p);
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.end,
      children: [
        btn("Previous", onTap: onPrev),
        ...pages.map(
          (p) => btn("$p", active: p == page, onTap: () => onTapPage(p)),
        ),
        btn("Next", onTap: onNext),
      ],
    );
  }
}

class _CardShell extends StatelessWidget {
  final Widget child;
  const _CardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: child,
      ),
    );
  }
}

class _FooterBar extends StatelessWidget {
  const _FooterBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      alignment: Alignment.center,
      color: const Color(0xFF6A0B6D),
      child: const Text(
        "2025 © All rights reserved",
        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
      ),
    );
  }
}
