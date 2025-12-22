import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class HomecareCreateSupport extends StatefulWidget {
  const HomecareCreateSupport({super.key});

  @override
  State<HomecareCreateSupport> createState() => _CreateSupportState();
}

class _CreateSupportState extends State<HomecareCreateSupport> {
  final suprtTaskCtrl = TextEditingController();
  final codeCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  final List<CarePlanSubItem> observations = [];
  final List<CarePlanSubItem> goals = [];
  final List<CarePlanSubItem> interventions = [];

  @override
  void dispose() {
    suprtTaskCtrl.dispose();
    codeCtrl.dispose();
    priceCtrl.dispose();
    super.dispose();
  }

  Future<void> _addItemDialog({
    required String sectionName,
    required List<CarePlanSubItem> list,
  }) async {
    final ctrl = TextEditingController();

    final res = await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Add new - $sectionName"),
          content: TextField(
            controller: ctrl,
            autofocus: true,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final v = ctrl.text.trim();
                if (v.isEmpty) return;
                Navigator.pop(ctx, v);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );

    // ✅ IMPORTANT: after await, check mounted
    if (!mounted) return;

    if (res != null && res.trim().isNotEmpty) {
      setState(() => list.add(CarePlanSubItem(title: res.trim())));
    }

    // ✅ DO NOT dispose ctrl here (it can still be used during dialog closing animation)
    // ctrl.dispose();
  }

  void _removeItem(List<CarePlanSubItem> list, int index) {
    setState(() => list.removeAt(index));
  }

  void _save() {
    // TODO: call API / bloc
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Saved (UI only)")));
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final bool isMobile = w < 900;
    final bool isTablet = w >= 600 && w < 1024;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: CustomAppBar(title: "Care Plan", centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: isMobile ? 12 : 18,
            right: isMobile ? 12 : 18,
            top: 14,
            bottom: 18,
          ),
          child: Column(
            children: [
              _PurpleHeaderBar(
                title: "Care Plan",
                onBack: () => Navigator.maybePop(context),
              ),
              const SizedBox(height: 12),

              // Main card
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Color(0xFFE7E7EF)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(isTablet ? 14 : 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Label("Support Task"),
                      const SizedBox(height: 6),
                      _TextField(ctrl: suprtTaskCtrl, hint: "Title"),
                      const SizedBox(height: 16),

                      _Label("Code"),
                      const SizedBox(height: 6),
                      _TextField(ctrl: codeCtrl, hint: "", minLines: 1),
                      const SizedBox(height: 18),

                      _Label("Price"),
                      const SizedBox(height: 6),
                      _TextField(ctrl: priceCtrl, hint: "", minLines: 1),

                      const SizedBox(height: 24),

                      // Save button aligned right like screenshot
                      Row(
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: 42,
                            child: ElevatedButton(
                              onPressed: _save,
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xFF7B1FA2),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Save",
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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

/// ---------------- TOP PURPLE BAR (inside page) ----------------

class _PurpleHeaderBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const _PurpleHeaderBar({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF7B1FA2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 34,
              child: ElevatedButton(
                onPressed: onBack,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF00BFA5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Back",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------- SECTION TABLE ----------------

class _SectionTable extends StatelessWidget {
  final bool isMobile;
  final List<CarePlanSubItem> items;
  final VoidCallback onAdd;
  final ValueChanged<int> onDelete;

  const _SectionTable({
    required this.isMobile,
    required this.items,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TableHeader(isMobile: true),
          const SizedBox(height: 10),
          if (items.isEmpty)
            const _EmptyRow()
          else
            ...List.generate(items.length, (i) {
              final e = items[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7FB),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE7E7EF)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        e.title,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () => onDelete(i),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Color(0xFFE53935),
                      ),
                    ),
                  ],
                ),
              );
            }),
          _AddNewBtn(onTap: onAdd),
        ],
      );
    }

    // Desktop/table view
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TableHeader(isMobile: false),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE7E7EF)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              if (items.isEmpty)
                const _EmptyRow()
              else
                ...List.generate(items.length, (i) {
                  final e = items[i];
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFE7E7EF)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            child: Text(e.title),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                height: 30,
                                child: ElevatedButton.icon(
                                  onPressed: () => onDelete(i),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    size: 16,
                                  ),
                                  label: const Text("Delete"),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: const Color(0xFFE53935),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _AddNewBtn(onTap: onAdd),
      ],
    );
  }
}

class _TableHeader extends StatelessWidget {
  final bool isMobile;
  const _TableHeader({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Text(
            "Title",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              fontSize: isMobile ? 12.5 : 13.5,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            "Action",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              fontSize: isMobile ? 12.5 : 13.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _AddNewBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _AddNewBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xFF7B1FA2),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          "Add new +",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

class _EmptyRow extends StatelessWidget {
  const _EmptyRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE7E7EF)),
      ),
      child: const Text(
        "No items added",
        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// ---------------- SMALL UI PARTS ----------------

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController ctrl;
  final String hint;
  final int minLines;

  const _TextField({required this.ctrl, required this.hint, this.minLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      minLines: minLines,
      maxLines: minLines == 1 ? 1 : null,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE7E7EF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE7E7EF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF7B1FA2), width: 1.2),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 15,
        color: Colors.black87,
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFDDA3E9), width: 1)),
      ),
    );
  }
}

/// ---------------- MODEL ----------------

class CarePlanSubItem {
  final String title;
  const CarePlanSubItem({required this.title});
}
