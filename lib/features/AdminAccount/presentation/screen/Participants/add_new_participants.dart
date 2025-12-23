import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class AdminAddnewParticipantPage extends StatefulWidget {
  const AdminAddnewParticipantPage({super.key});

  @override
  State<AdminAddnewParticipantPage> createState() => _AddNewParticipantPageNdisState();
}

class _AddNewParticipantPageNdisState extends State<AdminAddnewParticipantPage> {
  // Top tabs
  final List<_TopTab> topTabs = const [
    _TopTab("Assessment", Icons.fact_check_outlined),
    _TopTab("Progress Notes", Icons.note_alt_outlined),
    _TopTab("Charts", Icons.insert_chart_outlined),
    _TopTab("Care Plan", Icons.assignment_outlined),
    _TopTab("Documents", Icons.folder_open_outlined),
    _TopTab("Staffing", Icons.groups_outlined),
  ];
  int selectedTopTab = 0;

  // Left section menu (inner menu)
  final List<String> sections = const [
    "Personal Details",
    "Profile",
    "Participants Details",
    "Medical Information",
    "Health Information",
    "Risk Assessment",
    "Service Agreement Details",
    "Generated Service Agreement",
    "OTP Settings",
  ];
  int selectedSection = 0;

  // Form controllers (sample)
  final firstNameCtrl = TextEditingController();
  final middleNameCtrl = TextEditingController();
  final surNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final suburbCtrl = TextEditingController();
  final streetCtrl = TextEditingController();
  final postcodeCtrl = TextEditingController();
  final ndisNoCtrl = TextEditingController();
  final directorCtrl = TextEditingController();
  final privacyPrefCtrl = TextEditingController();
  final bioCtrl = TextEditingController();
  final familyCtrl = TextEditingController();
  final culturalCtrl = TextEditingController();
  final medicareCtrl = TextEditingController();
  final dvaCtrl = TextEditingController();

  // Form state
  String pronoun = "He";
  String gender = "Male";
  String maritalStatus = "Choose";
  String state = "Select State";
  String locationGroup = "Select Location Group";

