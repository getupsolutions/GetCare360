import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getcare360/core/constant/app_color.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';
import 'package:getcare360/core/widget/user_side_drawer.dart';
import 'package:getcare360/features/User/Dashboard/Data/Model/drawer_model.dart';
import 'package:getcare360/features/User/Dashboard/Presentation/Bloc/drawer_bloc.dart';
import 'package:getcare360/features/User/Dashboard/Presentation/Widgets/navigation_file.dart';

class MyAccountPersonalDetailsPage extends StatefulWidget {
  const MyAccountPersonalDetailsPage({super.key});

  @override
  State<MyAccountPersonalDetailsPage> createState() =>
      _MyAccountPersonalDetailsPageState();
}

class _MyAccountPersonalDetailsPageState
    extends State<MyAccountPersonalDetailsPage> {
  // --- Controllers
  final _nameC = TextEditingController(text: "Akriti");
  final _surnameC = TextEditingController(text: "Pandey");
  final _middleC = TextEditingController();
  final _phoneC = TextEditingController(text: "0401139140");
  final _dobC = TextEditingController(text: "11-08-2002");
  final _bioC = TextEditingController(
    text:
        "Hi My name is Akriti. I am a student looking for a casual job. I have 9 months of working in Aged care and 2 years of working experience in other fields in Australia.\nI am a very reliable and flexible worker and would add a valuable contribution to your team!",
  );

  final _emergencyContactC = TextEditingController(text: "Nisha Pandey");
  final _relationshipC = TextEditingController(text: "Cousin");
  final _emergencyPhoneC = TextEditingController(text: "0450 775 910");
  final _emailC = TextEditingController(text: "akritipandey4071@gmail.com");

  String _state = "New South Wales";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DrawerBloc>().add(
        const DrawerRouteSelected(DrawerRouteKey.myAccountPersonalDetails),
      );
    });
  }

  @override
  void dispose() {
    _nameC.dispose();
    _surnameC.dispose();
    _middleC.dispose();
    _phoneC.dispose();
    _dobC.dispose();
    _bioC.dispose();
    _emergencyContactC.dispose();
    _relationshipC.dispose();
    _emergencyPhoneC.dispose();
    _emailC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF2F6),

      /// ✅ ONLY appbar (no other headers inside body)
      appBar: CustomAppBar(title: 'Personal Details', centerTitle: true),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
            children: [
              _FormCard(
                stateValue: _state,
                onStateChanged: (v) => setState(() => _state = v),
                nameC: _nameC,
                surnameC: _surnameC,
                middleC: _middleC,
                phoneC: _phoneC,
                dobC: _dobC,
                bioC: _bioC,
                emergencyContactC: _emergencyContactC,
                relationshipC: _relationshipC,
                emergencyPhoneC: _emergencyPhoneC,
                emailC: _emailC,
                onPickDob: () => _pickDob(context),
                onSave: () {
                  // TODO: submit to API
                },
              ),
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),

      /// ✅ Footer in correct place
      bottomNavigationBar: Container(
        height: 44,
        alignment: Alignment.center,
        color: AppColors.sideBg,
        child: const Text(
          "2025 © All rights reserved",
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Future<void> _pickDob(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 80),
      lastDate: DateTime(now.year + 1),
      initialDate: DateTime(2002, 8, 11),
    );
    if (picked == null) return;

    // dd-mm-yyyy
    final dd = picked.day.toString().padLeft(2, '0');
    final mm = picked.month.toString().padLeft(2, '0');
    final yyyy = picked.year.toString();
    _dobC.text = "$dd-$mm-$yyyy";
  }
}

/* ---------------- TOP BAR ---------------- */

