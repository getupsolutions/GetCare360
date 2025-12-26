import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getcare360/core/constant/app_color.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class HomeCareConsumerRosterPage extends StatefulWidget {
  const HomeCareConsumerRosterPage({super.key});

  static const pageBg = Color(0xFFF3F4F8);
  static const purple = Color(0xFF8E24AA);
  @override
  State<HomeCareConsumerRosterPage> createState() => _HomeCareConsumerRosterPageState();
}

class _HomeCareConsumerRosterPageState extends State<HomeCareConsumerRosterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Roster Page', centerTitle: true),

      backgroundColor: AppColors.pageBg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            final w = c.maxWidth;
            final isDesktop = w >= 980;
            final contentWidth = isDesktop ? 1100.0 : min(w, 1100.0);

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      RosterHeaderCard(),
                      SizedBox(height: 14),
                      RosterWeekBoard(),
                      SizedBox(height: 14),
                    ],
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

/// ------------------------------------------------------------
/// Header Card (Purple)
/// ------------------------------------------------------------
class RosterHeaderCard extends StatefulWidget {
  const RosterHeaderCard();

  @override
  State<RosterHeaderCard> createState() => RosterHeaderCardState();
}

class RosterHeaderCardState extends State<RosterHeaderCard> {
  final searchCtrl = TextEditingController(text: "15-12-2025 - 21-12-2025");
  bool showCancelled = false;

  String? rosterType = "Weekly Roster";
  String? organization = "Select an organization";
  String? services = "All Services";
  String? staff = "All Staff";
  String? approval = "Select Approved/Unapprove";

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const purple = HomeCareConsumerRosterPage.purple;

    return Container(
      decoration: BoxDecoration(
        color: purple,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;
          final isMobile = w < 650;

          final inputH = 40.0;
          final gap = 10.0;

          // We use Wrap so it never overflows.
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Organization Roster",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  SizedBox(
                    width: isMobile ? w : 210,
                    height: inputH,
                    child: WhiteField(
                      controller: searchCtrl,
                      hint: "Date range",
                      suffix: const Icon(Icons.calendar_month, size: 18),
                      onTap: () async {
                        // hook up date range picker here
                      },
                    ),
                  ),

                  SizedBox(
                    width: isMobile ? w : 200,
                    height: inputH,
                    child: WhiteDropdown(
                      value: rosterType,
                      hint: "Weekly Roster",
                      items: const ["Weekly Roster", "Daily Roster"],
                      onChanged: (v) => setState(() => rosterType = v),
                    ),
                  ),

                  SizedBox(
                    width: isMobile ? w : 200,
                    height: inputH,
                    child: WhiteDropdown(
                      value: organization,
                      hint: "Select an organization",
                      items: const [
                        "Select an organization",
                        "Org A",
                        "Org B",
                        "Org C",
                      ],
                      onChanged: (v) => setState(() => organization = v),
                    ),
                  ),

                  SizedBox(
                    width: isMobile ? w : 200,
                    height: inputH,
                    child: WhiteDropdown(
                      value: services,
                      hint: "All Services",
                      items: const [
                        "All Services",
                        "PCA",
                        "Nursing",
                        "Kitchen",
                      ],
                      onChanged: (v) => setState(() => services = v),
                    ),
                  ),

                  SizedBox(
                    width: isMobile ? w : 200,
                    height: inputH,
                    child: WhiteDropdown(
                      value: staff,
                      hint: "All Staff",
                      items: const [
                        "All Staff",
                        "Liz",
                        "Riyo",
                        "Erika",
                        "Aleena",
                      ],
                      onChanged: (v) => setState(() => staff = v),
                    ),
                  ),

                  SizedBox(
                    width: isMobile ? w : 230,
                    height: inputH,
                    child: WhiteDropdown(
                      value: approval,
                      hint: "Select Approved/Unapprove",
                      items: const [
                        "Select Approved/Unapprove",
                        "Approved",
                        "Unapproved",
                      ],
                      onChanged: (v) => setState(() => approval = v),
                    ),
                  ),

                  // Show cancelled
                  SizedBox(
                    height: inputH,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: Checkbox(
                            value: showCancelled,
                            onChanged: (v) =>
                                setState(() => showCancelled = v ?? false),
                            activeColor: Colors.white,
                            checkColor: purple,
                            side: const BorderSide(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Show cancelled shift",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),

                  // Buttons row (Wrap ensures it stacks on small screens)
                  ActionButton(
                    label: "Clear All",
                    color: const Color(0xFF00B3A6),
                    onTap: () {
                      setState(() {
                        rosterType = "Weekly Roster";
                        organization = "Select an organization";
                        services = "All Services";
                        staff = "All Staff";
                        approval = "Select Approved/Unapprove";
                        showCancelled = false;
                        searchCtrl.text = "15-12-2025 - 21-12-2025";
                      });
                    },
                  ),
                  ActionButton(
                    label: "Send Organization Mail",
                    color: const Color(0xFFFF9800),
                    onTap: () {},
                  ),
                  ActionButton(
                    label: "Send Confirmed Mail",
                    color: const Color(0xFF7C4DFF),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const ActionButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5),
        ),
      ),
    );
  }
}

class WhiteDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const WhiteDropdown({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Fix “dropdown opens but nothing shows” issues:
    // - always set dropdownColor
    // - always set isExpanded
    // - provide menu items with normal text style
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      dropdownColor: Colors.white,
      icon: const Icon(Icons.keyboard_arrow_down, size: 20),
      style: const TextStyle(color: Colors.black87, fontSize: 13),
      items: items
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class WhiteField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? suffix;
  final VoidCallback? onTap;

  const WhiteField({
    required this.controller,
    required this.hint,
    this.suffix,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: onTap != null,
      onTap: onTap,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffix == null
            ? null
            : Padding(padding: const EdgeInsets.only(right: 6), child: suffix),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 40,
          minWidth: 40,
        ),
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Week Board (7 columns)
/// ------------------------------------------------------------
class RosterWeekBoard extends StatelessWidget {
  const RosterWeekBoard();

  @override
  Widget build(BuildContext context) {
    // Sample week data (replace with API/BLoC later)
    final days = <RosterDayData>[
      RosterDayData(
        title: "MON 15 DEC",
        shifts: const [
          ShiftData("7:00 AM - 3:00 PM", "Liz Ng Pamposa"),
          ShiftData("10:30 AM - 6:30 PM", "Riyo George"),
          ShiftData("3:00 PM - 11:00 PM", "Erika Kaye Ng Legaspi"),
          ShiftData("11:00 PM - 7:00 AM", "Aleena Monica"),
        ],
      ),
      RosterDayData(
        title: "TUE 16 DEC",
        shifts: const [
          ShiftData("7:00 AM - 3:00 PM", "Liz Ng Pamposa"),
          ShiftData("10:30 AM - 6:30 PM", "Riyo George"),
          ShiftData("3:00 PM - 11:00 PM", "Erika Kaye Ng Legaspi"),
          ShiftData("11:00 PM - 7:00 AM", "Aleena Monica"),
        ],
      ),
      RosterDayData(
        title: "WED 17 DEC",
        shifts: const [
          ShiftData("7:00 AM - 3:00 PM", "Liz Ng Pamposa"),
          ShiftData("10:30 AM - 6:30 PM", "Riyo George"),
          ShiftData("3:00 PM - 11:00 PM", "Erika Kaye Ng Legaspi"),
          ShiftData("11:00 PM - 7:00 AM", "Aleena Monica"),
        ],
      ),
      RosterDayData(
        title: "THU 18 DEC",
        shifts: const [
          ShiftData("7:00 AM - 3:00 PM", "Liz Ng Pamposa"),
          ShiftData("10:30 AM - 6:30 PM", "Riyo George"),
          ShiftData("3:00 PM - 11:00 PM", "Erika Kaye Ng Legaspi"),
          ShiftData("11:00 PM - 7:00 AM", "Aleena Monica"),
        ],
      ),
      RosterDayData(
        title: "FRI 19 DEC",
        shifts: const [
          ShiftData("7:00 AM - 3:00 PM", "Liz Ng Pamposa"),
          ShiftData("10:30 AM - 6:30 PM", "Riyo George"),
          ShiftData("3:00 PM - 11:00 PM", "Erika Kaye Ng Legaspi"),
        ],
      ),
      RosterDayData(title: "SAT 20 DEC", shifts: const []),
      RosterDayData(
        title: "SUN 21 DEC",
        shifts: const [ShiftData("11:00 PM - 7:00 AM", "Aleena Monica")],
      ),
    ];

    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;

        // Grid should remain 7 columns like web.
        // On smaller screens, we allow horizontal scroll.
        final minGridWidth = 980.0; // comfortable weekly view
        final gridWidth = max(w, minGridWidth);

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
          child: Column(
            children: [
              // Top arrows row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ArrowButton(icon: Icons.chevron_left, onTap: () {}),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Center(
                      child: Text(
                        " ",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ArrowButton(icon: Icons.chevron_right, onTap: () {}),
                ],
              ),
              const SizedBox(height: 10),

              // Board
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: gridWidth,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final d in days) Expanded(child: DayColumn(data: d)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const ArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF3F4F8),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 22),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Column per day
/// ------------------------------------------------------------
class DayColumn extends StatelessWidget {
  final RosterDayData data;
  const DayColumn({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DayHeader(title: data.title),
          const SizedBox(height: 10),

          for (final s in data.shifts) ...[
            ShiftCard(data: s),
            const SizedBox(height: 10),
          ],

          // Add card (+)
          AddShiftCard(onTap: () {}),
        ],
      ),
    );
  }
}

class DayHeader extends StatelessWidget {
  final String title;
  const DayHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class ShiftCard extends StatelessWidget {
  final ShiftData data;
  const ShiftCard({required this.data});

  @override
  Widget build(BuildContext context) {
    // Light purple like screenshot
    const bg = Color(0xFFE8D7FF);
    const nameColor = Color(0xFF4F46E5);

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD7C6FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data.time,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 12,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            data.staffName,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 12,
              color: nameColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // Icons row (edit / person / settings / view)
          Wrap(
            spacing: 8,
            alignment: WrapAlignment.center,
            children: const [
              MiniIconBox(icon: Icons.edit, color: Color(0xFFFF6D00)),
              MiniIconBox(icon: Icons.person, color: Color(0xFF6D4C41)),
              MiniIconBox(icon: Icons.settings, color: Color(0xFF212121)),
              MiniIconBox(icon: Icons.remove_red_eye, color: Color(0xFFFF6D00)),
            ],
          ),
        ],
      ),
    );
  }
}

class MiniIconBox extends StatelessWidget {
  final IconData icon;
  final Color color;

  const MiniIconBox({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, size: 14, color: color),
    );
  }
}

class AddShiftCard extends StatelessWidget {
  final VoidCallback onTap;
  const AddShiftCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE6E8EF)),
          ),
          child: const Center(child: Icon(Icons.add, color: Colors.black54)),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Data models (UI demo)
/// ------------------------------------------------------------
class RosterDayData {
  final String title;
  final List<ShiftData> shifts;
  const RosterDayData({required this.title, required this.shifts});
}

class ShiftData {
  final String time;
  final String staffName;
  const ShiftData(this.time, this.staffName);
}
