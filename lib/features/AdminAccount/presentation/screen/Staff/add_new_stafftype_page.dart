import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class AdminAddNewStaffTypePage extends StatefulWidget {
  const AdminAddNewStaffTypePage({super.key});

  @override
  State<AdminAddNewStaffTypePage> createState() => AddNewStaffTypePageState();
}

class AddNewStaffTypePageState extends State<AdminAddNewStaffTypePage> {
  static const Color pageBg = Color(0xFFF3F4F8);
  static const Color brandPurple = Color(0xFF8E24AA);

  final TextEditingController designationCtrl = TextEditingController();
  final TextEditingController normalHoursCtrl = TextEditingController();
  final TextEditingController payCtrl = TextEditingController();

  bool activeInOrg = false;

  @override
  void dispose() {
    designationCtrl.dispose();
    normalHoursCtrl.dispose();
    payCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final bool isDesktop = w >= 980;

    return Scaffold(
      appBar: CustomAppBar(title: 'Add New StaffType', centerTitle: true),
      backgroundColor: pageBg,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1150),
                          child: AddStaffTypeCard(
                            onBack: () => Navigator.pop(context),
                            designationCtrl: designationCtrl,
                            normalHoursCtrl: normalHoursCtrl,
                            payCtrl: payCtrl,
                            activeInOrg: activeInOrg,
                            onToggleActive: (v) =>
                                setState(() => activeInOrg = v),
                            onSubmit: () {},
                          ),
                        ),
                      ),
                    ),
                  ),
                  const FooterBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddStaffTypeCard extends StatelessWidget {
  static const Color brandPurple = Color(0xFF8E24AA);

  final VoidCallback onBack;

  final TextEditingController designationCtrl;
  final TextEditingController normalHoursCtrl;
  final TextEditingController payCtrl;

  final bool activeInOrg;
  final ValueChanged<bool> onToggleActive;

  final VoidCallback onSubmit;

  const AddStaffTypeCard({
    super.key,
    required this.onBack,
    required this.designationCtrl,
    required this.normalHoursCtrl,
    required this.payCtrl,
    required this.activeInOrg,
    required this.onToggleActive,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final bool isMobile = w < 720;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: brandPurple,
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Staff type",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  height: 34,
                  child: ElevatedButton(
                    onPressed: onBack,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00B3A6),
                      foregroundColor: Colors.white,
                      elevation: 0,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isMobile) ...[
                  FieldLabel("Job designation"),
                  const SizedBox(height: 6),
                  AppTextField(
                    controller: designationCtrl,
                    hint: "Job designation",
                  ),
                  const SizedBox(height: 14),

                  FieldLabel("Employee Normal Hours"),
                  const SizedBox(height: 6),
                  AppTextField(
                    controller: normalHoursCtrl,
                    hint: "Employee Normal Hours",
                  ),
                  const SizedBox(height: 14),

                  FieldLabel("Pay"),
                  const SizedBox(height: 6),
                  AppTextField(controller: payCtrl, hint: "Pay"),
                ] else ...[
                  FieldLabel("Job designation"),
                  const SizedBox(height: 6),
                  AppTextField(
                    controller: designationCtrl,
                    hint: "Job designation",
                  ),
                  const SizedBox(height: 14),

                  FieldLabel("Employee Normal Hours"),
                  const SizedBox(height: 6),
                  AppTextField(
                    controller: normalHoursCtrl,
                    hint: "Employee Normal Hours",
                  ),
                  const SizedBox(height: 14),

                  FieldLabel("Pay"),
                  const SizedBox(height: 6),
                  AppTextField(controller: payCtrl, hint: "Pay"),
                ],

                const SizedBox(height: 14),

                Row(
                  children: [
                    Checkbox(
                      value: activeInOrg,
                      onChanged: (v) => onToggleActive(v ?? false),
                    ),
                    const Text(
                      "Activate in Organization",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 38,
                      child: ElevatedButton(
                        onPressed: onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandPurple,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w800,
        color: Color(0xFF374151),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const AppTextField({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE6E8EF)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE6E8EF)),
          ),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Layout: Top bar + Side menu + Footer
/// ------------------------------------------------------------
class TopHeaderBar extends StatelessWidget {
  static const Color brandPurple = Color(0xFF8E24AA);

  final String titleLeft;
  final String userLabel;
  final VoidCallback? onMenuTap;

  const TopHeaderBar({
    super.key,
    required this.titleLeft,
    required this.userLabel,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final bool isDesktop = w >= 980;

    return Container(
      height: 58,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          if (!isDesktop)
            IconButton(onPressed: onMenuTap, icon: const Icon(Icons.menu)),

          Text(
            titleLeft,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xFF6B7280),
            ),
          ),
          const Spacer(),

          Container(
            height: 58,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: const BoxDecoration(color: brandPurple),
            child: Row(
              children: [
                const Icon(Icons.notifications_none, color: Colors.white),
                const SizedBox(width: 14),
                Text(
                  "Hi, $userLabel",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color(0xFF00B3A6),
                  child: const Text(
                    "T",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FooterBar extends StatelessWidget {
  const FooterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFEDEFF6),
      child: const Text(
        "2025©",
        style: TextStyle(color: Color(0xFF9CA3AF), fontWeight: FontWeight.w700),
      ),
    );
  }
}

enum SideMenuItem {
  dashboard,
  organization,
  staff,
  availability,
  staffTypeSettings,
  allStaffType,
  addStaffType,
  staffGroup,
}

class SideMenu extends StatelessWidget {
  static const Color sidePurple = Color(0xFF9C27B0);

  final SideMenuItem current;

  const SideMenu({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: sidePurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              "MENU",
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
          ),
          SideMenuTile(
            icon: Icons.dashboard_outlined,
            label: "Dashboard",
            selected: current == SideMenuItem.dashboard,
            onTap: () {},
          ),
          SideMenuTile(
            icon: Icons.apartment_outlined,
            label: "Organization",
            selected: current == SideMenuItem.organization,
            onTap: () {},
          ),
          const SideMenuSection(label: "Staff"),
          SideMenuTile(
            icon: Icons.people_outline,
            label: "All Staffs",
            selected: current == SideMenuItem.staff,
            onTap: () {},
            indent: 14,
          ),
          SideMenuTile(
            icon: Icons.event_available_outlined,
            label: "Availability",
            selected: current == SideMenuItem.availability,
            onTap: () {},
            indent: 14,
          ),
          const SideMenuSection(label: "Staff Type Settings"),
          SideMenuTile(
            icon: Icons.list_alt_outlined,
            label: "All Staff Type",
            selected: current == SideMenuItem.allStaffType,
            onTap: () {},
            indent: 14,
          ),
          SideMenuTile(
            icon: Icons.add_box_outlined,
            label: "Add New Staff Type",
            selected: current == SideMenuItem.addStaffType,
            onTap: () {},
            indent: 14,
          ),
          SideMenuTile(
            icon: Icons.groups_outlined,
            label: "Staff Group Settings",
            selected: current == SideMenuItem.staffGroup,
            onTap: () {},
            indent: 0,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class SideMenuSection extends StatelessWidget {
  final String label;
  const SideMenuSection({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
    );
  }
}

class SideMenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final double indent;

  const SideMenuTile({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.indent = 0,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = selected ? const Color(0xFF7B1FA2) : Colors.transparent;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 46,
        padding: EdgeInsets.only(left: 16 + indent, right: 16),
        decoration: BoxDecoration(color: bg),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (indent == 0)
              const Icon(Icons.chevron_right, color: Colors.white70, size: 18),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Model
/// ------------------------------------------------------------
class StaffTypeItem {
  final String designation;
  final String normalHour;
  final String pay;
  final String organization;

  const StaffTypeItem({
    required this.designation,
    required this.normalHour,
    required this.pay,
    required this.organization,
  });
}
