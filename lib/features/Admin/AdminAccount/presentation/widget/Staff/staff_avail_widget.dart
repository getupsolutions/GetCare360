import 'package:flutter/material.dart';

/// ------------------------------------------------------------
/// HeaderBar (mobile-first)
/// ------------------------------------------------------------
class HeaderBar extends StatelessWidget {
  static const Color purple = Color(0xFF8E24AA);

  final String staffValue;
  final ValueChanged<String> onStaffChanged;
  final VoidCallback onFind;
  final VoidCallback onClearAll;
  final VoidCallback onAddMultipleDays;

  const HeaderBar({
    super.key,
    required this.staffValue,
    required this.onStaffChanged,
    required this.onFind,
    required this.onClearAll,
    required this.onAddMultipleDays,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final bool isMobile = w < 720;

    return Container(
      decoration: BoxDecoration(
        color: purple,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Staff Availability",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: isMobile ? double.infinity : 320,
                height: 44,
                child: WhiteDropdown(
                  value: staffValue,
                  hint: "Select Staff",
                  items: const [
                    "Select Staff",
                    "Tasegir Hossain Khan",
                    "Katrina(EUN SEON) JEON",
                  ],
                  onChanged: (v) => onStaffChanged(v ?? staffValue),
                ),
              ),
              SmallBtn(
                label: "Find",
                color: const Color(0xFFE91E63),
                onTap: onFind,
              ),
              SmallBtn(
                label: "Clear All",
                color: const Color(0xFF00B3A6),
                onTap: onClearAll,
              ),
              SmallBtn(
                label: "Add Multiple Days",
                color: const Color(0xFF7C4DFF),
                icon: Icons.add,
                onTap: onAddMultipleDays,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// CalendarCard (Horizontal scroll + wider day boxes)
/// ------------------------------------------------------------
class CalendarCard extends StatelessWidget {
  final DateTime month;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onToday;
  final Map<DateTime, List<AvailabilityBlock>> availabilityByDay;

  const CalendarCard({
    super.key,
    required this.month,
    required this.onPrev,
    required this.onNext,
    required this.onToday,
    required this.availabilityByDay,
  });

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;

    // Sunday index 0
    final leadingBlanks = firstDay.weekday % 7;
    final tilesCount = leadingBlanks + daysInMonth;
    final rows = (tilesCount / 7).ceil();

    final w = MediaQuery.of(context).size.width;

    // ✅ Wider day boxes (forces horizontal scroll)
    final double dayCellWidth = w < 420
        ? 150
        : w < 700
        ? 170
        : w < 980
        ? 160
        : 150;

    // ✅ Taller day boxes for readability
    final double dayCellHeight = w < 420
        ? 230
        : w < 700
        ? 250
        : w < 980
        ? 220
        : 200;

    // Calendar scroll height (vertical)
    final double calendarViewportHeight = w < 700 ? 740 : 660;

    final double gridWidth = dayCellWidth * 7;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        children: [
          CalendarTopBar(
            month: month,
            onPrev: onPrev,
            onNext: onNext,
            onToday: onToday,
            onGridMonth: () {},
          ),
          const SizedBox(height: 12),

          // ✅ Horizontal scrolling wrapper for header + grid
          Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: gridWidth,
                child: Column(
                  children: [
                    Row(
                      children: [
                        DayHeader("Sun", width: dayCellWidth),
                        DayHeader("Mon", width: dayCellWidth),
                        DayHeader("Tue", width: dayCellWidth),
                        DayHeader("Wed", width: dayCellWidth),
                        DayHeader("Thu", width: dayCellWidth),
                        DayHeader("Fri", width: dayCellWidth),
                        DayHeader("Sat", width: dayCellWidth),
                      ],
                    ),
                    const Divider(height: 1),

                    SizedBox(
                      height: calendarViewportHeight,
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(rows, (r) {
                              return Row(
                                children: List.generate(7, (c) {
                                  final index = r * 7 + c;
                                  final dayNum = index - leadingBlanks + 1;

                                  DateTime? date;
                                  if (dayNum >= 1 && dayNum <= daysInMonth) {
                                    date = DateTime(
                                      month.year,
                                      month.month,
                                      dayNum,
                                    );
                                  }

                                  final DateTime? dayKey = date == null
                                      ? null
                                      : DateTime(
                                          date.year,
                                          date.month,
                                          date.day,
                                        );

                                  final blocks = dayKey == null
                                      ? const <AvailabilityBlock>[]
                                      : (availabilityByDay[dayKey] ?? const []);

                                  final isHighlighted =
                                      dayKey != null &&
                                      (dayKey.year == 2025 &&
                                          dayKey.month == 12 &&
                                          dayKey.day == 20);

                                  return SizedBox(
                                    width: dayCellWidth,
                                    child: DayCell(
                                      height: dayCellHeight,
                                      dayNumber:
                                          (dayNum >= 1 && dayNum <= daysInMonth)
                                          ? dayNum
                                          : null,
                                      highlighted: isHighlighted,
                                      blocks: blocks,
                                    ),
                                  );
                                }),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarTopBar extends StatelessWidget {
  final DateTime month;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onToday;
  final VoidCallback onGridMonth;

  const CalendarTopBar({
    super.key,
    required this.month,
    required this.onPrev,
    required this.onNext,
    required this.onToday,
    required this.onGridMonth,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 700;

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      children: [
        Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            NavIconBtn(icon: Icons.chevron_left, onTap: onPrev),
            NavIconBtn(icon: Icons.chevron_right, onTap: onNext),
            NavOutlineBtn(label: "today", onTap: onToday),
          ],
        ),
        Text(
          "${monthName(month.month)} ${month.year}".toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: Color(0xFF3B3B3B),
          ),
        ),
        SizedBox(
          width: isMobile ? double.infinity : null,
          child: Align(
            alignment: isMobile ? Alignment.centerLeft : Alignment.centerRight,
            child: BlueBtn(label: "Grid Month", onTap: onGridMonth),
          ),
        ),
      ],
    );
  }

  String monthName(int m) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[m - 1];
  }
}

class DayHeader extends StatelessWidget {
  final String label;
  final double width;

  const DayHeader(this.label, {super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        height: 38,
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF7B7B7B),
            fontSize: 12.5,
          ),
        ),
      ),
    );
  }
}

class DayCell extends StatelessWidget {
  final double height;
  final int? dayNumber;
  final bool highlighted;
  final List<AvailabilityBlock> blocks;

  const DayCell({
    super.key,
    required this.height,
    required this.dayNumber,
    required this.highlighted,
    required this.blocks,
  });

  @override
  Widget build(BuildContext context) {
    final bg = highlighted ? const Color(0xFFFFF8DC) : Colors.white;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: const Color(0xFFE6E8EF)),
      ),
      padding: const EdgeInsets.all(10),
      child: dayNumber == null
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "$dayNumber",
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // ✅ Internal scroll for the day's availability list
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView.separated(
                      itemCount: blocks.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) => AvailabilityCard(block: blocks[i]),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class AvailabilityCard extends StatelessWidget {
  final AvailabilityBlock block;
  const AvailabilityCard({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFBFF7D0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 13.5,
          height: 1.2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              block.time,
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              block.staff,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Add Availability dialog
/// ------------------------------------------------------------
class AddAvailabilityDialog extends StatefulWidget {
  const AddAvailabilityDialog({super.key});

  @override
  State<AddAvailabilityDialog> createState() => AddAvailabilityDialogState();
}

class AddAvailabilityDialogState extends State<AddAvailabilityDialog> {
  final startCtrl = TextEditingController();
  final endCtrl = TextEditingController();
  final notesCtrl = TextEditingController();

  String staff = "Choose Staff";
  String shift = "Choose Shift";

  @override
  void dispose() {
    startCtrl.dispose();
    endCtrl.dispose();
    notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 520;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Add Availability",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(height: 1),
              const SizedBox(height: 12),
              if (isMobile) ...[
                LabeledField(
                  label: "Start Date",
                  child: WhiteTextField(
                    controller: startCtrl,
                    hint: "Start Date",
                    readOnly: true,
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 10),
                LabeledField(
                  label: "End Date",
                  child: WhiteTextField(
                    controller: endCtrl,
                    hint: "End Date",
                    readOnly: true,
                    onTap: () {},
                  ),
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: LabeledField(
                        label: "Start Date",
                        child: WhiteTextField(
                          controller: startCtrl,
                          hint: "Start Date",
                          readOnly: true,
                          onTap: () {},
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: LabeledField(
                        label: "End Date",
                        child: WhiteTextField(
                          controller: endCtrl,
                          hint: "End Date",
                          readOnly: true,
                          onTap: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              LabeledField(
                label: "Choose Staff",
                child: WhiteDropdown(
                  value: staff,
                  hint: "Choose Staff",
                  items: const [
                    "Choose Staff",
                    "Tasegir Hossain Khan",
                    "Katrina(EUN SEON) JEON",
                  ],
                  onChanged: (v) => setState(() => staff = v ?? staff),
                ),
              ),
              const SizedBox(height: 12),
              LabeledField(
                label: "Shift",
                child: WhiteDropdown(
                  value: shift,
                  hint: "Choose Shift",
                  items: const [
                    "Choose Shift",
                    "12:00 AM - 12:00 AM",
                    "12:00 AM - 12:55 AM",
                  ],
                  onChanged: (v) => setState(() => shift = v ?? shift),
                ),
              ),
              const SizedBox(height: 12),
              LabeledField(
                label: "Notes",
                child: TextField(
                  controller: notesCtrl,
                  minLines: 3,
                  maxLines: 4,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE6E8EF)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Close"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8E24AA),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  const LabeledField({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        SizedBox(height: 44, child: child),
      ],
    );
  }
}

/// ------------------------------------------------------------
/// UI atoms
/// ------------------------------------------------------------
class WhiteDropdown extends StatelessWidget {
  final String value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const WhiteDropdown({
    super.key,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      dropdownColor: Colors.white,
      menuMaxHeight: 320,
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
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE6E8EF)),
        ),
      ),
    );
  }
}

class WhiteTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool readOnly;
  final VoidCallback? onTap;

  const WhiteTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      style: const TextStyle(fontSize: 13),
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
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE6E8EF)),
        ),
      ),
    );
  }
}

class SmallBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  final IconData? icon;

  const SmallBtn({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: icon == null
            ? const SizedBox.shrink()
            : Icon(icon, size: 16, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12.5),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

class NavIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const NavIconBtn({super.key, required this.icon, required this.onTap});

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
          child: Icon(icon, size: 18),
        ),
      ),
    );
  }
}

class NavOutlineBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const NavOutlineBtn({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label),
    );
  }
}

class BlueBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const BlueBtn({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w900)),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Data Model
/// ------------------------------------------------------------
class AvailabilityBlock {
  final String time;
  final String staff;
  const AvailabilityBlock(this.time, this.staff);
}
