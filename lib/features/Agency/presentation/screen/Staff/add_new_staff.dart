import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class AgencyAddNewStaffPage extends StatefulWidget {
  const AgencyAddNewStaffPage({super.key});

  @override
  State<AgencyAddNewStaffPage> createState() => _AddNewStaffPageState();
}

class _AddNewStaffPageState extends State<AgencyAddNewStaffPage> {
  // Controllers (plug your bloc/api later)
  final firstNameCtrl = TextEditingController();
  final middleNameCtrl = TextEditingController();
  final surNameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  final dobCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  final emergencyNameCtrl = TextEditingController();
  final emergencyRelationCtrl = TextEditingController();
  final emergencyPhoneCtrl = TextEditingController();

  // Dropdown demo values
  String? stateValue;
  String? locationGroupValue;
  String? directorValue;
  String? statusValue;

  // Worker types (checkboxes)
  final Map<String, bool> workerTypes = {
    "Agency Staff - PCA": false,
    "Business Development Manager": false,
    "Disability Support Worker": false,
    "Medicator (Cert IV)": false,
    "Plan Manager": false,
    "Support Coordinator": false,
    "Assistant in Nursing": false,
    "Chef/Cook": false,
    "Enrolled Nurse": false,
    "Office Administration Manager": false,
    "Registered Nurse Agency": false,
    "Support Coordinator/Business Development Manager": false,
    "Book Keeper": false,
    "Cleaner": false,
    "Kitchen hand": false,
    "Physiotherapy": false,
    "Registered Nurses - NDIS": false,
    "Triniti Admin": false,
  };

  @override
  void dispose() {
    firstNameCtrl.dispose();
    middleNameCtrl.dispose();
    surNameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    dobCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    emergencyNameCtrl.dispose();
    emergencyRelationCtrl.dispose();
    emergencyPhoneCtrl.dispose();
    super.dispose();
  }

  void _generatePassword() {
    // Simple demo
    const generated = "Triniti@1234";
    setState(() {
      passwordCtrl.text = generated;
      confirmPasswordCtrl.text = generated;
    });
  }

