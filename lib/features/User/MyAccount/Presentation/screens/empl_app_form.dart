import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getcare360/core/widget/apptopbar.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';
import 'package:getcare360/core/widget/user_side_drawer.dart'; // <-- your SideDrawer
import 'package:getcare360/features/User/Dashboard/Presentation/Widgets/navigation_file.dart';
import 'package:getcare360/features/User/Dashboard/Presentation/screens/dashboard_page.dart'
    hide AppTopBar;
import 'package:getcare360/features/User/MyAccount/Presentation/Cubit/empl_for_cubit.dart';

class EmployeeApplicationFormPage extends StatefulWidget {
  const EmployeeApplicationFormPage({super.key});

  @override
  State<EmployeeApplicationFormPage> createState() =>
      _EmployeeApplicationFormPageState();
}

class _EmployeeApplicationFormPageState
    extends State<EmployeeApplicationFormPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static const _drawerWidth = 270.0;

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static const _steps = <_StepDef>[
    _StepDef(index: 0, title: 'Personal Details'),
    _StepDef(index: 1, title: 'Qualification & Employment History'),
    _StepDef(index: 2, title: 'Skills and Knowledge'),
    _StepDef(index: 3, title: 'Referees'),
    _StepDef(index: 4, title: 'Banking Details'),
  ];

  @override
  Widget build(BuildContext context) {
    final desktop = isDesktop(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Employee Application Form',
        centerTitle: true,
      ),
      key: _scaffoldKey,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                          children: [
                            _HeaderBar(
                              title: "Employee Application Form",
                              breadcrumbRight:
                                  "Dashboard  >  Application Step:1",
                            ),
                            const SizedBox(height: 14),
                            _FormShell(steps: _steps),
                            const SizedBox(height: 18),
                          ],
                        ),
                      ),
                    ),
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

class _HeaderBar extends StatelessWidget {
  final String title;
  final String breadcrumbRight;

  const _HeaderBar({required this.title, required this.breadcrumbRight});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final small = c.maxWidth < 520;

        final titleWidget = Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        );

        final breadcrumb = Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.home_outlined, size: 16, color: Colors.grey.shade700),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  breadcrumbRight,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
        );

        if (small) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget,
              const SizedBox(height: 10),
              Align(alignment: Alignment.centerLeft, child: breadcrumb),
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: titleWidget),
            const SizedBox(width: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: breadcrumb,
            ),
          ],
        );
      },
    );
  }
}

class _FormShell extends StatelessWidget {
  final List<_StepDef> steps;

