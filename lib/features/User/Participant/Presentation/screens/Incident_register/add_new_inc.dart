import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

class AddIncidentPage extends StatefulWidget {
  const AddIncidentPage({super.key});

  @override
  State<AddIncidentPage> createState() => _AddIncidentPageState();
}

class _AddIncidentPageState extends State<AddIncidentPage> {
  int currentStep = 0;

  void _goNext() => setState(() => currentStep = (currentStep + 1).clamp(0, 2));
  void _goPrev() => setState(() => currentStep = (currentStep - 1).clamp(0, 2));

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F9),
      appBar: const CustomAppBar(title: "Incident Register", centerTitle: true),
      body: Row(
        children: [
          if (isDesktop)
            _IncidentSidebar(
              currentStep: currentStep,
              onTap: (i) => setState(() => currentStep = i),
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(isDesktop ? 18 : 12),
              child: Column(
                children: [
                  if (!isDesktop) ...[
                    _TopStepBar(
                      currentStep: currentStep,
                      onTap: (i) => setState(() => currentStep = i),
                    ),
                    const SizedBox(height: 12),
                  ],
                  Expanded(
                    child: _IncidentFormCard(
                      step: currentStep,
                      onNext: _goNext,
                      onPrev: _goPrev,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ----------------------------- SIDE / TOP STEPS ---------------------------- */

class _IncidentSidebar extends StatelessWidget {
  final int currentStep;
  final ValueChanged<int> onTap;

  const _IncidentSidebar({required this.currentStep, required this.onTap});

  static const _active = Color(0xFF00A991);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 4),
          _stepTile("1. Triniti Home Care Reference", 0),
          _stepTile("2. Incident Response", 1),
          _stepTile("3. Management And Resolution", 2),
        ],
      ),
    );
  }

  Widget _stepTile(String title, int index) {
    final active = currentStep == index;
    final enabled = index <= currentStep;

    return InkWell(
      onTap: enabled ? () => onTap(index) : null,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: active ? _active : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: active
                ? Colors.white
                : (enabled ? Colors.black87 : Colors.black38),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _TopStepBar extends StatelessWidget {
  final int currentStep;
  final ValueChanged<int> onTap;

  const _TopStepBar({required this.currentStep, required this.onTap});

  static const _active = Color(0xFF00A991);

  @override
  Widget build(BuildContext context) {
    final items = const [
      "1. Triniti Home Care Reference",
      "2. Incident Response",
      "3. Management And Resolution",
    ];

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final active = currentStep == i;
          final enabled = i <= currentStep;

          return InkWell(
            onTap: enabled ? () => onTap(i) : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: active ? _active : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  items[i],
                  style: TextStyle(
                    color: active
                        ? Colors.white
                        : (enabled ? Colors.black87 : Colors.black38),
                    fontWeight: FontWeight.w700,
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

/* ---------------------------------- CARD ---------------------------------- */

class _IncidentFormCard extends StatelessWidget {
  final int step;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const _IncidentFormCard({
    required this.step,
    required this.onNext,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE5EAF1)),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (step == 0) const _StepOne(),
                    if (step == 1) const _StepTwo(),
                    if (step == 2) const _StepThree(),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFE5EAF1))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (step > 0)
                    OutlinedButton(
                      onPressed: onPrev,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF00A991),
                        side: const BorderSide(color: Color(0xFF00A991)),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text("Previous"),
                    ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A991),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 0,
                    ),
                    child: Text(step == 2 ? "Finish" : "Next"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* --------------------------------- STEP 1 --------------------------------- */

class _StepOne extends StatefulWidget {
  const _StepOne();

  @override
  State<_StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<_StepOne> {
  final dateCompletedCtrl = TextEditingController();
  final refCodeCtrl = TextEditingController();
  final completedByCtrl = TextEditingController();
  final positionCtrl = TextEditingController();

  @override
  void dispose() {
    dateCompletedCtrl.dispose();
    refCodeCtrl.dispose();
    completedByCtrl.dispose();
    positionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _H1("Triniti Home Care Reference"),
        const SizedBox(height: 14),

        _TwoCol(
          left: _Field(
            label: "Date completed",
            hint: "To Date",
            controller: dateCompletedCtrl,
            suffix: _SuffixIcons(
              icons: const [Icons.calendar_today_outlined, Icons.close],
              onTap: [
                () async {
                  final picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );
                  if (picked != null) {
                    dateCompletedCtrl.text =
                        "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                  }
                },
                () => setState(() => dateCompletedCtrl.clear()),
              ],
            ),
          ),
          right: _Field(
            label: "Reference Code",
            hint: "Reference Code",
            controller: refCodeCtrl,
          ),
        ),

        _TwoCol(
          left: _Field(
            label: "Completed By",
            hint: "Completed By",
            controller: completedByCtrl,
          ),
          right: _Field(
            label: "Position",
            hint: "Position",
            controller: positionCtrl,
          ),
        ),
      ],
    );
  }
}

/* --------------------------------- STEP 2 --------------------------------- */

class _PersonRowCtrls {
  final name = TextEditingController();
  final contact = TextEditingController();
  void dispose() {
    name.dispose();
    contact.dispose();
  }
}

class _StepTwo extends StatefulWidget {
  const _StepTwo();

  @override
  State<_StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<_StepTwo> {
  // Incident details
  final dateCtrl = TextEditingController();
  final timeCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  String typeValue = "Actual Incident";

  final incidentDescCtrl = TextEditingController();
  final injuryDescCtrl = TextEditingController();
  final damageDescCtrl = TextEditingController();

  // Reportable
  bool reportable = false;
  final reportableTypeCtrl = TextEditingController();

  // 000 contacted
  bool contacted000 = false;
  final responseCtrl = TextEditingController();

  // Persons / Witnesses
  final persons = <_PersonRowCtrls>[_PersonRowCtrls()];
  final witnesses = <_PersonRowCtrls>[_PersonRowCtrls()];

  // Treatment
  final firstAidCtrl = TextEditingController();
  bool ambulance = false;
  bool hospital = false;
  bool gp = false;

  @override
  void dispose() {
    dateCtrl.dispose();
    timeCtrl.dispose();
    locationCtrl.dispose();
    incidentDescCtrl.dispose();
    injuryDescCtrl.dispose();
    damageDescCtrl.dispose();
    reportableTypeCtrl.dispose();
    responseCtrl.dispose();
    firstAidCtrl.dispose();
    for (final p in persons) {
      p.dispose();
    }
    for (final w in witnesses) {
      w.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _H1("Incident Details"),
        const SizedBox(height: 10),

        _TwoCol(
          left: _Field(
            label: "Date",
            hint: "Date",
            controller: dateCtrl,
            suffix: _SuffixIcons(
              icons: const [Icons.calendar_today_outlined, Icons.close],
              onTap: [
                () async {
                  final picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );
                  if (picked != null) {
                    dateCtrl.text =
                        "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                  }
                },
                () => setState(() => dateCtrl.clear()),
              ],
            ),
          ),
          right: _Field(
            label: "Time",
            hint: "Time",
            controller: timeCtrl,
            suffix: _SuffixIcons(
              icons: const [Icons.access_time_outlined, Icons.close],
              onTap: [
                () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    timeCtrl.text = picked.format(context);
                  }
                },
                () => setState(() => timeCtrl.clear()),
              ],
            ),
          ),
        ),

        _TwoCol(
          left: _Field(
            label: "Location",
            hint: "Location",
            controller: locationCtrl,
          ),
          right: _DropdownField(
            label: "Type",
            value: typeValue,
            items: const ["Actual Incident"],
            onChanged: (v) => setState(() => typeValue = v),
          ),
        ),

        _TextArea(
          label: "Description of Incident",
          hint: "Description of Incident",
          controller: incidentDescCtrl,
        ),
        _TextArea(
          label: "Description of any injuries sustained",
          hint: "Description of any injuries sustained",
          controller: injuryDescCtrl,
        ),
        _TextArea(
          label: "Description of any Damage to property",
          hint: "Description of any Damage to property",
          controller: damageDescCtrl,
        ),

        const SizedBox(height: 16),
        const _DividerLine(),
        const SizedBox(height: 16),

        const _H1("Reportable Incidents"),
        const SizedBox(height: 8),
        _RadioInline(
          label: "Is the incident reportable?",
          value: reportable,
          onChanged: (v) => setState(() => reportable = v),
        ),
        _Field(
          label: "Type of Reportable Incident",
          hint: "Type of Reportable Incident",
          controller: reportableTypeCtrl,
        ),

        const SizedBox(height: 16),
        const _DividerLine(),
        const SizedBox(height: 16),

        // This part is visible in your screenshots (Incident2.x)
        _RadioInline(
          label: "Was 000 contacted?",
          value: contacted000,
          onChanged: (v) => setState(() => contacted000 = v),
        ),
        _TextArea(
          label: "Response",
          hint: "Response",
          controller: responseCtrl,
        ),

        const SizedBox(height: 16),
        const _DividerLine(),
        const SizedBox(height: 16),

        const _H1("Persons Involved in the Incident"),
        const SizedBox(height: 6),
        _NameContactHeader(),
        const SizedBox(height: 8),
        ..._buildRepeatableList(
          persons,
          onAdd: () => setState(() => persons.add(_PersonRowCtrls())),
        ),

        const SizedBox(height: 18),
        const _H1("Witnesses to the Incident"),
        const SizedBox(height: 6),
        _NameContactHeader(),
        const SizedBox(height: 8),
        ..._buildRepeatableList(
          witnesses,
          onAdd: () => setState(() => witnesses.add(_PersonRowCtrls())),
        ),

        const SizedBox(height: 18),
        const _H1("Treatment"),
        const SizedBox(height: 6),
        _TextArea(
          label: "First Aid provided",
          hint: "First Aid provided",
          controller: firstAidCtrl,
        ),

        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, c) {
            final stack = c.maxWidth < 820;
            final items = [
              _RadioBlock(
                label: "Ambulance Required",
                value: ambulance,
                onChanged: (v) => setState(() => ambulance = v),
              ),
              _RadioBlock(
                label: "Hospitalisation Required",
                value: hospital,
                onChanged: (v) => setState(() => hospital = v),
              ),
              _RadioBlock(
                label: "GP Contacted?",
                value: gp,
                onChanged: (v) => setState(() => gp = v),
              ),
            ];

            if (stack) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  items[0],
                  const SizedBox(height: 10),
                  items[1],
                  const SizedBox(height: 10),
                  items[2],
                ],
              );
            }

            return Row(
              children: [
                Expanded(child: items[0]),
                const SizedBox(width: 18),
                Expanded(child: items[1]),
                const SizedBox(width: 18),
                Expanded(child: items[2]),
              ],
            );
          },
        ),
      ],
    );
  }

  List<Widget> _buildRepeatableList(
    List<_PersonRowCtrls> list, {
    required VoidCallback onAdd,
  }) {
    final w = MediaQuery.of(context).size.width;
    final tight = w < 520;

    return [
      for (int i = 0; i < list.length; i++)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: LayoutBuilder(
            builder: (context, c) {
              final stack = tight || c.maxWidth < 650;
              final row = list[i];

              final nameField = _InputOnly(hint: "Name", controller: row.name);
              final contactField = _InputOnly(
                hint: "Contact",
                controller: row.contact,
              );

              final deleteBtn = IconButton(
                tooltip: "Delete",
                icon: const Icon(Icons.delete_outline, size: 18),
                onPressed: list.length <= 1
                    ? null
                    : () {
                        setState(() {
                          row.dispose();
                          list.removeAt(i);
                        });
                      },
              );

              if (stack) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    nameField,
                    const SizedBox(height: 10),
                    contactField,
                    Align(alignment: Alignment.centerRight, child: deleteBtn),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: nameField),
                  const SizedBox(width: 12),
                  Expanded(child: contactField),
                  const SizedBox(width: 6),
                  deleteBtn,
                ],
              );
            },
          ),
        ),
      Align(
        alignment: Alignment.centerLeft,
        child: ElevatedButton(
          onPressed: onAdd,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E88E5),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: const Text("Add new"),
        ),
      ),
    ];
  }
}