  void _save() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Saved (UI only)")));
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final bool isMobile = w < 900;
    final bool isDesktop = w >= 1100;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F8),
        appBar: CustomAppBar(title: "Add Staff", centerTitle: true),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: isMobile ? 12 : 18,
              right: isMobile ? 12 : 18,
              top: 14,
              bottom: 18,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1150),
                child: Column(
                  children: [
                    _TopTabsCard(isMobile: isMobile),
                    const SizedBox(height: 12),

                    // Main Form Card
                    Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: const BorderSide(color: Color(0xFFE7E7EF)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 12 : 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Email logs aligned right (like screenshot)
                            Row(
                              children: [
                                const Spacer(),
                                _PrimaryBtn(
                                  label: "Email Logs",
                                  onTap: () {},
                                  color: const Color(0xFF7B1FA2),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Avatar + Firstname row
                            isMobile
                                ? Column(
                                    children: [
                                      _AvatarPicker(),
                                      const SizedBox(height: 12),
                                      _FieldLabel("First Name *"),
                                      const SizedBox(height: 6),
                                      _TextInput(
                                        controller: firstNameCtrl,
                                        hint: "",
                                      ),
                                    ],
                                  )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _AvatarPicker(),
                                      const SizedBox(width: 18),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _FieldLabel("First Name *"),
                                            const SizedBox(height: 6),
                                            _TextInput(
                                              controller: firstNameCtrl,
                                              hint: "",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                            const SizedBox(height: 14),

                            // Middle Name + Surname
                            _Grid2(
                              isMobile: isMobile,
                              gap: 14,
                              left: _Labeled(
                                "Middle Name",
                                _TextInput(
                                  controller: middleNameCtrl,
                                  hint: "",
                                ),
                              ),
                              right: _Labeled(
                                "Surname *",
                                _TextInput(controller: surNameCtrl, hint: ""),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Contact Phone + State + Location Group
                            _Grid3(
                              isMobile: isMobile,
                              gap: 14,
                              a: _Labeled(
                                "Contact Phone *",
                                _TextInput(controller: phoneCtrl, hint: ""),
                              ),
                              b: _Labeled(
                                "State *",
                                _DropDown(
                                  value: stateValue,
                                  hint: "Select State",
                                  items: const ["NSW", "VIC", "ACT"],
                                  onChanged: (v) =>
                                      setState(() => stateValue = v),
                                ),
                              ),
                              c: _Labeled(
                                "Location Group *",
                                _DropDown(
                                  value: locationGroupValue,
                                  hint: "Select Location Group",
                                  items: const [
                                    "Group A",
                                    "Group B",
                                    "Group C",
                                  ],
                                  onChanged: (v) =>
                                      setState(() => locationGroupValue = v),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Worker Type checkboxes (responsive columns)
                            _FieldLabel("Worker Type *"),
                            const SizedBox(height: 10),
                            _WorkerTypeGrid(
                              map: workerTypes,
                              columns: isDesktop ? 3 : (isMobile ? 1 : 2),
                              onChanged: (k, v) =>
                                  setState(() => workerTypes[k] = v),
                            ),

                            const SizedBox(height: 16),

                            _FieldLabel("Groups"),
                            const SizedBox(height: 6),
                            _TextInput(
                              controller: TextEditingController(text: ""),
                              hint: "Select Groups",
                              enabled: false,
                            ),

                            const SizedBox(height: 14),

                            // Email + Director
                            _Grid2(
                              isMobile: isMobile,
                              gap: 14,
                              left: _Labeled(
                                "Email Address *",
                                _TextInput(controller: emailCtrl, hint: ""),
                              ),
                              right: _Labeled(
                                "Director *",
                                _DropDown(
                                  value: directorValue,
                                  hint: "Select director",
                                  items: const ["Director 1", "Director 2"],
                                  onChanged: (v) =>
                                      setState(() => directorValue = v),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // DOB + Status
                            _Grid2(
                              isMobile: isMobile,
                              gap: 14,
                              left: _Labeled(
                                "Date Of Birth *",
                                _TextInput(
                                  controller: dobCtrl,
                                  hint: "DOB",
                                  readOnly: true,
                                  onTap: () async {
                                    final now = DateTime.now();
                                    final picked = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1950),
                                      lastDate: now,
                                      initialDate: DateTime(now.year - 20),
                                    );
                                    if (picked != null) {
                                      dobCtrl.text =
                                          "${picked.day.toString().padLeft(2, "0")}/"
                                          "${picked.month.toString().padLeft(2, "0")}/"
                                          "${picked.year}";
                                    }
                                  },
                                ),
                              ),
                              right: _Labeled(
                                "Status",
                                _DropDown(
                                  value: statusValue,
                                  hint: "Current Staff",
                                  items: const ["Current Staff", "Inactive"],
                                  onChanged: (v) =>
                                      setState(() => statusValue = v),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Password + Verify password
                            _Grid2(
                              isMobile: isMobile,
                              gap: 14,
                              left: _Labeled(
                                "Password *",
                                _TextInput(
                                  controller: passwordCtrl,
                                  hint: "Password",
                                  obscure: true,
                                ),
                              ),
                              right: _Labeled(
                                "Verify Password",
                                _TextInput(
                                  controller: confirmPasswordCtrl,
                                  hint: "Confirm Password",
                                  obscure: true,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Generate button centered like screenshot
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 28,
                                child: ElevatedButton(
                                  onPressed: _generatePassword,
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: const Color(0xFF7B1FA2),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 11,
                                    ),
                                  ),
                                  child: const Text("Generate"),
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),
                            const Divider(height: 1),
                            const SizedBox(height: 14),

                            // Emergency Details
                            const Text(
                              "Emergency Details",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 12),

                            _Grid3(
                              isMobile: isMobile,
                              gap: 14,
                              a: _Labeled(
                                "Emergency contact name",
                                _TextInput(
                                  controller: emergencyNameCtrl,
                                  hint: "",
                                ),
                              ),
                              b: _Labeled(
                                "Relationship",
                                _TextInput(
                                  controller: emergencyRelationCtrl,
                                  hint: "",
                                ),
                              ),
                              c: _Labeled(
                                "Phone number",
                                _TextInput(
                                  controller: emergencyPhoneCtrl,
                                  hint: "",
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Save Button
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 42,
                                child: ElevatedButton(
                                  onPressed: _save,
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: const Color(0xFF7B1FA2),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 28,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Tab bodies placeholder (if you want same page switching)
                    // You can remove this TabBarView if you prefer route-per-tab
                    SizedBox(
                      height:
                          1, // we keep only the UI above (like your screenshot)
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          SizedBox.shrink(),
                          SizedBox.shrink(),
                          SizedBox.shrink(),
                          SizedBox.shrink(),
                          SizedBox.shrink(),
                        ],
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
  }
}

/// -------------------- TOP TABS --------------------

class _TopTabsCard extends StatelessWidget {
  final bool isMobile;
  const _TopTabsCard({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE7E7EF)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: TabBar(
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black87,
          labelStyle: const TextStyle(fontWeight: FontWeight.w900),
          indicator: BoxDecoration(
            color: const Color(0xFF7B1FA2),
            borderRadius: BorderRadius.circular(10),
          ),
          tabs: const [
            Tab(icon: Icon(Icons.key), text: "Account Details"),
            Tab(icon: Icon(Icons.article_outlined), text: "Application Form"),
            Tab(
              icon: Icon(Icons.work_outline),
              text: "Employment Or Experience",
            ),
            Tab(icon: Icon(Icons.badge_outlined), text: "Referees"),
            Tab(icon: Icon(Icons.folder_open), text: "Documents"),
          ],
        ),
      ),
    );
  }
}

/// -------------------- AVATAR --------------------

class _AvatarPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF7B1FA2), width: 2),
            color: const Color(0xFFF2F3F7),
          ),
          child: const Icon(Icons.person, size: 62, color: Colors.black38),
        ),
      ],
    );
  }
}

/// -------------------- WORKER TYPE GRID --------------------

class _WorkerTypeGrid extends StatelessWidget {
  final Map<String, bool> map;
  final int columns;
  final void Function(String key, bool value) onChanged;

  const _WorkerTypeGrid({
    required this.map,
    required this.columns,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final entries = map.entries.toList();

    return LayoutBuilder(
      builder: (context, c) {
        final col = columns.clamp(1, 3);
        return Wrap(
          spacing: 16,
          runSpacing: 6,
          children: List.generate(entries.length, (i) {
            final e = entries[i];
            final width = (c.maxWidth - (16 * (col - 1))) / col;

            return SizedBox(
              width: width,
              child: CheckboxListTile(
                value: e.value,
                onChanged: (v) => onChanged(e.key, v ?? false),
                dense: true,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(e.key, style: const TextStyle(fontSize: 13)),
              ),
            );
          }),
        );
      },
    );
  }
}

/// -------------------- SMALL UI HELPERS --------------------

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

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

class _Labeled extends StatelessWidget {
  final String label;
  final Widget child;
  const _Labeled(this.label, this.child);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_FieldLabel(label), const SizedBox(height: 6), child],
    );
  }
}

class _TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool readOnly;
  final bool enabled;
  final bool obscure;
  final VoidCallback? onTap;

  const _TextInput({
    required this.controller,
    required this.hint,
    this.readOnly = false,
    this.enabled = true,
    this.obscure = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      enabled: enabled,
      obscureText: obscure,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: enabled ? Colors.white : const Color(0xFFF3F4F8),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE7E7EF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE7E7EF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF7B1FA2), width: 1.3),
        ),
      ),
    );
  }
}

class _DropDown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropDown({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE7E7EF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE7E7EF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF7B1FA2), width: 1.3),
        ),
      ),
      hint: Text(hint),
    );
  }
}

class _PrimaryBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _PrimaryBtn({
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w900),
        ),
        child: Text(label),
      ),
    );
  }
}

/// -------------------- SIMPLE RESPONSIVE GRIDS --------------------

class _Grid2 extends StatelessWidget {
  final bool isMobile;
  final double gap;
  final Widget left;
  final Widget right;

  const _Grid2({
    required this.isMobile,
    required this.gap,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        children: [
          left,
          SizedBox(height: gap),
          right,
        ],
      );
    }
    return Row(
      children: [
        Expanded(child: left),
        SizedBox(width: gap),
        Expanded(child: right),
      ],
    );
  }
}

class _Grid3 extends StatelessWidget {
  final bool isMobile;
  final double gap;
  final Widget a;
  final Widget b;
  final Widget c;

  const _Grid3({
    required this.isMobile,
    required this.gap,
    required this.a,
    required this.b,
    required this.c,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        children: [
          a,
          SizedBox(height: gap),
          b,
          SizedBox(height: gap),
          c,
        ],
      );
    }
    return Row(
      children: [
        Expanded(child: a),
        SizedBox(width: gap),
        Expanded(child: b),
        SizedBox(width: gap),
        Expanded(child: c),
      ],
    );
  }
}