  const _FormShell({required this.steps});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final wide = c.maxWidth >= 980;

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 360, child: _StepRail(steps: steps)),
                      const SizedBox(width: 12),
                      const Expanded(child: _StepBodyCard()),
                    ],
                  )
                : Column(
                    children: [
                      _StepChipsBar(steps: steps),
                      const SizedBox(height: 12),
                      const _StepBodyCard(),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

/// Desktop left panel: big step buttons like screenshot
class _StepRail extends StatelessWidget {
  final List<_StepDef> steps;

  const _StepRail({required this.steps});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeFormCubit, EmployeeFormState>(
      builder: (context, state) {
        return Column(
          children: steps.map((s) {
            final active = state.step == s.index;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () => context.read<EmployeeFormCubit>().goTo(s.index),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: active
                        ? const Color(0xFF0E9F6E)
                        : const Color(0xFF64C7BE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "${s.index + 1}. ${s.title}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

/// Mobile / tablet: horizontal steps
class _StepChipsBar extends StatelessWidget {
  final List<_StepDef> steps;

  const _StepChipsBar({required this.steps});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeFormCubit, EmployeeFormState>(
      builder: (context, state) {
        return SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: steps.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final s = steps[i];
              final active = state.step == s.index;
              return InkWell(
                onTap: () => context.read<EmployeeFormCubit>().goTo(s.index),
                borderRadius: BorderRadius.circular(22),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: active
                        ? const Color(0xFF0E9F6E)
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Text(
                    "${s.index + 1}. ${s.title}",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: active ? Colors.white : Colors.grey.shade800,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _StepBodyCard extends StatelessWidget {
  const _StepBodyCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeFormCubit, EmployeeFormState>(
      builder: (context, state) {
        final step = state.step;

        return Container(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _StepTitle(step: step),
              const SizedBox(height: 12),
              _StepContent(step: step),
              const SizedBox(height: 16),
              _BottomActions(step: step),
            ],
          ),
        );
      },
    );
  }
}

class _StepTitle extends StatelessWidget {
  final int step;
  const _StepTitle({required this.step});

  @override
  Widget build(BuildContext context) {
    String title;
    switch (step) {
      case 0:
        title = "Personal Details";
        break;
      case 1:
        title = "Qualifications and Certificates";
        break;
      case 2:
        title = "Skills and Knowledge";
        break;
      case 3:
        title = "Referees";
        break;
      default:
        title = "Banking Details";
    }

    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
    );
  }
}

class _StepContent extends StatelessWidget {
  final int step;
  const _StepContent({required this.step});

  @override
  Widget build(BuildContext context) {
    switch (step) {
      case 0:
        return const _PersonalDetailsForm();
      case 1:
        return const _QualificationEmploymentForm();
      case 2:
        return const _SkillsKnowledgeForm();
      case 3:
        return const _RefereesForm();
      default:
        return const _BankingDetailsForm();
    }
  }
}

class _BottomActions extends StatelessWidget {
  final int step;
  const _BottomActions({required this.step});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmployeeFormCubit>();

    return Row(
      children: [
        const Spacer(),
        SizedBox(
          height: 40,
          child: OutlinedButton(
            onPressed: step == 0 ? null : cubit.previous,
            child: const Text("Previous"),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0E9F6E),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: step == EmployeeFormCubit.maxStep ? () {} : cubit.next,
            child: Text(
              step == EmployeeFormCubit.maxStep ? "Finish" : "Save & Continue",
            ),
          ),
        ),
      ],
    );
  }
}

/* -------------------------
   STEP FORMS (RESPONSIVE)
-------------------------- */

class _PersonalDetailsForm extends StatelessWidget {
  const _PersonalDetailsForm();

  @override
  Widget build(BuildContext context) {
    return _GridForm(
      children: const [
        _Field(label: "Mobile", hint: "Enter mobile"),
        _DropdownField(
          label: "Type of employment",
          items: ["Casual", "Part time", "Full time"],
        ),
        _RadioYesNo(label: "Do you drive?"),
        _Field(label: "WWCC (NDIS applicants)", hint: "Enter WWCC"),
        _DateField(label: "WWCC Expiry date"),
        _Field(label: "NDIS Worker Screening ID", hint: "Enter screening id"),
        _DateField(label: "NDIS Expiry date"),
        _Field(label: "Start typing address", hint: "Enter address"),
        _Field(label: "Street Name", hint: "Street"),
        _Field(label: "Suburb", hint: "Suburb"),
        _Field(label: "Postcode", hint: "Postcode"),
        _RadioYesNo(label: "Australian resident for tax purposes?"),
      ],
    );
  }
}

class _QualificationEmploymentForm extends StatelessWidget {
  const _QualificationEmploymentForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Qualifications and Certificates",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10),
        _GridForm(
          children: const [
            _Field(label: "Qualification", hint: "e.g. Certificate III"),
            _Field(label: "Institution", hint: "Institution"),
            _DateField(label: "Date Completed"),
          ],
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 34,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Add new"),
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          "Previous Employment/Experience",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10),
        _GridForm(
          children: const [
            _Field(label: "Company", hint: "Company"),
            _DateField(label: "From"),
            _DateField(label: "To"),
            _Field(label: "Job Title", hint: "Job title"),
            _TextArea(
              label: "Responsibilities",
              hint: "Write responsibilities",
            ),
          ],
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 34,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Add new"),
            ),
          ),
        ),
      ],
    );
  }
}

class _SkillsKnowledgeForm extends StatelessWidget {
  const _SkillsKnowledgeForm();

  @override
  Widget build(BuildContext context) {
    return const _GridForm(
      children: [
        _TextArea(
          label: "Supporting people with a disability",
          hint: "Describe experience",
        ),
        _TextArea(
          label: "Other skills/knowledge possessed",
          hint: "Write here",
        ),
        _TextArea(label: "Languages Spoken", hint: "Write languages"),
      ],
    );
  }
}

class _RefereesForm extends StatelessWidget {
  const _RefereesForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Please list two professional references (e.g. Former employer, placement organisation)",
        ),
        const SizedBox(height: 8),
        Text(
          "*Note: Only professional references will be considered. Friends and family members are not eligible.",
          style: TextStyle(
            color: Colors.red.shade600,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        const _GridForm(
          children: [
            _Field(label: "Name", hint: "Reference name"),
            _Field(label: "Phone", hint: "+61..."),
            _Field(label: "Company", hint: "Company"),
            _Field(label: "Relation", hint: "Relation"),
            _Field(label: "Email", hint: "Email"),
          ],
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 34,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Add new"),
            ),
          ),
        ),
      ],
    );
  }
}