  @override
  void dispose() {
    firstNameCtrl.dispose();
    middleNameCtrl.dispose();
    surNameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    suburbCtrl.dispose();
    streetCtrl.dispose();
    postcodeCtrl.dispose();
    ndisNoCtrl.dispose();
    directorCtrl.dispose();
    privacyPrefCtrl.dispose();
    bioCtrl.dispose();
    familyCtrl.dispose();
    culturalCtrl.dispose();
    medicareCtrl.dispose();
    dvaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;

    // Breakpoints
    final bool isMobile = w < 700;
    final bool isTablet = w >= 700 && w < 1100;
    final bool isDesktop = w >= 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: CustomAppBar(title: "Add New Participant", centerTitle: true),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1300),
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 12 : 18),
              child: Column(
                children: [
                  _TopTabsBar(
                    tabs: topTabs,
                    selected: selectedTopTab,
                    onSelect: (i) => setState(() => selectedTopTab = i),
                  ),
                  const SizedBox(height: 12),

                  Expanded(
                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: const BorderSide(color: Color(0xFFE7E7EF)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 12 : 16),
                        child: isMobile
                            ? _MobileLayout(
                                sections: sections,
                                selectedSection: selectedSection,
                                onSelectSection: (i) =>
                                    setState(() => selectedSection = i),
                                form: _FormArea(
                                  isMobile: true,
                                  columns: 1,
                                  pronoun: pronoun,
                                  gender: gender,
                                  maritalStatus: maritalStatus,
                                  stateValue: state,
                                  locationGroup: locationGroup,
                                  firstNameCtrl: firstNameCtrl,
                                  middleNameCtrl: middleNameCtrl,
                                  surNameCtrl: surNameCtrl,
                                  emailCtrl: emailCtrl,
                                  phoneCtrl: phoneCtrl,
                                  suburbCtrl: suburbCtrl,
                                  streetCtrl: streetCtrl,
                                  postcodeCtrl: postcodeCtrl,
                                  ndisNoCtrl: ndisNoCtrl,
                                  directorCtrl: directorCtrl,
                                  privacyPrefCtrl: privacyPrefCtrl,
                                  bioCtrl: bioCtrl,
                                  familyCtrl: familyCtrl,
                                  culturalCtrl: culturalCtrl,
                                  medicareCtrl: medicareCtrl,
                                  dvaCtrl: dvaCtrl,
                                  onChangePronoun: (v) =>
                                      setState(() => pronoun = v),
                                  onChangeGender: (v) =>
                                      setState(() => gender = v),
                                  onChangeMarital: (v) =>
                                      setState(() => maritalStatus = v),
                                  onChangeState: (v) =>
                                      setState(() => state = v),
                                  onChangeLocationGroup: (v) =>
                                      setState(() => locationGroup = v),
                                ),
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                    width: isTablet ? 260 : 300,
                                    child: _LeftProfileMenu(
                                      sections: sections,
                                      selected: selectedSection,
                                      onSelect: (i) =>
                                          setState(() => selectedSection = i),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _FormArea(
                                      isMobile: false,
                                      columns: isDesktop ? 3 : 2,
                                      pronoun: pronoun,
                                      gender: gender,
                                      maritalStatus: maritalStatus,
                                      stateValue: state,
                                      locationGroup: locationGroup,
                                      firstNameCtrl: firstNameCtrl,
                                      middleNameCtrl: middleNameCtrl,
                                      surNameCtrl: surNameCtrl,
                                      emailCtrl: emailCtrl,
                                      phoneCtrl: phoneCtrl,
                                      suburbCtrl: suburbCtrl,
                                      streetCtrl: streetCtrl,
                                      postcodeCtrl: postcodeCtrl,
                                      ndisNoCtrl: ndisNoCtrl,
                                      directorCtrl: directorCtrl,
                                      privacyPrefCtrl: privacyPrefCtrl,
                                      bioCtrl: bioCtrl,
                                      familyCtrl: familyCtrl,
                                      culturalCtrl: culturalCtrl,
                                      medicareCtrl: medicareCtrl,
                                      dvaCtrl: dvaCtrl,
                                      onChangePronoun: (v) =>
                                          setState(() => pronoun = v),
                                      onChangeGender: (v) =>
                                          setState(() => gender = v),
                                      onChangeMarital: (v) =>
                                          setState(() => maritalStatus = v),
                                      onChangeState: (v) =>
                                          setState(() => state = v),
                                      onChangeLocationGroup: (v) =>
                                          setState(() => locationGroup = v),
                                    ),
                                  ),
                                ],
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
    );
  }
}

/// ---------------------- TOP TABS ----------------------

class _TopTab {
  final String title;
  final IconData icon;
  const _TopTab(this.title, this.icon);
}

class _TopTabsBar extends StatelessWidget {
  final List<_TopTab> tabs;
  final int selected;
  final ValueChanged<int> onSelect;

  const _TopTabsBar({
    required this.tabs,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final t = tabs[i];
          final active = i == selected;

          return InkWell(
            onTap: () => onSelect(i),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: active ? const Color(0xFF7B1FA2) : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE7E7EF)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    t.icon,
                    size: 18,
                    color: active ? Colors.white : Colors.black54,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    t.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: active ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ---------------------- LEFT PROFILE MENU ----------------------

class _LeftProfileMenu extends StatelessWidget {
  final List<String> sections;
  final int selected;
  final ValueChanged<int> onSelect;

  const _LeftProfileMenu({
    required this.sections,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AvatarCard(),
        const SizedBox(height: 12),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7FB),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE7E7EF)),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: sections.length,
              itemBuilder: (context, i) {
                final active = i == selected;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => onSelect(i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: active ? const Color(0xFF7B1FA2) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE7E7EF)),
                      ),
                      child: Text(
                        sections[i],
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: active ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _AvatarCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE7E7EF)),
      ),
      child: Column(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF7B1FA2), width: 2),
              color: const Color(0xFFF3F4F8),
            ),
            child: const Icon(Icons.person, size: 90, color: Colors.black26),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF7B1FA2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                "Upload Photo",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------- MOBILE LAYOUT ----------------------