/* --------------------------------- STEP 3 --------------------------------- */

class _StepThree extends StatefulWidget {
  const _StepThree();

  @override
  State<_StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<_StepThree> {
  final actionRespondCtrl = TextEditingController();
  final actionReduceCtrl = TextEditingController();
  final actionSupportCtrl = TextEditingController();

  bool prevented = false;

  final managedCtrl = TextEditingController();
  final correctiveCtrl = TextEditingController();

  bool ndis = false;
  bool fiveDay = false;
  bool finalReport = false;

  final ndisDateCtrl = TextEditingController();
  final fiveDayDateCtrl = TextEditingController();
  final finalDateCtrl = TextEditingController();

  @override
  void dispose() {
    actionRespondCtrl.dispose();
    actionReduceCtrl.dispose();
    actionSupportCtrl.dispose();
    managedCtrl.dispose();
    correctiveCtrl.dispose();
    ndisDateCtrl.dispose();
    fiveDayDateCtrl.dispose();
    finalDateCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate(TextEditingController ctrl) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      ctrl.text =
          "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _H1("Incident Management"),
        const SizedBox(height: 8),
        _TextArea(
          label: "Actions taken to respond to incident:",
          hint: "Actions taken to respond to incident",
          controller: actionRespondCtrl,
        ),
        _TextArea(
          label: "Actions taken to reduce immediate risks:",
          hint: "Actions taken to reduce immediate risks",
          controller: actionReduceCtrl,
        ),
        _TextArea(
          label: "Actions taken to support affected persons:",
          hint: "Actions taken to support affected persons",
          controller: actionSupportCtrl,
        ),

        const SizedBox(height: 16),
        const _DividerLine(),
        const SizedBox(height: 16),

        const _H1("Incident Resolution"),
        const SizedBox(height: 8),

        _RadioInline(
          label: "Could the incident have been prevented?",
          value: prevented,
          onChanged: (v) => setState(() => prevented = v),
        ),

        _TextArea(
          label: "How well was the incident managed and resolved?",
          hint: "How well was the incident managed and resolved?",
          controller: managedCtrl,
        ),

        _TextArea(
          label: "Corrective Actions taken to prevent future incidents:",
          hint: "Corrective Actions taken to prevent future incidents",
          controller: correctiveCtrl,
        ),

        const SizedBox(height: 16),
        const _DividerLine(),
        const SizedBox(height: 16),

        const _H1("Reporting"),
        const SizedBox(height: 8),

        _TwoCol(
          left: _RadioInline(
            label: "NDIS Commission notified?",
            value: ndis,
            onChanged: (v) => setState(() => ndis = v),
          ),
          right: _Field(
            label: "Date",
            hint: "Date",
            controller: ndisDateCtrl,
            suffix: _SuffixIcons(
              icons: const [Icons.calendar_today_outlined, Icons.close],
              onTap: [
                () => _pickDate(ndisDateCtrl),
                () => setState(() => ndisDateCtrl.clear()),
              ],
            ),
          ),
        ),

        _TwoCol(
          left: _RadioInline(
            label: "5-Day Form submitted?",
            value: fiveDay,
            onChanged: (v) => setState(() => fiveDay = v),
          ),
          right: _Field(
            label: "Date",
            hint: "Date",
            controller: fiveDayDateCtrl,
            suffix: _SuffixIcons(
              icons: const [Icons.calendar_today_outlined, Icons.close],
              onTap: [
                () => _pickDate(fiveDayDateCtrl),
                () => setState(() => fiveDayDateCtrl.clear()),
              ],
            ),
          ),
        ),

        _TwoCol(
          left: _RadioInline(
            label: "Final Report submitted?",
            value: finalReport,
            onChanged: (v) => setState(() => finalReport = v),
          ),
          right: _Field(
            label: "Date",
            hint: "Date",
            controller: finalDateCtrl,
            suffix: _SuffixIcons(
              icons: const [Icons.calendar_today_outlined, Icons.close],
              onTap: [
                () => _pickDate(finalDateCtrl),
                () => setState(() => finalDateCtrl.clear()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/* --------------------------------- UI PARTS -------------------------------- */

class _H1 extends StatelessWidget {
  final String text;
  const _H1(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: const Color(0xFFE5EAF1));
  }
}

class _TwoCol extends StatelessWidget {
  final Widget left;
  final Widget right;

  const _TwoCol({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    final isStack = MediaQuery.of(context).size.width < 720;

    if (isStack) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [left, const SizedBox(height: 12), right],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Expanded(child: left),
          const SizedBox(width: 14),
          Expanded(child: right),
        ],
      ),
    );
  }
}

class _SuffixIcons extends StatelessWidget {
  final List<IconData> icons;
  final List<VoidCallback> onTap;

  const _SuffixIcons({required this.icons, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < icons.length; i++)
          InkWell(
            onTap: onTap[i],
            child: Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 6),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD6DEE8)),
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xFFF6F8FB),
              ),
              child: Icon(icons[i], size: 18, color: const Color(0xFF4E5A6A)),
            ),
          ),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final Widget? suffix;

