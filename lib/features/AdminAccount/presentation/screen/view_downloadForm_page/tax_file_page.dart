import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';
import 'package:getcare360/features/AdminAccount/presentation/widget/View_download_widget/view_downloadForm_widget.dart';

class AdminTaxFileNumberDeclarationFormPage extends StatefulWidget {
  final VoidCallback? onSubmit;
  final VoidCallback? onViewFile;

  const AdminTaxFileNumberDeclarationFormPage({
    super.key,
    this.onSubmit,
    this.onViewFile,
  });

  @override
  State<AdminTaxFileNumberDeclarationFormPage> createState() =>
      _AdminTaxFileNumberDeclarationFormPageState();
}

class _AdminTaxFileNumberDeclarationFormPageState
    extends State<AdminTaxFileNumberDeclarationFormPage> {
  static const Color brandPurple = Color(0xFF9C27B0);
  static const Color pageBg = Color(0xFFF3F4F8);

  String _pickedFileName = "No file chosen";

  void _pick() {
    // Hook file_picker here.
    setState(() => _pickedFileName = "tax_file_declaration.pdf");
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
      appBar: const CustomAppBar(title: "Tax File Number Declaration Form"),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) {
            return SingleChildScrollView(
              child: SizedBox(
                height: c.maxHeight,
                child:
                    const ViewDownloadBasePage(
                      title: "Tax file number declaration form",
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
