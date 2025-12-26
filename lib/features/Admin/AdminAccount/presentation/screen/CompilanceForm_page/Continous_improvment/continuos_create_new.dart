import 'package:flutter/material.dart';

class AdminContinuosCreateNewPage extends StatefulWidget {
  final VoidCallback? onSave;
  final VoidCallback? onContinue;

  const AdminContinuosCreateNewPage({super.key, this.onSave, this.onContinue});

  @override
  State<AdminContinuosCreateNewPage> createState() => _ContinuosCreateNewPageState();
}

class _ContinuosCreateNewPageState extends State<AdminContinuosCreateNewPage> {
  static const Color brandPurple = Color(0xFF9C27B0);
  static const Color brandPurpleDark = Color(0xFF8E24AA);
  static const Color teal = Color(0xFF00BFA5);
  static const Color pageBg = Color(0xFFF3F4F8);

  int _tabIndex = 0;

  final _dateCtrl = TextEditingController();
  final _referenceCtrl = TextEditingController();
  final _completedByCtrl = TextEditingController();
  final _positionCtrl = TextEditingController();
  String? _staff;

  final _staffList = const [
    "Steven Maschek",
    "Shine",
    "Bincy Pappachan",
    "Dazy Rani",
  ];

  @override
  void dispose() {
    _dateCtrl.dispose();
    _referenceCtrl.dispose();
    _completedByCtrl.dispose();
    _positionCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      _dateCtrl.text =
          "${picked.day.toString().padLeft(2, "0")}-${picked.month.toString().padLeft(2, "0")}-${picked.year}";
    }
  }

  InputDecoration _input(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF9FAFD),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: brandPurpleDark, width: 1.2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: brandPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Continuous Register",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;

          // breakpoints
          final isMobile = w < 760;
          final isTablet = w >= 760 && w < 1100;

          final horizontalPad = isMobile ? 12.0 : 22.0;
          final innerPad = isMobile ? 14.0 : 18.0;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPad,
                  vertical: isMobile ? 12 : 20,
                ),
                child: _CardShell(
                  child: Column(
                    children: [
                      // Tabs
                      Padding(
                        padding: EdgeInsets.fromLTRB(innerPad, 14, innerPad, 0),
                        child: _TabsRow(
                          selectedIndex: _tabIndex,
                          onSelect: (i) => setState(() => _tabIndex = i),
                        ),
                      ),
                      const Divider(height: 20, thickness: 1),

                      // Body
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(
                            innerPad,
                            12,
                            innerPad,
                            18,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),
                              const Text(
                                "Triniti Home Care Reference:",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF2B2B2B),
                                ),
                              ),
                              const SizedBox(height: 18),

                              // Responsive grid:
                              // mobile: 1 column
                              // tablet/desktop: 2 columns
                              _ResponsiveFormGrid(
                                columns: isMobile ? 1 : 2,
                                gap: 14,
                                children: [
                                  _LabeledField(
                                    label: "Date completed",
                                    child: TextField(
                                      controller: _dateCtrl,
                                      decoration: _input("Date"),
                                      readOnly: true,
                                      onTap: _pickDate,
                                    ),
                                  ),
                                  _LabeledField(
                                    label: "Reference Code",
                                    child: TextField(
                                      controller: _referenceCtrl,
                                      decoration: _input("Reference Code"),
                                    ),
                                  ),
                                  _LabeledField(
                                    label: "Completed By",
                                    child: TextField(
                                      controller: _completedByCtrl,
                                      decoration: _input("Completed By"),
                                    ),
                                  ),
                                  _LabeledField(
                                    label: "Position",
                                    child: TextField(
                                      controller: _positionCtrl,
                                      decoration: _input("Position"),
                                    ),
                                  ),
                                  _LabeledField(
                                    label: "Staff",
                                    span: isMobile ? 1 : 2,
                                    child: DropdownButtonFormField<String>(
                                      value: _staff,
                                      items: _staffList
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (v) =>
                                          setState(() => _staff = v),
                                      decoration: _input("Select Staff"),
                                    ),
                                  ),

                                  // Placeholder areas for other tabs later
                                  if (_tabIndex != 0) ...[
                                    _LabeledField(
                                      label: "Tab Content (Demo)",
                                      span: isMobile ? 1 : 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF9FAFD),
                                          border: Border.all(
                                            color: const Color(0xFFE6E6E6),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          _tabIndex == 1
                                              ? "Incident Response content goes here."
                                              : "Management & Resolution content goes here.",
                                          style: const TextStyle(
                                            color: Color(0xFF666666),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Divider(height: 1),

                      // Footer actions
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          innerPad,
                          14,
                          innerPad,
                          16,
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _PillButton(
                                label: "Save",
                                bg: brandPurple,
                                onTap:
                                    widget.onSave ??
                                    () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(content: Text("Saved")),
                                      );
                                    },
                              ),
                              _PillButton(
                                label: "Continue",
                                bg: teal,
                                onTap:
                                    widget.onContinue ??
                                    () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("Continue"),
                                        ),
                                      );
                                    },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ---------------------------- UI helpers ----------------------------

class _CardShell extends StatelessWidget {
  final Widget child;
  const _CardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: const Color(0x11000000),
      borderRadius: BorderRadius.circular(14),
      child: ClipRRect(borderRadius: BorderRadius.circular(14), child: child),
    );
  }
}

class _TabsRow extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onSelect;

  const _TabsRow({required this.selectedIndex, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final tabs = const [
      ("Details", Icons.diamond_outlined),
      ("Incident Response", Icons.near_me_outlined),
      ("Management & Resolution", Icons.shield_outlined),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 10,
      children: List.generate(tabs.length, (i) {
        final (label, icon) = tabs[i];
        final sel = i == selectedIndex;

        return Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: sel ? const Color(0xFF9C27B0) : const Color(0xFFF2F3F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () => onSelect(i),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      size: 18,
                      color: sel ? Colors.white : const Color(0xFF9E9E9E),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: TextStyle(
                        color: sel ? Colors.white : const Color(0xFF2B2B2B),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _ResponsiveFormGrid extends StatelessWidget {
  final int columns; // 1 or 2 (extendable)
  final double gap;
  final List<_LabeledField> children;

  const _ResponsiveFormGrid({
    required this.columns,
    required this.gap,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    // Using Wrap for simple responsive spanning
    return LayoutBuilder(
      builder: (context, c) {
        final totalWidth = c.maxWidth;
        final colW = columns == 1
            ? totalWidth
            : (totalWidth - gap) / 2; // 2 columns

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: children.map((f) {
            final span = (columns == 1) ? 1 : f.span.clamp(1, 2);
            final w = (span == 2 && columns == 2) ? totalWidth : colW;

            return SizedBox(width: w, child: f);
          }).toList(),
        );
      },
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  final int span; // 1 or 2

  const _LabeledField({
    required this.label,
    required this.child,
    this.span = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF5A5A5A),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final Color bg;
  final VoidCallback onTap;
  final IconData? icon;

  const _PillButton({
    required this.label,
    required this.bg,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 18, color: Colors.white),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