class _TopBar extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final String userName;
  final int notificationCount;

  const _TopBar({
    required this.onMenuTap,
    required this.userName,
    required this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final compact = w < 520;

    return Material(
      color: Colors.white,
      elevation: 0.5,
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              if (onMenuTap != null)
                IconButton(onPressed: onMenuTap, icon: const Icon(Icons.menu)),
              const SizedBox(width: 6),
              const _Brand(),
              const Spacer(),
              if (!compact)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.fullscreen),
                ),
              _NotificationButton(count: notificationCount),
              const SizedBox(width: 10),
              _ProfileChip(name: userName),
            ],
          ),
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          "getup",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        Text(
          "ai",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Color(0xFFDB2777),
          ),
        ),
      ],
    );
  }
}

class _NotificationButton extends StatelessWidget {
  final int count;
  const _NotificationButton({required this.count});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
        if (count > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                count > 999 ? "999+" : "$count",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ProfileChip extends StatelessWidget {
  final String name;
  const _ProfileChip({required this.name});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final small = w < 420;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(radius: 12, backgroundColor: Color(0xFFE5E7EB)),
          if (!small) ...[
            const SizedBox(width: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 160),
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/* ---------------- PAGE HEADER ROW ---------------- */

class _PageTitleRow extends StatelessWidget {
  final String title;
  final String breadcrumb;

  const _PageTitleRow({required this.title, required this.breadcrumb});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final stacked = w < 720;

    final bread = Container(
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
          Text(
            breadcrumb,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    if (stacked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          bread,
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
          ),
        ),
        bread,
      ],
    );
  }
}

/* ---------------- MAIN FORM CARD ---------------- */

class _FormCard extends StatelessWidget {
  final String stateValue;
  final ValueChanged<String> onStateChanged;

  final TextEditingController nameC;
  final TextEditingController surnameC;
  final TextEditingController middleC;
  final TextEditingController phoneC;
  final TextEditingController dobC;
  final TextEditingController bioC;

  final TextEditingController emergencyContactC;
  final TextEditingController relationshipC;
  final TextEditingController emergencyPhoneC;
  final TextEditingController emailC;

  final VoidCallback onPickDob;
  final VoidCallback onSave;

  const _FormCard({
    required this.stateValue,
    required this.onStateChanged,
    required this.nameC,
    required this.surnameC,
    required this.middleC,
    required this.phoneC,
    required this.dobC,
    required this.bioC,
    required this.emergencyContactC,
    required this.relationshipC,
    required this.emergencyPhoneC,
    required this.emailC,
    required this.onPickDob,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        child: LayoutBuilder(
          builder: (context, c) {
            final desktop = c.maxWidth >= 980;

            final form = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "Personal Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                _GridForm(
                  children: [
                    _Input(
                      label: "Name",
                      requiredStar: true,
                      controller: nameC,
                    ),
                    _Input(
                      label: "surname",
                      requiredStar: true,
                      controller: surnameC,
                    ),
                    _Input(
                      label: "Middle Name",
                      controller: middleC,
                      hint: "Middle Name",
                    ),
                    _Input(
                      label: "Phone",
                      requiredStar: true,
                      controller: phoneC,
                    ),
                    _Dropdown(
                      label: "State",
                      requiredStar: true,
                      value: stateValue,
                      items: const [
                        "New South Wales",
                        "Victoria",
                        "Queensland",
                        "South Australia",
                        "Western Australia",
                        "Tasmania",
                        "Northern Territory",
                        "Australian Capital Territory",
                      ],
                      onChanged: onStateChanged,
                    ),
                    _DateInput(
                      label: "DOB",
                      requiredStar: true,
                      controller: dobC,
                      onTap: onPickDob,
                    ),

                    // profile picker row (looks like web choose file)
                    _FilePickRow(label: "Profile Picture"),
                    _BioArea(label: "My Bio", controller: bioC),
                  ],
                ),

                const SizedBox(height: 18),
                Divider(color: Colors.grey.shade300),
                const SizedBox(height: 12),

                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 6, bottom: 6),
                    child: Text(
                      "Emergency Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                _GridForm(
                  children: [
                    _Input(
                      label: "Emergency contact",
                      requiredStar: true,
                      controller: emergencyContactC,
                    ),
                    _Input(
                      label: "Relationship",
                      requiredStar: true,
                      controller: relationshipC,
                    ),
                    _Input(label: "Phone number", controller: emergencyPhoneC),
                    _Input(
                      label: "Email",
                      requiredStar: true,
                      controller: emailC,
                    ),
                  ],
                ),

                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 38,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                      ),
                      onPressed: onSave,
                      child: const Text(
                        "SAVE",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ],
            );

            final photo = _ProfilePhotoBox(
              // replace with NetworkImage/FileImage later
              child: Image.asset(
                "assets/images/profile.jpg",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.person, size: 44),
                ),
              ),
            );

