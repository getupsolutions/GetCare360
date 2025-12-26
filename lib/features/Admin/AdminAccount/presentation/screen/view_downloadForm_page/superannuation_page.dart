import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';
import 'package:getcare360/features/Admin/AdminAccount/presentation/widget/View_download_widget/view_downloadForm_widget.dart';

class AdminSuperannuationStandardChoiceFormPage extends StatefulWidget {
  final VoidCallback? onSubmit;
  final VoidCallback? onViewFile;

  const AdminSuperannuationStandardChoiceFormPage({
    super.key,
    this.onSubmit,
    this.onViewFile,
  });

  @override
  State<AdminSuperannuationStandardChoiceFormPage> createState() =>
      _AdminSuperannuationStandardChoiceFormPageState();
}

class _AdminSuperannuationStandardChoiceFormPageState
    extends State<AdminSuperannuationStandardChoiceFormPage> {
  static const Color brandPurple = Color(0xFF9C27B0);
  static const Color pageBg = Color(0xFFF3F4F8);

  String _pickedFileName = "No file chosen";

  void _pick() {
    // Hook file_picker here.
    setState(() => _pickedFileName = "superannuation_choice_form.pdf");
  }

  void _view() {
    (widget.onViewFile ??
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("View File clicked")),
              );
            })
        .call();
  }

  void _submit() {
    (widget.onSubmit ??
            () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Submit clicked")));
            })
        .call();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Scaffold + AppBar added here
    return Scaffold(
      backgroundColor: pageBg,
      appBar: const CustomAppBar(title: "Superannuation Standard Choice Form"),
      body: SafeArea(
        // ✅ prevents overflow on small heights
        child: LayoutBuilder(
          builder: (context, c) {
            return SingleChildScrollView(
              // ✅ allows the card to fit on short screens
              child: SizedBox(
                // ✅ ensures page doesn't collapse when content small
                height: c.maxHeight,
                child:
                    const ViewDownloadBasePage(
                      title: "Superannuation Standard choice form",
                      pageBg: pageBg,
                      brandPurple: brandPurple,
                    ).build(
                      context,
                      fileName: _pickedFileName,
                      onPick: _pick,
                      onView: _view,
                      onSubmit: _submit,
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}
