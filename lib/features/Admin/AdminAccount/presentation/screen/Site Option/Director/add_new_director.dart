import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/admin_ui.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class AddNewDirectorPage extends StatefulWidget {
  final VoidCallback? onSubmit;
  const AddNewDirectorPage({super.key, this.onSubmit});

  @override
  State<AddNewDirectorPage> createState() => _AddNewDirectorPageState();
}

class _AddNewDirectorPageState extends State<AddNewDirectorPage> {
  final _nameCtrl = TextEditingController();

  // signature strokes
  final List<List<Offset>> _strokes = [];
  List<Offset> _current = [];
  bool _saved = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  void _clear() {
    setState(() {
      _strokes.clear();
      _current = [];
      _saved = false;
    });
  }

  void _undo() {
    if (_strokes.isEmpty) return;
    setState(() {
      _strokes.removeLast();
      _saved = false;
    });
  }

  void _saveSignature() {
    setState(() => _saved = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Signature saved for submission")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminUi.pageBg,
      appBar: const CustomAppBar(title: "Add New Director"),
      body: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;
          final isMobile = w < 700;
          final isTablet = w >= 700 && w < 1100;

          final hp = isMobile ? 12.0 : 22.0;
          final cardMax = isMobile
              ? double.infinity
              : (isTablet ? 920.0 : 760.0);
          final pad = isMobile ? 14.0 : 18.0;

          // Make signature box ratio adapt a bit for narrow screens
          final sigRatio = isMobile ? 2.2 : 2.9;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: hp,
                  vertical: isMobile ? 12 : 20,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: cardMax),
                    child: AdminCardShell(
                      child: Column(
                        children: [
                          const AdminPurpleHeader(
                            title: "Director Name & Signature",
                          ),

                          // ✅ Always scrollable so no RenderFlex overflow
                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.all(pad),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AdminSectionLabel(
                                    "Full Name of director",
                                  ),
                                  TextField(
                                    controller: _nameCtrl,
                                    decoration: AdminUi.input("Full name"),
                                  ),
                                  const SizedBox(height: 18),

                                  const AdminSectionLabel("Upload Image"),
                                  _UploadRowResponsive(
                                    onPick: () => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Pick file (use file_picker)",
                                            ),
                                          ),
                                        ),
                                    fileName: "No file chosen",
                                    stack: isMobile,
                                  ),
                                  const SizedBox(height: 16),

                                  const Center(
                                    child: Text(
                                      "---- OR ----",
                                      style: TextStyle(
                                        color: Color(0xFF757575),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 14),

                                  _SignatureBox(
                                    aspectRatio: sigRatio,
                                    saved: _saved,
                                    strokes: _strokes,
                                    current: _current,
                                    onStart: (p) =>
                                        setState(() => _current = [p]),
                                    onMove: (p) =>
                                        setState(() => _current.add(p)),
                                    onEnd: () => setState(() {
                                      if (_current.isNotEmpty)
                                        _strokes.add(List.of(_current));
                                      _current = [];
                                      _saved = false;
                                    }),
                                  ),

                                  const SizedBox(height: 10),

                                  // ✅ Row may overflow on small screens -> Wrap
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      TextButton(
                                        onPressed: _clear,
                                        child: const Text("Clear"),
                                      ),
                                      TextButton(
                                        onPressed: _undo,
                                        child: const Text("Undo"),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  Align(
                                    alignment: Alignment.center,
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 520,
                                      ),
                                      child: SizedBox(
                                        width: isMobile
                                            ? double.infinity
                                            : null,
                                        child: _SaveSigButton(
                                          onTap: _saveSignature,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                  const Text(
                                    "*** Please click \"Click Here to Save Signature for Submission\" if you are using the signature pad; otherwise, the signature will not be saved.",
                                    style: TextStyle(
                                      color: Color(0xFF616161),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Divider(height: 1),

                          Padding(
                            padding: EdgeInsets.fromLTRB(pad, 14, pad, 16),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: isMobile ? double.infinity : null,
                                child: ElevatedButton(
                                  onPressed:
                                      widget.onSubmit ??
                                      () => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                            const SnackBar(
                                              content: Text("Submit clicked"),
                                            ),
                                          ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AdminUi.brandPurple,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text(
                                    "Submit",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
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
              ),
            ),
          );
        },
      ),
    );
  }
}

class _UploadRowResponsive extends StatelessWidget {
  final VoidCallback onPick;
  final String fileName;
  final bool stack;

  const _UploadRowResponsive({
    required this.onPick,
    required this.fileName,
    required this.stack,
  });

  @override
  Widget build(BuildContext context) {
    final box = BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE6E6E6)),
      borderRadius: BorderRadius.circular(6),
    );

    if (stack) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: box,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedButton(onPressed: onPick, child: const Text("Choose file")),
            const SizedBox(height: 10),
            Text(
              fileName,
              style: const TextStyle(
                color: Color(0xFF9E9E9E),
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: box,
      child: Row(
        children: [
          OutlinedButton(onPressed: onPick, child: const Text("Choose file")),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              fileName,
              style: const TextStyle(
                color: Color(0xFF9E9E9E),
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

class _SaveSigButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SaveSigButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: const Color(0xFF66BB6A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text(
              "Click Here to Save Signature for Submission",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 12.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignatureBox extends StatelessWidget {
  final double aspectRatio;
  final bool saved;
  final List<List<Offset>> strokes;
  final List<Offset> current;
  final void Function(Offset p) onStart;
  final void Function(Offset p) onMove;
  final VoidCallback onEnd;

  const _SignatureBox({
    required this.aspectRatio,
    required this.saved,
    required this.strokes,
    required this.current,
    required this.onStart,
    required this.onMove,
    required this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF2B2B2B), width: 1.5),
          borderRadius: BorderRadius.circular(2),
        ),
        child: LayoutBuilder(
          builder: (context, c) {
            final isNarrow = c.maxWidth < 520;
            final leftFlex = isNarrow ? 4 : 3;
            final rightFlex = isNarrow ? 1 : 2;

            return Row(
              children: [
                Expanded(
                  flex: leftFlex,
                  child: GestureDetector(
                    onPanStart: (d) => onStart(d.localPosition),
                    onPanUpdate: (d) => onMove(d.localPosition),
                    onPanEnd: (_) => onEnd(),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _SignaturePainter(
                              strokes: strokes,
                              current: current,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 34,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Color(0xFF2B2B2B),
                                  width: 1,
                                ),
                              ),
                              color: Color(0xFF3B3B3B),
                            ),
                            child: Text(
                              saved ? "Saved" : "Sign above",
                              style: TextStyle(
                                color: saved
                                    ? const Color(0xFFB2F5EA)
                                    : Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: rightFlex,
                  child: Container(color: const Color(0xFF3B3B3B)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SignaturePainter extends CustomPainter {
  final List<List<Offset>> strokes;
  final List<Offset> current;

  _SignaturePainter({required this.strokes, required this.current});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final s in strokes) {
      if (s.length < 2) continue;
      final path = Path()..moveTo(s.first.dx, s.first.dy);
      for (int i = 1; i < s.length; i++) {
        path.lineTo(s[i].dx, s[i].dy);
      }
      canvas.drawPath(path, paint);
    }

    if (current.length >= 2) {
      final path = Path()..moveTo(current.first.dx, current.first.dy);
      for (int i = 1; i < current.length; i++) {
        path.lineTo(current[i].dx, current[i].dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SignaturePainter oldDelegate) {
    return oldDelegate.strokes != strokes || oldDelegate.current != current;
  }
}