            if (!desktop) {
              // stack on mobile
              return Column(
                children: [
                  Align(alignment: Alignment.centerRight, child: photo),
                  const SizedBox(height: 14),
                  form,
                ],
              );
            }

            // desktop: form + photo on right
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: form),
                const SizedBox(width: 18),
                Padding(padding: const EdgeInsets.only(top: 44), child: photo),
              ],
            );
          },
        ),
      ),
    );
  }
}

/* ---------------- SMALL UI HELPERS ---------------- */

class _GridForm extends StatelessWidget {
  final List<Widget> children;
  const _GridForm({required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        int cols = 1;
        if (c.maxWidth >= 1100) {
          cols = 2; // matches the look in screenshot (tight center form)
        } else if (c.maxWidth >= 760) {
          cols = 2;
        }

        const spacing = 14.0;
        final itemW = (c.maxWidth - spacing * (cols - 1)) / cols;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: children.map((w) {
            // Bio + File row should take full width
            final full = w is _BioArea || w is _FilePickRow;
            return SizedBox(width: full ? c.maxWidth : itemW, child: w);
          }).toList(),
        );
      },
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  final bool requiredStar;

  const _Label({required this.text, this.requiredStar = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        if (requiredStar)
          const Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(
              "*",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900),
            ),
          ),
      ],
    );
  }
}

class _Input extends StatelessWidget {
  final String label;
  final bool requiredStar;
  final String? hint;
  final TextEditingController controller;

  const _Input({
    required this.label,
    required this.controller,
    this.requiredStar = false,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(text: label, requiredStar: requiredStar),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ],
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String label;
  final bool requiredStar;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const _Dropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.requiredStar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(text: label, requiredStar: requiredStar),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          ),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) {
            if (v == null) return;
            onChanged(v);
          },
        ),
      ],
    );
  }
}

class _DateInput extends StatelessWidget {
  final String label;
  final bool requiredStar;
  final TextEditingController controller;
  final VoidCallback onTap;

  const _DateInput({
    required this.label,
    required this.controller,
    required this.onTap,
    this.requiredStar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(text: label, requiredStar: requiredStar),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            suffixIcon: const Icon(Icons.calendar_month),
          ),
        ),
      ],
    );
  }
}

class _FilePickRow extends StatelessWidget {
  final String label;
  const _FilePickRow({required this.label});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final stacked = w < 520;

    final row = Row(
      children: [
        OutlinedButton(
          onPressed: () {
            // TODO: file picker (web/mobile)
          },
          child: const Text("Choose file"),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text("No file chosen", overflow: TextOverflow.ellipsis),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(text: label),
        const SizedBox(height: 6),
        stacked ? row : row,
        const SizedBox(height: 6),
        Text(
          "To modify your photo, just click the above button.",
          style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          "Passport Size Photo Only",
          style: TextStyle(
            color: Colors.red.shade600,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _BioArea extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _BioArea({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(text: label),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: 4,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ],
    );
  }
}

class _ProfilePhotoBox extends StatelessWidget {
  final Widget child;
  const _ProfilePhotoBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