  const _Field({
    required this.label,
    required this.hint,
    required this.controller,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF98A2B3)),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFFD6DEE8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFF00A991)),
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              suffixIcon: suffix == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: suffix,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputOnly extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const _InputOnly({required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF98A2B3)),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFFD6DEE8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFF00A991)),
        ),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: value,
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFFD6DEE8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFF00A991)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextArea extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const _TextArea({
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF98A2B3)),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFFD6DEE8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFF00A991)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RadioInline extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _RadioInline({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tight = MediaQuery.of(context).size.width < 520;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 12,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _RadioChip(
                text: "Yes",
                v: true,
                groupValue: value,
                onChanged: onChanged,
                compact: tight,
              ),
              _RadioChip(
                text: "No",
                v: false,
                groupValue: value,
                onChanged: onChanged,
                compact: tight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RadioBlock extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _RadioBlock({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tight = MediaQuery.of(context).size.width < 520;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 12,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _RadioChip(
              text: "Yes",
              v: true,
              groupValue: value,
              onChanged: onChanged,
              compact: tight,
            ),
            _RadioChip(
              text: "No",
              v: false,
              groupValue: value,
              onChanged: onChanged,
              compact: tight,
            ),
          ],
        ),
      ],
    );
  }
}

class _RadioChip extends StatelessWidget {
  final String text;
  final bool v;
  final bool groupValue;
  final ValueChanged<bool> onChanged;
  final bool compact;

  const _RadioChip({
    required this.text,
    required this.v,
    required this.groupValue,
    required this.onChanged,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () => onChanged(v),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<bool>(
            value: v,
            groupValue: groupValue,
            onChanged: (_) => onChanged(v),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          Padding(
            padding: EdgeInsets.only(right: compact ? 4 : 8),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _NameContactHeader extends StatelessWidget {
  const _NameContactHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Text("Name", style: TextStyle(fontWeight: FontWeight.w800)),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text("Contact", style: TextStyle(fontWeight: FontWeight.w800)),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 52,
          child: Text("Delete", style: TextStyle(fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }
}
