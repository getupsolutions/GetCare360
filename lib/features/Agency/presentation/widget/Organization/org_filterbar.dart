import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getcare360/core/widget/responsive.dart';
import 'package:getcare360/features/Agency/presentation/bloc/organization/org_bloc.dart';
import 'package:getcare360/features/Agency/presentation/bloc/organization/org_event.dart';
import 'package:getcare360/features/Agency/presentation/bloc/organization/org_state.dart';


class OrgFilterBar extends StatelessWidget {
  const OrgFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrgBloc, OrgState>(
      buildWhen: (p, n) =>
          p.query != n.query || p.status != n.status || p.sort != n.sort,
      builder: (context, state) {
        final isMobile = Responsive.isMobile(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Organization",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: isMobile ? double.infinity : 260,
                  child: _SearchField(
                    value: state.query,
                    onChanged: (v) =>
                        context.read<OrgBloc>().add(OrgSearchChanged(v)),
                  ),
                ),

                SizedBox(
                  width: isMobile ? double.infinity : 220,
                  child: _Dropdown(
                    value: state.status,
                    hint: "Account Status",
                    items: const ["All", "Active", "Inactive", "Pending"],
                    onChanged: (v) =>
                        context.read<OrgBloc>().add(OrgStatusChanged(v)),
                  ),
                ),

                SizedBox(
                  width: isMobile ? double.infinity : 200,
                  child: _Dropdown(
                    value: state.sort,
                    hint: "Name A-Z",
                    items: const ["Name A-Z", "Name Z-A", "Newest", "Oldest"],
                    onChanged: (v) =>
                        context.read<OrgBloc>().add(OrgSortChanged(v)),
                  ),
                ),

                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {
                      // "Find" button: you can trigger API call here.
                      // Right now filtering is live, so no-op.
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text(
                      "Find",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF14B8A6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () =>
                        context.read<OrgBloc>().add(OrgClearFilters()),
                    child: const Text(
                      "Clear All",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const _SearchField({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Search...",
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String value;
  final String hint;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const _Dropdown({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items
          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
          .toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }
}