class _MobileLayout extends StatelessWidget {
  final List<String> sections;
  final int selectedSection;
  final ValueChanged<int> onSelectSection;
  final Widget form;

  const _MobileLayout({
    required this.sections,
    required this.selectedSection,
    required this.onSelectSection,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _AvatarCard(),
        const SizedBox(height: 12),

        // section selector (mobile)
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7FB),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE7E7EF)),
          ),
          child: DropdownButtonFormField<int>(
            value: selectedSection,
            decoration: const InputDecoration(
              labelText: "Section",
              border: OutlineInputBorder(),
            ),
            items: List.generate(
              sections.length,
              (i) => DropdownMenuItem(value: i, child: Text(sections[i])),
            ),
            onChanged: (v) {
              if (v != null) onSelectSection(v);
            },
          ),
        ),

        const SizedBox(height: 12),
        form,
      ],
    );
  }
}

/// ---------------------- FORM AREA ----------------------

class _FormArea extends StatelessWidget {
  final bool isMobile;
  final int columns;

  final String pronoun;
  final String gender;
  final String maritalStatus;
  final String stateValue;
  final String locationGroup;

  final TextEditingController firstNameCtrl;
  final TextEditingController middleNameCtrl;
  final TextEditingController surNameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController suburbCtrl;
  final TextEditingController streetCtrl;
  final TextEditingController postcodeCtrl;
  final TextEditingController ndisNoCtrl;
  final TextEditingController directorCtrl;
  final TextEditingController privacyPrefCtrl;
  final TextEditingController bioCtrl;
  final TextEditingController familyCtrl;
  final TextEditingController culturalCtrl;
  final TextEditingController medicareCtrl;
  final TextEditingController dvaCtrl;

  final ValueChanged<String> onChangePronoun;
  final ValueChanged<String> onChangeGender;
  final ValueChanged<String> onChangeMarital;
  final ValueChanged<String> onChangeState;
  final ValueChanged<String> onChangeLocationGroup;

  const _FormArea({
    required this.isMobile,
    required this.columns,
    required this.pronoun,
    required this.gender,
    required this.maritalStatus,
    required this.stateValue,
    required this.locationGroup,
    required this.firstNameCtrl,
    required this.middleNameCtrl,
    required this.surNameCtrl,
    required this.emailCtrl,
    required this.phoneCtrl,
    required this.suburbCtrl,
    required this.streetCtrl,
    required this.postcodeCtrl,
    required this.ndisNoCtrl,
    required this.directorCtrl,
    required this.privacyPrefCtrl,
    required this.bioCtrl,
    required this.familyCtrl,
    required this.culturalCtrl,
    required this.medicareCtrl,
    required this.dvaCtrl,
    required this.onChangePronoun,
    required this.onChangeGender,
    required this.onChangeMarital,
    required this.onChangeState,
    required this.onChangeLocationGroup,
  });

