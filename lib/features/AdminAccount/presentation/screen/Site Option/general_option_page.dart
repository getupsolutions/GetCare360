import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/admin_ui.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class GeneralOptionPage extends StatefulWidget {
  final VoidCallback? onSubmit;
  const GeneralOptionPage({super.key, this.onSubmit});

  @override
  State<GeneralOptionPage> createState() => _GeneralOptionPageState();
}

class _GeneralOptionPageState extends State<GeneralOptionPage> {
  final _siteTitle = TextEditingController(text: "Triniti");
  final _adminEmail = TextEditingController(text: "admin@triniticare.com.au");
  final _phone = TextEditingController();

  @override
  void dispose() {
    _siteTitle.dispose();
    _adminEmail.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminUi.pageBg,
      appBar: const CustomAppBar(title: "Site Options - General"),
      body: LayoutBuilder(
        builder: (context, c) {
          final w = c.maxWidth;
          final isMobile = w < 700;
          final isTablet = w >= 700 && w < 1100;

          final hp = isMobile ? 12.0 : 22.0;
          final cardMax = isMobile
              ? double.infinity
              : (isTablet ? 860.0 : 760.0);

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
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const AdminPurpleHeader(
                            title: "Site Options - General",
                          ),

                          // ✅ always scrollable (prevents bottom overflow)
                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.all(isMobile ? 14 : 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AdminSectionLabel("Site title:"),
                                  TextField(
                                    controller: _siteTitle,
                                    decoration: AdminUi.input("Site title"),
                                  ),
                                  const SizedBox(height: 16),

                                  const AdminSectionLabel("Admin Email:"),
                                  TextField(
                                    controller: _adminEmail,
                                    decoration: AdminUi.input("Admin Email"),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 16),

                                  const AdminSectionLabel("Phone:"),
                                  TextField(
                                    controller: _phone,
                                    decoration: AdminUi.input("Phone"),
                                    keyboardType: TextInputType.phone,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Divider(height: 1),

                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              isMobile ? 14 : 18,
                              14,
                              isMobile ? 14 : 18,
                              16,
                            ),
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