class _BankingDetailsForm extends StatelessWidget {
  const _BankingDetailsForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Banking Details",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10),
        const _GridForm(
          children: [
            _Field(label: "Bank Account Name", hint: "Name"),
            _Field(label: "BSB", hint: "BSB"),
            _Field(label: "Account Number", hint: "Account number"),
            _Field(label: "Bank", hint: "Bank name"),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          "Tax Details",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10),
        const _GridForm(
          children: [
            _Field(label: "Employee Tax File Number", hint: "TFN"),
            _DateField(label: "TFN Declaration Date"),
            _RadioYesNo(label: "Claim the tax-free threshold"),
            _RadioYesNo(label: "Australian resident for tax purposes"),
            _RadioYesNo(label: "Higher Education Loan Debt (HELP)"),
            _RadioYesNo(label: "Financial Supplement debt"),
            _TextArea(
              label: "Additional Information",
              hint: "Write additional info",
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          "Superannuation",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10),
        const _GridForm(
          children: [
            _Field(label: "Name of Fund", hint: "Fund name"),
            _Field(label: "Name of Account", hint: "Account name"),
            _Field(label: "Membership Number", hint: "Membership number"),
            _Field(label: "Fund ABN", hint: "ABN"),
          ],
        ),
      ],
    );
  }
}

/* -------------------------
   SMALL UI HELPERS
-------------------------- */

class _GridForm extends StatelessWidget {
  final List<Widget> children;
  const _GridForm({required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        int cols = 1;
        if (c.maxWidth >= 1100)
          cols = 3;
        else if (c.maxWidth >= 760)
          cols = 2;

        final spacing = 12.0;
        final itemW = (c.maxWidth - spacing * (cols - 1)) / cols;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: children
              .map((w) => SizedBox(width: itemW, child: w))
              .toList(),
        );
      },
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String hint;
  const _Field({required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    return _Labeled(
      label: label,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }
}

class _TextArea extends StatelessWidget {
  final String label;
  final String hint;
  const _TextArea({required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    return _Labeled(
      label: label,
      child: TextFormField(
        maxLines: 4,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  const _DateField({required this.label});

  @override
  Widget build(BuildContext context) {
    return _Labeled(
      label: label,
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          hintText: "Select date",
          border: const OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_month, color: Colors.grey.shade700),
          isDense: true,
        ),
        onTap: () async {
          final now = DateTime.now();
          final picked = await showDatePicker(
            context: context,
            firstDate: DateTime(now.year - 10),
            lastDate: DateTime(now.year + 10),
            initialDate: now,
          );
          // bind to controller in real app
          if (picked == null) return;
        },
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final List<String> items;

  const _DropdownField({required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    return _Labeled(
      label: label,
      child: DropdownButtonFormField<String>(
        value: items.first,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (_) {},
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }
}

class _RadioYesNo extends StatefulWidget {
  final String label;
  const _RadioYesNo({required this.label});

  @override
  State<_RadioYesNo> createState() => _RadioYesNoState();
}

class _RadioYesNoState extends State<_RadioYesNo> {
  bool? val;

  @override
  Widget build(BuildContext context) {
    return _Labeled(
      label: widget.label,
      child: Row(
        children: [
          _radio("Yes", true),
          const SizedBox(width: 14),
          _radio("No", false),
        ],
      ),
    );
  }

  Widget _radio(String text, bool v) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<bool>(
          value: v,
          groupValue: val,
          onChanged: (x) => setState(() => val = x),
        ),
        Text(text),
      ],
    );
  }
}

class _Labeled extends StatelessWidget {
  final String label;
  final Widget child;

  const _Labeled({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _StepDef {
  final int index;
  final String title;
  const _StepDef({required this.index, required this.title});
}