  @override
  Widget build(BuildContext context) {
    final gap = isMobile ? 10.0 : 14.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Personal Details"),
        const SizedBox(height: 8),

        // Pronoun
        _radioRow(
          title: "Preferred Pronoun",
          value: pronoun,
          options: const ["He", "She", "They"],
          onChange: onChangePronoun,
        ),
        const SizedBox(height: 12),

        // Grid fields
        _Grid(
          columns: columns,
          gap: gap,
          children: [
            _field("First Name*", firstNameCtrl),
            _field("Middle Name", middleNameCtrl),
            _field("Surname*", surNameCtrl),

            _dateField("Date of Birth*"),
            _radioInlineGender(gender, onChangeGender),

            _field("Email*", emailCtrl),
            _field("Mobile/Phone*", phoneCtrl),

            _dropdown(
              label: "Marital Status",
              value: maritalStatus,
              items: const [
                "Choose",
                "Single",
                "Married",
                "Separated",
                "Divorced",
              ],
              onChanged: onChangeMarital,
            ),
            _field("Method of Communication", TextEditingController()),
            _field("Preferred Languages", TextEditingController()),

            _field("Start typing address", TextEditingController()),
            _field("Street Address*", streetCtrl),
            _field("Suburb*", suburbCtrl),

            _dropdown(
              label: "State*",
              value: stateValue,
              items: const [
                "Select State",
                "New South Wales",
                "Victoria",
                "Queensland",
              ],
              onChanged: onChangeState,
            ),
            _field("Postcode*", postcodeCtrl),

            _field("NDIS No*", ndisNoCtrl),
            _dropdown(
              label: "Director*",
              value: "Select director",
              items: const ["Select director", "Director A", "Director B"],
              onChanged: (_) {},
            ),
            _dropdown(
              label: "Location Group*",
              value: locationGroup,
              items: const ["Select Location Group", "Group 1", "Group 2"],
              onChanged: onChangeLocationGroup,
            ),
          ],
        ),

        const SizedBox(height: 14),
        _sectionTitle("Additional Information"),
        const SizedBox(height: 8),

        _multiline("Privacy preferences", privacyPrefCtrl),
        const SizedBox(height: 10),
        _multiline("Background (Biography)*", bioCtrl),
        const SizedBox(height: 10),
        _multiline("Family details*", familyCtrl),
        const SizedBox(height: 10),
        _multiline("Cultural & linguistic background*", culturalCtrl),

        const SizedBox(height: 14),
        _Grid(
          columns: isMobile ? 1 : 2,
          gap: gap,
          children: [
            _field("Medicare No", medicareCtrl),
            _field("DVA No", dvaCtrl),
          ],
        ),

        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 120,
            height: 44,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF7B1FA2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Save",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 14,
        color: Colors.black87,
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _multiline(String label, TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      minLines: 3,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _dateField(String label) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.calendar_month_outlined),
      ),
      onTap: () async {
        // hook your date picker here
      },
    );
  }

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }

  Widget _radioRow({
    required String title,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChange,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 16,
          runSpacing: 6,
          children: options.map((o) {
            final selected = o == value;
            return InkWell(
              onTap: () => onChange(o),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: selected ? const Color(0xFF7B1FA2) : Colors.black45,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(o, style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _radioInlineGender(String value, ValueChanged<String> onChange) {
    final options = const ["Male", "Female", "Other"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Gender*", style: TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 16,
          runSpacing: 6,
          children: options.map((o) {
            final selected = o == value;
            return InkWell(
              onTap: () => onChange(o),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: selected ? const Color(0xFF7B1FA2) : Colors.black45,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(o, style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// Simple grid helper (responsive without packages)
class _Grid extends StatelessWidget {
  final int columns;
  final double gap;
  final List<Widget> children;

  const _Grid({
    required this.columns,
    required this.gap,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    if (columns <= 1) {
      return Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            SizedBox(height: i == children.length - 1 ? 0 : gap),
          ],
        ],
      );
    }

    final rows = <Widget>[];
    for (int i = 0; i < children.length; i += columns) {
      final rowChildren = <Widget>[];
      for (int j = 0; j < columns; j++) {
        final idx = i + j;
        rowChildren.add(
          Expanded(
            child: idx < children.length
                ? children[idx]
                : const SizedBox.shrink(),
          ),
        );
        if (j != columns - 1) rowChildren.add(SizedBox(width: gap));
      }
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowChildren,
        ),
      );
      if (i + columns < children.length) rows.add(SizedBox(height: gap));
    }

    return Column(children: rows);
  }
}
