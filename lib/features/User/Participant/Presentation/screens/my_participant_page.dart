import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

/// ------------------------------------------------------------
/// MODELS (replace with your API models)
/// ------------------------------------------------------------
class Participant {
  final String id;
  final String name;
  final String dob;
  final String email;
  final String address;

  const Participant({
    required this.id,
    required this.name,
    required this.dob,
    required this.email,
    required this.address,
  });
}

class ProgressNote {
  final String author;
  final String writtenOn; // "16-Sep-2025, at 16:13"
  final String body;

  const ProgressNote({
    required this.author,
    required this.writtenOn,
    required this.body,
  });
}

/// ------------------------------------------------------------
/// PARTICIPANTS LIST PAGE (matches "Participants" table)
/// ------------------------------------------------------------
class ParticipantsListPage extends StatelessWidget {
  const ParticipantsListPage({super.key});

  static const _demo = <Participant>[
    Participant(
      id: "THC-0317",
      name: "Anthony Bryson",
      dob: "08-09-2025",
      email: "amyshengamy@yahoo.com",
      address: "—",
    ),
    Participant(
      id: "THC-0222",
      name: "Gianni Mosquera Agreda",
      dob: "30-11-1963",
      email: "karinmos2@msn.com",
      address: "—",
    ),
    Participant(
      id: "THC-0297",
      name: "Ivar Borman",
      dob: "30-10-1956",
      email: "kate@beyousupportcoordination.com",
      address: "—",
    ),
    Participant(
      id: "THC-0141",
      name: "John Willett",
      dob: "04-01-1960",
      email: "willettjohn22@hotmail.com",
      address: "2/19 Rawson Road, Woy Woy 2256",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF2F6),
      appBar: CustomAppBar(title: 'My Participant', centerTitle: true),
      bottomNavigationBar: const _FooterBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Participants",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 12),

                /// ✅ No scrolling: make the card take remaining height
                Expanded(
                  child: _CardShell(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: LayoutBuilder(
                        builder: (context, c) {
                          final isMobile = c.maxWidth < 720;

                          return Column(
                            children: [
                              _ParticipantsHeaderRow(isMobile: isMobile),
                              const SizedBox(height: 6),
                              Divider(height: 1, color: Colors.grey.shade300),

                              /// Rows (no scroll). If data grows too much, it will overflow.
                              ..._demo.map(
                                (p) => _ParticipantRow(
                                  participant: p,
                                  isMobile: isMobile,
                                  onTapName: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ParticipantDetailsPage(
                                          participant: p,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* ---------------- UI PARTS ---------------- */

class _ParticipantsHeaderRow extends StatelessWidget {
  final bool isMobile;
  const _ParticipantsHeaderRow({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      // On mobile we show "label blocks" in each row, so header can be minimal.
      return const Align(
        alignment: Alignment.centerLeft,
        child: Text("List", style: TextStyle(fontWeight: FontWeight.w900)),
      );
    }

    return Row(
      children: const [
        Expanded(
          flex: 2,
          child: Text("ID", style: TextStyle(fontWeight: FontWeight.w900)),
        ),
        Expanded(
          flex: 4,
          child: Text("NAME", style: TextStyle(fontWeight: FontWeight.w900)),
        ),
        Expanded(
          flex: 3,
          child: Text(
            "DATE OF BIRTH",
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text("EMAIL", style: TextStyle(fontWeight: FontWeight.w900)),
        ),
      ],
    );
  }
}

class _ParticipantRow extends StatelessWidget {
  final Participant participant;
  final bool isMobile;
  final VoidCallback onTapName;

  const _ParticipantRow({
    required this.participant,
    required this.isMobile,
    required this.onTapName,
  });

  @override
  Widget build(BuildContext context) {
    final divider = Divider(height: 1, color: Colors.grey.shade200);

    if (isMobile) {
      return Column(
        children: [
          InkWell(
            onTap: onTapName,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _kv("ID", participant.id),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Text(
                            "NAME",
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Text(
                            participant.name,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _kv("DATE OF BIRTH", participant.dob),
                    const SizedBox(height: 8),
                    _kv("EMAIL", participant.email),
                  ],
                ),
              ),
            ),
          ),
          divider,
        ],
      );
    }

    return Column(
      children: [
        InkWell(
          onTap: onTapName,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    participant.id,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: InkWell(
                    onTap: onTapName,
                    child: Text(
                      participant.name,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    participant.dob,
                    style: TextStyle(color: Colors.grey.shade700),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    participant.email,
                    style: TextStyle(color: Colors.grey.shade700),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        divider,
      ],
    );
  }

  Widget _kv(String k, String v) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(k, style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
        Expanded(
          flex: 7,
          child: Text(v, style: TextStyle(color: Colors.grey.shade700)),
        ),
      ],
    );
  }
}

/// ------------------------------------------------------------
/// PARTICIPANT DETAILS PAGE (matches progress note / profile tabs)
/// ------------------------------------------------------------
class ParticipantDetailsPage extends StatefulWidget {
  final Participant participant;
  const ParticipantDetailsPage({super.key, required this.participant});

  @override
  State<ParticipantDetailsPage> createState() => _ParticipantDetailsPageState();
}

enum _PatientTab { progress, chart, carePlan, profile }

class _ParticipantDetailsPageState extends State<ParticipantDetailsPage> {
  _PatientTab tab = _PatientTab.progress;

  // demo filters
  String sort = "Date desc";
  String staff = "All Staff";
  String listing = "All Listings";

  // demo pagination
  int page = 2;
  final int totalPages = 5;

  static const _notes = <ProgressNote>[
    ProgressNote(
      author: "Victoria Lomoczo Guarde",
      writtenOn: "16-Sep-2025, at 16:13",
      body:
          "Arrived at Rawson at 8:00 am. John was sitting on his chair, smoking and breakfast was already done and morning medication was already administered. Staff offered John a cup of coffee. John asked the staff to changed his pad, staff prompted.\n\n"
          "X2 staff changed John his incontinent pad and took him back outside. John was waiting for his appt, OT to visit him. At 10:00 am OT arrived and had with John a conversation. It took almost 2 hours for explaining John and having a demonstration about his new cushion, but OT brought the new cushion back.\n\n"
          "Staff asked John for lunch and he refused. At 12:30 pm, John refused to changed his pad.\n\n"
          "At 3:30 pm, John advised to changed his pad. X2 staff took John on bed and back to his chair, John was sitting comfortable and having a smoke with a cup of coffee. John was settled sitting in chair and listened music while having cigarettes.",
    ),
    ProgressNote(
      author: "Victoria Lomoczo Guarde",
      writtenOn: "15-Sep-2025, at 13:42",
      body:
          "John was outside having a smoke and talking with his neighbor. John was sitting on his electric wheelchair comfortable and having breakfast with a cup of coffee and cigarettes. Morning meds was still on his table. At 10:00 o'clock John requested to changed his pad and staff prompted. X2 staff attended John personal care and took John back outside. Staff offered John a cup of coffee and took his morning medication.\n\n"
          "At 11:15 a.m. John had a blood test and staff offered an early morning tea. John refused to prepare food for his lunch.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF2F6),
      appBar: const _TopAppBar(userName: "Aastha Tiwari", notificationCount: 0),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
            children: [
              _PatientHeaderCard(participant: widget.participant),
              const SizedBox(height: 12),

              // Tabs + Add New button row (matches screenshot)
              _TabsAndActions(
                active: tab,
                onChanged: (t) => setState(() => tab = t),
                onAddNew: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProgressNoteCreatePage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              if (tab == _PatientTab.progress) ...[
                _FiltersRow(
                  sortValue: sort,
                  staffValue: staff,
                  listingValue: listing,
                  onSort: (v) => setState(() => sort = v),
                  onStaff: (v) => setState(() => staff = v),
                  onListing: (v) => setState(() => listing = v),
                ),
                const SizedBox(height: 12),
                _ProgressNotesList(notes: _notes),
                const SizedBox(height: 14),
                _PaginationBar(
                  current: page,
                  total: totalPages,
                  onPage: (p) => setState(() => page = p),
                ),
              ] else if (tab == _PatientTab.profile) ...[
                const _ProfileCard(),
              ] else ...[
                _CardShell(
                  child: SizedBox(
                    height: 280,
                    child: Center(
                      child: Text(
                        tab == _PatientTab.chart
                            ? "Chart (placeholder)"
                            : "Care Plan (placeholder)",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _FooterBar(),
    );
  }
}

/// ------------------------------------------------------------
/// PROGRESS NOTE CREATE PAGE (matches “Progress Note” form screenshot)
/// (WYSIWYG toolbar not implemented here; use your editor package later.)
/// ------------------------------------------------------------
class ProgressNoteCreatePage extends StatefulWidget {
  const ProgressNoteCreatePage({super.key});

  @override
  State<ProgressNoteCreatePage> createState() => _ProgressNoteCreatePageState();
}

class _ProgressNoteCreatePageState extends State<ProgressNoteCreatePage> {
  final dateCtrl = TextEditingController(text: "26-12-2025");
  final timeCtrl = TextEditingController(text: "6:16 PM");
  final notesCtrl = TextEditingController();

  @override
  void dispose() {
    dateCtrl.dispose();
    timeCtrl.dispose();
    notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF2F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.6,
        title: const Text(
          "Progress Note",
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
            children: [
              _CardShell(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LayoutBuilder(
                        builder: (context, c) {
                          final twoCols = c.maxWidth >= 900;
                          final date = _LabeledField(
                            label: "Date",
                            child: TextFormField(
                              controller: dateCtrl,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                                suffixIcon: Icon(Icons.calendar_month),
                              ),
                            ),
                          );
                          final time = _LabeledField(
                            label: "Time",
                            child: TextFormField(
                              controller: timeCtrl,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                                suffixIcon: Icon(Icons.schedule),
                              ),
                            ),
                          );

                          if (twoCols) {
                            return Row(
                              children: [
                                Expanded(child: date),
                                const SizedBox(width: 14),
                                Expanded(child: time),
                              ],
                            );
                          }
                          return Column(
                            children: [date, const SizedBox(height: 12), time],
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _LabeledField(
                        label: "Notes",
                        child: TextFormField(
                          controller: notesCtrl,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _LabeledField(
                        label: "Upload File",
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade200,
                                  foregroundColor: Colors.black87,
                                ),
                                onPressed: () {},
                                child: const Text("Choose files"),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "No file chosen",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Press Ctrl for windows and Cmd for mac to upload multiple documents",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7A0B7C),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              "Submit",
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _FooterBar(),
    );
  }
}

/// ------------------------------------------------------------
/// UI PARTS
/// ------------------------------------------------------------
class _TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final int notificationCount;

  const _TopAppBar({required this.userName, required this.notificationCount});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.6,
      titleSpacing: 0,
      title: Row(
        children: [
          const SizedBox(width: 8),
          // simple "getupai" brand
          const Text(
            "getup",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
          const Text(
            "ai",
            style: TextStyle(
              color: Color(0xFFB012D6),
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.fullscreen),
          color: Colors.black87,
          tooltip: "Fullscreen",
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
              color: Colors.black87,
            ),
            if (notificationCount > 0)
              Positioned(
                right: 6,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    notificationCount > 999 ? "999+" : "$notificationCount",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 6),
        Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 12,
                backgroundColor: Color(0xFFE5E7EB),
              ),
              const SizedBox(width: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 160),
                child: Text(
                  userName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      iconTheme: const IconThemeData(color: Colors.black87),
    );
  }
}

class _FooterBar extends StatelessWidget {
  const _FooterBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      alignment: Alignment.center,
      color: const Color(0xFF6A0B6D), // purple strip
      child: const Text(
        "2025 © All rights reserved",
        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  final Widget child;
  const _CardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: child,
      ),
    );
  }
}

class _PatientHeaderCard extends StatelessWidget {
  final Participant participant;
  const _PatientHeaderCard({required this.participant});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: LayoutBuilder(
          builder: (context, c) {
            final compact = c.maxWidth < 820;

            final left = Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 34,
                  backgroundColor: Color(0xFFEDEDED),
                  child: Icon(Icons.person, size: 34, color: Colors.grey),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        participant.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.cake_outlined,
                            size: 16,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            participant.dob,
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );

            final right = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 8),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: compact ? 320 : 420,
                      ),
                      child: Text(
                        participant.address,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.mail_outline,
                      size: 16,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 8),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: compact ? 320 : 420,
                      ),
                      child: Text(
                        participant.email,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                  ],
                ),
              ],
            );

            final logo = Align(
              alignment: Alignment.centerRight,
              child: Text(
                "getupai",
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey.shade500,
                ),
              ),
            );

            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  left,
                  const SizedBox(height: 12),
                  right,
                  const SizedBox(height: 10),
                  logo,
                ],
              );
            }

            return Row(
              children: [
                Expanded(flex: 5, child: left),
                const SizedBox(width: 16),
                Expanded(flex: 6, child: right),
                const SizedBox(width: 16),
                Expanded(flex: 3, child: logo),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TabsAndActions extends StatelessWidget {
  final _PatientTab active;
  final ValueChanged<_PatientTab> onChanged;
  final VoidCallback onAddNew;

  const _TabsAndActions({
    required this.active,
    required this.onChanged,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Container(
        color: const Color(0xFFF5F3FB),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: LayoutBuilder(
          builder: (context, c) {
            final stacked = c.maxWidth < 720;

            final tabs = Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _TabChip(
                  text: "Progress Note",
                  active: active == _PatientTab.progress,
                  onTap: () => onChanged(_PatientTab.progress),
                ),
                _TabChip(
                  text: "Chart ▾",
                  active: active == _PatientTab.chart,
                  onTap: () => onChanged(_PatientTab.chart),
                ),
                _TabChip(
                  text: "Care Plan ▾",
                  active: active == _PatientTab.carePlan,
                  onTap: () => onChanged(_PatientTab.carePlan),
                ),
                _TabChip(
                  text: "Profile",
                  active: active == _PatientTab.profile,
                  onTap: () => onChanged(_PatientTab.profile),
                ),
              ],
            );

            final addBtn = SizedBox(
              height: 38,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A0B6D),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: onAddNew,
                icon: const Icon(Icons.person_add_alt_1, size: 18),
                label: const Text(
                  "Add New",
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            );

            if (stacked) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tabs,
                  const SizedBox(height: 10),
                  Align(alignment: Alignment.centerLeft, child: addBtn),
                ],
              );
            }

            return Row(
              children: [
                Expanded(child: tabs),
                const SizedBox(width: 12),
                addBtn,
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final String text;
  final bool active;
  final VoidCallback onTap;

  const _TabChip({
    required this.text,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final purple = const Color(0xFF6A0B6D);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? purple : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.blue.shade700 : Colors.blueGrey.shade700,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _FiltersRow extends StatelessWidget {
  final String sortValue;
  final String staffValue;
  final String listingValue;

  final ValueChanged<String> onSort;
  final ValueChanged<String> onStaff;
  final ValueChanged<String> onListing;

  const _FiltersRow({
    required this.sortValue,
    required this.staffValue,
    required this.listingValue,
    required this.onSort,
    required this.onStaff,
    required this.onListing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 5,
          child: Wrap(
            alignment: WrapAlignment.end,
            spacing: 12,
            runSpacing: 10,
            children: [
              _MiniDropdown(
                value: sortValue,
                items: const ["Date desc", "Date asc"],
                onChanged: onSort,
              ),
              _MiniDropdown(
                value: staffValue,
                items: const ["All Staff", "Staff A", "Staff B"],
                onChanged: onStaff,
              ),
              _MiniDropdown(
                value: listingValue,
                items: const ["All Listings", "Listing A", "Listing B"],
                onChanged: onListing,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MiniDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const _MiniDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 38,
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }
}

class _ProgressNotesList extends StatelessWidget {
  final List<ProgressNote> notes;
  const _ProgressNotesList({required this.notes});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        children: [...notes.map((n) => _ProgressNoteTile(note: n)).toList()],
      ),
    );
  }
}

class _ProgressNoteTile extends StatelessWidget {
  final ProgressNote note;
  const _ProgressNoteTile({required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${note.author} has submitted a new progress note.",
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Text(
            "Wrote on ${note.writtenOn}",
            style: const TextStyle(
              color: Color(0xFF00B894),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(note.body, style: const TextStyle(height: 1.35)),
        ],
      ),
    );
  }
}

class _PaginationBar extends StatelessWidget {
  final int current;
  final int total;
  final ValueChanged<int> onPage;

  const _PaginationBar({
    required this.current,
    required this.total,
    required this.onPage,
  });

  @override
  Widget build(BuildContext context) {
    final purple = const Color(0xFF6A0B6D);

    Widget btn(String text, {VoidCallback? onTap, bool active = false}) {
      return SizedBox(
        height: 34,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: active ? purple : Colors.white,
            foregroundColor: active ? Colors.white : Colors.black87,
            side: BorderSide(color: Colors.grey.shade300),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      );
    }

    final pages = List.generate(total, (i) => i + 1);

    return Center(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [
          btn("Prev", onTap: current > 1 ? () => onPage(current - 1) : null),
          ...pages.map(
            (p) => btn("$p", active: p == current, onTap: () => onPage(p)),
          ),
          btn(
            "Next",
            onTap: current < total ? () => onPage(current + 1) : null,
          ),
          btn("Last", onTap: current < total ? () => onPage(total) : null),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _kv("Full Name", "John Willett"),
            const Divider(height: 24),
            _kv(
              "Participant Bio",
              "I am on the DSP and unable to work due to declined mobility after double leg amputations. "
                  "I have support from the NDIS with all my personal care and community access. "
                  "I am unable to complete this on my own. I have an interest in horseracing and would like to be more involved in my community. "
                  "I attend Physiotherapy weekly.",
            ),
            const Divider(height: 24),
            _kv(
              "My Support Needs (How can i help you)",
              "Assistance of a support care staff",
            ),
            const Divider(height: 24),
            _kv("Communication Preferences", "“Verbally non-verbal”"),
            const Divider(height: 24),
            _kv("Family and Support Network", "."),
            const Divider(height: 24),
            _kv("Cultural and Linguistic Needs", "."),
            const Divider(height: 24),
            _kv("Hobbies and Interests", "Horse racing"),
          ],
        ),
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(k, style: const TextStyle(fontWeight: FontWeight.w900)),
        const SizedBox(height: 6),
        Text(v, style: TextStyle(color: Colors.grey.shade800, height: 1.35)),
      ],
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}
