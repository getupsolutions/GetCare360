import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class AdminAddPolicyAndProcedurePage extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onSubmit;

  const AdminAddPolicyAndProcedurePage({super.key, this.onBack, this.onSubmit});

  @override
  State<AdminAddPolicyAndProcedurePage> createState() =>
      _AdminAddPolicyAndProcedurePageState();
}

class _AdminAddPolicyAndProcedurePageState
    extends State<AdminAddPolicyAndProcedurePage> {
  static const Color brandPurple = Color(0xFF9C27B0);
  static const Color pageBg = Color(0xFFF3F4F8);

  final _titleCtrl = TextEditingController();
  String _pickedFileName = "No file chosen";

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint) {
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
        borderSide: const BorderSide(color: brandPurple, width: 1.2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBg,
      appBar: const CustomAppBar(title: 'Add Policy & Procedure'),
      body: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;
          final isMobile = w < 700;
          final horizontalPad = isMobile ? 12.0 : 22.0;

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
                      _HeaderBar(
                        title: "Policy & Procedure",
                        trailing: _ActionChipButton(
                          label: "Back",
                          bg: const Color(0xFF00BFA5),
                          onTap:
                              widget.onBack ??
                              () {
                                Navigator.pop(context);
                              },
                        ),
                      ),

                      // ✅ scrollable on small heights
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(isMobile ? 14 : 18),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: isMobile ? 520 : 920,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const _FieldLabel("Title"),
                                  TextField(
                                    controller: _titleCtrl,
                                    decoration: _inputDecoration("Title"),
                                  ),
                                  const SizedBox(height: 16),
                                  const _FieldLabel("File"),
                                  _FilePickerRow(
                                    fileName: _pickedFileName,
                                    onPick: () {
                                      // Hook file_picker here.
                                      setState(
                                        () => _pickedFileName = "policy.pdf",
                                      );
                                    },
                                    stackOnNarrow: isMobile,
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    "File should be less than 6MB",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF9E9E9E),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 22),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: _PrimaryButton(
                                      label: "Submit",
                                      onTap:
                                          widget.onSubmit ??
                                          () {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text("Submit clicked"),
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                ],
                              ),
                            ),
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

/// ---------------------------------- UI helpers ----------------------------------

class _CardShell extends StatelessWidget {
  final Widget child;
  const _CardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: const Color(0x11000000),
      borderRadius: BorderRadius.circular(10),
      child: ClipRRect(borderRadius: BorderRadius.circular(10), child: child),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const _HeaderBar({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF9C27B0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: LayoutBuilder(
        builder: (context, c) {
          final isTight = c.maxWidth < 520;

          if (isTight) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: trailing ?? const SizedBox.shrink(),
                ),
              ],
            );
          }

          return Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          );
        },
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Color(0xFF5A5A5A),
        ),
      ),
    );
  }
}

class _FilePickerRow extends StatelessWidget {
  final String fileName;
  final VoidCallback onPick;
  final bool stackOnNarrow;

  const _FilePickerRow({
    required this.fileName,
    required this.onPick,
    this.stackOnNarrow = false,
  });

  @override
  Widget build(BuildContext context) {
    if (stackOnNarrow) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFD),
          border: Border.all(color: const Color(0xFFE6E6E6)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedButton(
              onPressed: onPick,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Choose file"),
            ),
            const SizedBox(height: 10),
            Text(
              fileName,
              style: const TextStyle(
                color: Color(0xFF616161),
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }

    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFD),
        border: Border.all(color: const Color(0xFFE6E6E6)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: onPick,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Choose file"),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              fileName,
              style: const TextStyle(
                color: Color(0xFF616161),
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF9C27B0),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
    );
  }
}

class _ActionChipButton extends StatelessWidget {
  final String label;
  final Color bg;
  final VoidCallback onTap;

  const _ActionChipButton({
    required this.label,
    required this.bg,
    required this.onTap,
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
