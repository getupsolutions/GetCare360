import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';
import 'package:getcare360/features/Admin/Agency/presentation/bloc/organization/add_org_bloc.dart';
import 'package:getcare360/features/Admin/Agency/presentation/bloc/organization/add_org_event.dart';
import 'package:getcare360/features/Admin/Agency/presentation/bloc/organization/add_org_state.dart';

class AddOrganizationPage extends StatelessWidget {
  const AddOrganizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddOrgBloc()..add(AddOrgInit()),
      child: const _AddOrganizationView(),
    );
  }
}

class _AddOrganizationView extends StatelessWidget {
  const _AddOrganizationView();

  static const _pageBg = Color(0xFFF3F4F8);
  static const _accent = Color(0xFFB012A5);

  static const services = [
    "Agency Staff - PCA",
    "Business Development Manager",
    "Disability Support Worker",
    "Medicator (Cert IV)",
    "Plan Manager",
    "Support Coordinator",
    "Assistant in Nursing",
    "Chef/Cook",
    "Enrolled Nurse",
    "Office Administration Manager",
    "Registered Nurse Agency",
    "Support Coordinator/Business Development Manager",
    "Book Keeper",
    "Cleaner",
    "Kitchen hand",
    "Physiotherapy",
    "Registered Nurses - NDIS",
    "Triniti Admin",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add New Organization', centerTitle: true),
      backgroundColor: _pageBg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, c) {
            final w = c.maxWidth;
            final isMobile = w < 600;
            final isTablet = w >= 600 && w < 1024;

            final contentWidth = isMobile ? w : (isTablet ? 860.0 : 980.0);

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentWidth),
                  child: _Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Upload boxes
                          Wrap(
                            spacing: 18,
                            runSpacing: 18,
                            alignment: WrapAlignment.spaceBetween,
                            children: const [
                              _UploadBox(
                                hint: "Upload Photo",
                                icon: Icons.person,
                                accent: _accent,
                              ),
                              _UploadBox(
                                hint: "Upload Logo",
                                icon: Icons.image,
                                accent: _accent,
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),

                          _Grid2(
                            isMobile: isMobile,
                            left: const _Field(
                              label: "Name of Organization",
                              fieldKey: "orgName",
                            ),
                            right: const _Field(
                              label: "Contact Name",
                              fieldKey: "contactName",
                            ),
                          ),
                          const SizedBox(height: 14),

                          _Grid2(
                            isMobile: isMobile,
                            left: const _Field(
                              label: "Contact Phone",
                              fieldKey: "contactPhone",
                              keyboardType: TextInputType.phone,
                            ),
                            right: const _DropdownField(
                              label: "Location Group",
                              hint: "Select Location Group",
                              fieldKey: "locationGroup",
                              items: ["Group A", "Group B", "Group C"],
                            ),
                          ),
                          const SizedBox(height: 14),

                          const _Field(
                            label: "Start typing address:",
                            hint: "Enter address",
                            fieldKey: "addressSearch",
                          ),
                          const SizedBox(height: 14),

                          const _Field(
                            label: "Street",
                            fieldKey: "street",
                            maxLines: 3,
                          ),
                          const SizedBox(height: 14),

                          _Grid3(
                            isMobile: isMobile,
                            left: const _Field(
                              label: "Suburb",
                              fieldKey: "suburb",
                            ),
                            middle: const _DropdownField(
                              label: "State",
                              hint: "Select State",
                              fieldKey: "state",
                              items: [
                                "NSW",
                                "VIC",
                                "QLD",
                                "SA",
                                "WA",
                                "ACT",
                                "TAS",
                                "NT",
                              ],
                            ),
                            right: const _Field(
                              label: "Post code",
                              fieldKey: "postcode",
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(height: 14),

                          _Grid3(
                            isMobile: isMobile,
                            left: const _Field(
                              label: "ABN Number",
                              fieldKey: "abn",
                            ),
                            middle: const _DateField(
                              label: "Start Date",
                              dateKey: "startDate",
                            ),
                            right: const _DateField(
                              label: "End Date",
                              dateKey: "endDate",
                            ),
                          ),
                          const SizedBox(height: 18),

                          const Text(
                            "Timings",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          const _TimingsTable(),
                          const SizedBox(height: 18),

                          const Text(
                            "Services",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          _ServicesGrid(
                            services: services,
                            columns: isMobile ? 1 : (isTablet ? 2 : 3),
                          ),
                          const SizedBox(height: 18),

                          const _DropdownField(
                            label: "Groups",
                            hint: "Select Groups",
                            fieldKey: "groups",
                            items: ["Group 1", "Group 2", "Group 3"],
                          ),
                          const SizedBox(height: 18),

                          const Text(
                            "Emails",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          const _EmailsTable(accent: _accent),
                          const SizedBox(height: 18),

                          _Grid2(
                            isMobile: isMobile,
                            left: const _StatusDropdown(),
                            right: const _Field(
                              label: "Username",
                              fieldKey: "username",
                            ),
                          ),
                          const SizedBox(height: 14),

                          _Grid2(
                            isMobile: isMobile,
                            left: const _Field(
                              label: "Password",
                              hint: "Password",
                              fieldKey: "password",
                              obscureText: true,
                            ),
                            right: const _Field(
                              label: "Verify Password",
                              hint: "Confirm Password",
                              fieldKey: "confirmPassword",
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(height: 10),

                          Align(
                            alignment: Alignment.center,
                            child: _SmallButton(
                              text: "Generate",
                              color: _accent,
                              onTap: () => context.read<AddOrgBloc>().add(
                                AddOrgGeneratePassword(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),

                          BlocBuilder<AddOrgBloc, AddOrgState>(
                            buildWhen: (p, n) =>
                                p.submitting != n.submitting ||
                                p.message != n.message,
                            builder: (context, state) {
                              return Column(
                                children: [
                                  SizedBox(
                                    width: 110,
                                    height: 42,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _accent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                      ),
                                      onPressed: state.submitting
                                          ? null
                                          : () => context
                                                .read<AddOrgBloc>()
                                                .add(AddOrgSubmit()),
                                      child: state.submitting
                                          ? const SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text(
                                              "Save",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                  ),
                                  if (state.message != null) ...[
                                    const SizedBox(height: 10),
                                    Text(
                                      state.message!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// =====================
/// Widgets
/// =====================

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }
}

class _UploadBox extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Color accent;

  const _UploadBox({
    required this.hint,
    required this.icon,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width < 600 ? 120.0 : 130.0;

    return SizedBox(
      width: size,
      child: Column(
        children: [
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              border: Border.all(color: accent, width: 2),
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xFFF2F2F2),
            ),
            child: Icon(icon, size: 54, color: Colors.black26),
          ),
          const SizedBox(height: 6),
          Text(
            hint,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _Grid2 extends StatelessWidget {
  final bool isMobile;
  final Widget left;
  final Widget right;
  const _Grid2({
    required this.isMobile,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile)
      return Column(children: [left, const SizedBox(height: 14), right]);
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 16),
        Expanded(child: right),
      ],
    );
  }
}

class _Grid3 extends StatelessWidget {
  final bool isMobile;
  final Widget left;
  final Widget middle;
  final Widget right;
  const _Grid3({
    required this.isMobile,
    required this.left,
    required this.middle,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        children: [
          left,
          const SizedBox(height: 14),
          middle,
          const SizedBox(height: 14),
          right,
        ],
      );
    }
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 16),
        Expanded(child: middle),
        const SizedBox(width: 16),
        Expanded(child: right),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String hint;
  final String fieldKey;
  final int maxLines;
  final bool obscureText;
  final TextInputType? keyboardType;

  const _Field({
    required this.label,
    required this.fieldKey,
    this.hint = "",
    this.maxLines = 1,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOrgBloc, AddOrgState>(
      buildWhen: (p, n) => p.fields[fieldKey] != n.fields[fieldKey],
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            TextFormField(
              initialValue: state.fields[fieldKey] ?? "",
              onChanged: (v) => context.read<AddOrgBloc>().add(
                AddOrgFieldChanged(fieldKey, v),
              ),
              maxLines: maxLines,
              obscureText: obscureText,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hint.isEmpty ? null : hint,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String hint;
  final String fieldKey;
  final List<String> items;

  const _DropdownField({
    required this.label,
    required this.hint,
    required this.fieldKey,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOrgBloc, AddOrgState>(
      buildWhen: (p, n) => p.fields[fieldKey] != n.fields[fieldKey],
      builder: (context, state) {
        final raw = state.fields[fieldKey] ?? "";
        final value = raw.isEmpty ? null : raw;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: value,
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => context.read<AddOrgBloc>().add(
                AddOrgFieldChanged(fieldKey, v ?? ""),
              ),
              decoration: InputDecoration(
                hintText: hint,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final String dateKey;
  const _DateField({required this.label, required this.dateKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOrgBloc, AddOrgState>(
      buildWhen: (p, n) => p.startDate != n.startDate || p.endDate != n.endDate,
      builder: (context, state) {
        final date = dateKey == "startDate" ? state.startDate : state.endDate;
        final text = date == null
            ? ""
            : "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  initialDate: date ?? DateTime.now(),
                );
                if (picked != null) {
                  context.read<AddOrgBloc>().add(
                    AddOrgPickDate(dateKey, picked),
                  );
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  text.isEmpty ? label : text,
                  style: TextStyle(
                    color: text.isEmpty ? Colors.black38 : Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ServicesGrid extends StatelessWidget {
  final List<String> services;
  final int columns;
  const _ServicesGrid({required this.services, required this.columns});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOrgBloc, AddOrgState>(
      buildWhen: (p, n) => p.selectedServices != n.selectedServices,
      builder: (context, state) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 6,
            crossAxisSpacing: 16,
            childAspectRatio: 7.0,
          ),
          itemBuilder: (context, index) {
            final s = services[index];
            final checked = state.selectedServices.contains(s);
            return CheckboxListTile(
              dense: true,
              value: checked,
              onChanged: (_) =>
                  context.read<AddOrgBloc>().add(AddOrgToggleService(s)),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text(s, style: const TextStyle(fontSize: 13)),
            );
          },
        );
      },
    );
  }
}

/// ✅ RESPONSIVE EMAILS (Desktop table + Mobile cards)
/// ✅ RESPONSIVE EMAILS (Desktop table + Mobile cards) - SAFE (no RangeError)
class _EmailsTable extends StatefulWidget {
  final Color accent;
  const _EmailsTable({required this.accent});

  @override
  State<_EmailsTable> createState() => _EmailsTableState();
}

class _EmailsTableState extends State<_EmailsTable> {
  final Map<int, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    _controllers.clear();
    super.dispose();
  }

  TextEditingController _controllerFor(int index, String value) {
    final existing = _controllers[index];
    if (existing == null) {
      final c = TextEditingController(text: value);
      _controllers[index] = c;
      return c;
    }

    // keep controller synced (important after add/remove)
    if (existing.text != value) {
      existing.value = existing.value.copyWith(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
        composing: TextRange.empty,
      );
    }
    return existing;
  }

  void _cleanupControllers(int length) {
    final keys = _controllers.keys.toList();
    for (final k in keys) {
      if (k >= length) {
        _controllers[k]?.dispose();
        _controllers.remove(k);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, c) {
        final isMobile = c.maxWidth < 650;

        return BlocBuilder<AddOrgBloc, AddOrgState>(
          buildWhen: (p, n) => p.emails != n.emails,
          builder: (context, state) {
            _cleanupControllers(state.emails.length);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE6E8EF)),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Color(0xFFE6E8EF)),
                          ),
                        ),
                        child: isMobile
                            ? const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Email Notifications",
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                              )
                            : const Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Notification",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60,
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),

                      // Rows
                      for (int i = 0; i < state.emails.length; i++) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          child: isMobile
                              ? _EmailRowMobile(
                                  index: i,
                                  row: state.emails[i],
                                  controller: _controllerFor(
                                    i,
                                    state.emails[i].email,
                                  ),
                                )
                              : SizedBox(),
                        ),
                        if (i != state.emails.length - 1)
                          const Divider(height: 1),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                _SmallButton(
                  text: "Add new +",
                  color: widget.accent,
                  onTap: () =>
                      context.read<AddOrgBloc>().add(AddOrgAddEmailRow()),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// class _EmailRowDesktop extends StatelessWidget {
//   final int index;
//   final dynamic row; // <-- your EmailRow type from state.emails
//   final TextEditingController controller;

//   const _EmailRowDesktop({
//     required this.index,
//     required this.row,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // NOTE: No BlocBuilder here -> avoids index out-of-range during list mutation
//     return Row(
//       children: [
//         Expanded(
//           flex: 7,
//           child: TextField(
//             controller: controller,
//             onChanged: (v) =>
//                 context.read<AddOrgBloc>().add(AddOrgEmailChanged(index, v)),
//             decoration: InputDecoration(
//               isDense: true,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(6),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           flex: 2,
//           child: Row(
//             children: [
//               Checkbox(
//                 value: row.enabled as bool,
//                 onChanged: (v) => context.read<AddOrgBloc>().add(
//                   AddOrgEmailEnabledChanged(index, v ?? false),
//                 ),
//               ),
//               const Text("Enabled"),
//             ],
//           ),
//         ),
//         SizedBox(
//           width: 60,
//           child: IconButton(
//             onPressed: () =>
//                 context.read<AddOrgBloc>().add(AddOrgRemoveEmailRow(index)),
//             icon: const Icon(Icons.delete_outline, color: Colors.black54),
//           ),
//         ),
//       ],
//     );
//   }
// }

class _EmailRowMobile extends StatelessWidget {
  final int index;
  final dynamic row; // <-- your EmailRow type from state.emails
  final TextEditingController controller;

  const _EmailRowMobile({
    required this.index,
    required this.row,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // NOTE: No BlocBuilder here -> avoids index out-of-range during list mutation
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE6E8EF)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Email ${index + 1}",
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            onChanged: (v) =>
                context.read<AddOrgBloc>().add(AddOrgEmailChanged(index, v)),
            decoration: InputDecoration(
              hintText: "Email",
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: row.enabled as bool,
                onChanged: (v) => context.read<AddOrgBloc>().add(
                  AddOrgEmailEnabledChanged(index, v ?? false),
                ),
              ),
              const Text("Enabled"),
              const Spacer(),
              IconButton(
                onPressed: () =>
                    context.read<AddOrgBloc>().add(AddOrgRemoveEmailRow(index)),
                icon: const Icon(Icons.delete_outline, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusDropdown extends StatelessWidget {
  const _StatusDropdown();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOrgBloc, AddOrgState>(
      buildWhen: (p, n) => p.status != n.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Status",
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: state.status,
              items: const [
                "Active",
                "Inactive",
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => context.read<AddOrgBloc>().add(
                AddOrgStatusChanged(v ?? "Active"),
              ),
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SmallButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  const _SmallButton({
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}

/// Keep your timings widget implementation here.
/// (Must NOT return SizedBox.shrink in your real UI)
class _TimingsTable extends StatelessWidget {
  const _TimingsTable();

  @override
  Widget build(BuildContext context) {
    // TODO: paste your timings UI here (the one you already built)
    return const SizedBox(height: 1);
  }
}
