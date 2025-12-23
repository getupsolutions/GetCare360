import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';

enum Mailbox { inbox, sent }

class MessageItem {
  final String id;
  final String senderName;
  final String subject;
  final String preview;
  final DateTime date;
  final bool unread;

  const MessageItem({
    required this.id,
    required this.senderName,
    required this.subject,
    required this.preview,
    required this.date,
    this.unread = false,
  });
}

/// ---------------------------------------------------------------------------
///  PAGE
/// ---------------------------------------------------------------------------

class AdminMessageModulePage extends StatefulWidget {
  const AdminMessageModulePage({super.key});

  @override
  State<AdminMessageModulePage> createState() => _MessageModulePageState();
}

class _MessageModulePageState extends State<AdminMessageModulePage> {
  static const Color brandPurple = Color(0xFF9C27B0);
  static const Color brandPurpleDark = Color(0xFF8E24AA);
  static const Color cardBg = Colors.white;

  Mailbox _mailbox = Mailbox.inbox;
  String _mode = "inbox"; // inbox | sent | compose | detail
  MessageItem? _selected;

  // Demo counts like screenshots
  int get _inboxCount => _inboxMessages.where((e) => e.unread).length;
  int get _sentCount => 0;

  final List<MessageItem> _inboxMessages = [
    MessageItem(
      id: "1",
      senderName: "Yashoda Shrestha",
      subject: "Progress note",
      preview: "Client: Rohee Reddy Staff: Yashoda Shrestha Date: ...",
      date: DateTime(2025, 9, 15, 22, 36),
      unread: true,
    ),
    MessageItem(
      id: "2",
      senderName: "Sangyal Dorjee",
      subject: "No showing clock out",
      preview: "Hi Sarah, I did work yesterday ...",
      date: DateTime(2025, 9, 12, 0, 8),
      unread: true,
    ),
    MessageItem(
      id: "3",
      senderName: "Yashoda Shrestha",
      subject: "Roheen",
      preview: "Client: Rohee Reddy Staff: Yashoda Shrestha Date: ...",
      date: DateTime(2025, 9, 1, 11, 6),
    ),
    MessageItem(
      id: "4",
      senderName: "Anbuchelvi Ramkumar",
      subject: "My time sheet no approval",
      preview: "Hi still my time sheet not approve can you please ...",
      date: DateTime(2025, 8, 27, 15, 28),
    ),
    MessageItem(
      id: "5",
      senderName: "Hong Le",
      subject: "Claim shift",
      preview: "Hi can you help me take off shift on Tuesday 19th ...",
      date: DateTime(2025, 8, 13, 19, 22),
    ),
  ];

  final List<MessageItem> _sentMessages = [
    MessageItem(
      id: "s1",
      senderName: "Shine",
      subject: "hi",
      preview: "hjghdch",
      date: DateTime(2024, 11, 27, 18, 28),
    ),
    MessageItem(
      id: "s2",
      senderName: "David",
      subject: "Hi",
      preview: "hi David",
      date: DateTime(2024, 11, 27, 18, 27),
    ),
    MessageItem(
      id: "s3",
      senderName: "David",
      subject: "hi",
      preview: "hi",
      date: DateTime(2024, 5, 10, 0, 3),
    ),
  ];

  bool get _isCompose => _mode == "compose";
  bool get _isDetail => _mode == "detail";

  void _openCompose() {
    setState(() {
      _mode = "compose";
      _selected = null;
    });
  }

  void _openList(Mailbox box) {
    setState(() {
      _mailbox = box;
      _mode = box == Mailbox.inbox ? "inbox" : "sent";
      _selected = null;
    });
  }

  void _openDetail(MessageItem item) {
    setState(() {
      _selected = item;
      _mode = "detail";
    });
  }

  List<MessageItem> get _currentList =>
      _mailbox == Mailbox.inbox ? _inboxMessages : _sentMessages;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;

        final isDesktop = w >= 1100;
        final isTablet = w >= 800 && w < 1100;
        final isMobile = w < 800;

        if (isMobile) {
          return _MobileScaffold(
            brandPurple: brandPurple,
            inboxCount: _inboxCount,
            onDrawerSelect: (s) {
              if (s == "compose") _openCompose();
              if (s == "inbox") _openList(Mailbox.inbox);
              if (s == "sent") _openList(Mailbox.sent);
            },
            child: _buildMobileBody(),
          );
        }

        // Tablet + Desktop use 3 panel layout
        return Scaffold(
          backgroundColor: const Color(0xFFF3F4F8),
          body: Row(
            children: [
              // Left sidebar
              // SizedBox(
              //   width: isDesktop ? 240 : 210,
              //   child: _SideNav(
              //     brandPurple: brandPurple,
              //     brandPurpleDark: brandPurpleDark,
              //     selected: "Message",
              //     compact: isTablet,
              //   ),
              // ),

              // Content area
              Expanded(
                child: Column(
                  children: [
                    _TopBar(
                      brandPurple: brandPurple,
                      username: "Triniti Admin",
                    ),
                    Expanded(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1180),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 20,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Mailbox card
                                SizedBox(
                                  width: isDesktop ? 250 : 240,
                                  child: _MailboxCard(
                                    brandPurple: brandPurple,
                                    inboxCount: _inboxCount,
                                    isInbox: _mailbox == Mailbox.inbox,
                                    isSent: _mailbox == Mailbox.sent,
                                    onNewMessage: _openCompose,
                                    onInbox: () => _openList(Mailbox.inbox),
                                    onSent: () => _openList(Mailbox.sent),
                                  ),
                                ),
                                const SizedBox(width: 18),

                                // Main content (list/compose/detail)
                                Expanded(
                                  child: _CardShell(
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 180,
                                      ),
                                      switchInCurve: Curves.easeOut,
                                      switchOutCurve: Curves.easeIn,
                                      child: _isCompose
                                          ? _ComposePanel(
                                              key: const ValueKey("compose"),
                                              brandPurple: brandPurple,
                                            )
                                          : _isDetail
                                          ? _DetailPanel(
                                              key: const ValueKey("detail"),
                                              brandPurple: brandPurple,
                                              message:
                                                  _selected ??
                                                  _currentList.first,
                                              onReply: _openCompose,
                                            )
                                          : _ListPanel(
                                              key: const ValueKey("list"),
                                              mailboxTitle:
                                                  _mailbox == Mailbox.inbox
                                                  ? "Inbox"
                                                  : "Sent",
                                              items: _currentList,
                                              onTap: _openDetail,
                                              highlightUnread:
                                                  _mailbox == Mailbox.inbox,
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
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Mobile body: list/compose/detail pushed in place
  Widget _buildMobileBody() {
    if (_isCompose) {
      return _CardShell(
        padding: const EdgeInsets.all(14),
        child: _ComposePanel(brandPurple: brandPurple),
      );
    }
    if (_isDetail && _selected != null) {
      return _CardShell(
        padding: const EdgeInsets.all(14),
        child: _DetailPanel(
          brandPurple: brandPurple,
          message: _selected!,
          onReply: _openCompose,
        ),
      );
    }

    return _CardShell(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          _MobileMailboxRow(
            brandPurple: brandPurple,
            mailbox: _mailbox,
            inboxCount: _inboxCount,
            onInbox: () => _openList(Mailbox.inbox),
            onSent: () => _openList(Mailbox.sent),
            onCompose: _openCompose,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _ListPanel(
              mailboxTitle: _mailbox == Mailbox.inbox ? "Inbox" : "Sent",
              items: _currentList,
              onTap: (m) {
                setState(() {
                  _selected = m;
                  _mode = "detail";
                });
              },
              highlightUnread: _mailbox == Mailbox.inbox,
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///  MOBILE WRAPPER
/// ---------------------------------------------------------------------------

class _MobileScaffold extends StatelessWidget {
  final Color brandPurple;
  final int inboxCount;
  final Widget child;
  final void Function(String key) onDrawerSelect;

  const _MobileScaffold({
    required this.brandPurple,
    required this.inboxCount,
    required this.child,
    required this.onDrawerSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: CustomAppBar(title: 'Message', centerTitle: true),
      body: child,
    );
  }
}

/// ---------------------------------------------------------------------------
///  TOP BAR (desktop/tablet)
/// ---------------------------------------------------------------------------

class _TopBar extends StatelessWidget {
  final Color brandPurple;
  final String username;

  const _TopBar({required this.brandPurple, required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          // Placeholder for logo area like screenshot
          const Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "getupai",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF616161),
                ),
              ),
            ),
          ),
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: brandPurple,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const Icon(Icons.notifications_none, color: Colors.white),
                const SizedBox(width: 14),
                Text(
                  "Hi, $username",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Text(
                    username.isNotEmpty ? username[0].toUpperCase() : "U",
                    style: TextStyle(
                      color: brandPurple,
                      fontWeight: FontWeight.w800,
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

/// ---------------------------------------------------------------------------
///  LEFT SIDEBAR
/// ---------------------------------------------------------------------------

// class _SideNav extends StatelessWidget {
//   final Color brandPurple;
//   final Color brandPurpleDark;
//   final String selected;
//   final bool compact;

//   const _SideNav({
//     required this.brandPurple,
//     required this.brandPurpleDark,
//     required this.selected,
//     required this.compact,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final items = const [
//       ("Dashboard", Icons.home_outlined),
//       ("Participants", Icons.group_outlined),
//       ("Organization", Icons.apartment_outlined),
//       ("Staff", Icons.badge_outlined),
//       ("Message", Icons.mail_outline),
//       ("Policy & Procedure", Icons.assignment_outlined),
//       ("View & Download Form", Icons.download_outlined),
//       ("Compliance Forms", Icons.verified_outlined),
//       ("Site Options", Icons.settings_outlined),
//     ];

//     return Container(
//       color: brandPurple,
//       child: SafeArea(
//         child: Column(
//           children: [
//             // top spacing like screenshot
//             const SizedBox(height: 14),
//             Expanded(
//               child: ListView.separated(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 itemCount: items.length,
//                 separatorBuilder: (_, __) => const SizedBox(height: 2),
//                 itemBuilder: (context, i) {
//                   final (title, icon) = items[i];
//                   final isSel = title == selected;
//                   return Material(
//                     color: isSel ? brandPurpleDark : Colors.transparent,
//                     child: InkWell(
//                       onTap: () {},
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 12,
//                           horizontal: compact ? 12 : 14,
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(icon, color: Colors.white, size: 20),
//                             if (!compact) ...[
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: Text(
//                                   title,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                               ),
//                               const Icon(
//                                 Icons.chevron_right,
//                                 color: Colors.white70,
//                                 size: 18,
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Padding(
//               padding: EdgeInsets.only(bottom: 10),
//               child: Text(
//                 "2025©",
//                 style: TextStyle(color: Colors.white70, fontSize: 11),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/// ---------------------------------------------------------------------------
///  MAILBOX CARD (left middle)
/// ---------------------------------------------------------------------------

class _MailboxCard extends StatelessWidget {
  final Color brandPurple;
  final int inboxCount;
  final bool isInbox;
  final bool isSent;
  final VoidCallback onNewMessage;
  final VoidCallback onInbox;
  final VoidCallback onSent;

  const _MailboxCard({
    required this.brandPurple,
    required this.inboxCount,
    required this.isInbox,
    required this.isSent,
    required this.onNewMessage,
    required this.onInbox,
    required this.onSent,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: onNewMessage,
              style: ElevatedButton.styleFrom(
                backgroundColor: brandPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                "NEW MESSAGE",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 14),
          _MailboxTile(
            label: "Inbox",
            icon: Icons.inbox_outlined,
            selected: isInbox,
            trailing: _CountPill(count: inboxCount),
            onTap: onInbox,
          ),
          const SizedBox(height: 8),
          _MailboxTile(
            label: "Sent",
            icon: Icons.send_outlined,
            selected: isSent,
            trailing: const SizedBox(width: 26),
            onTap: onSent,
          ),
        ],
      ),
    );
  }
}

class _MailboxTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Widget trailing;
  final VoidCallback onTap;

  const _MailboxTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFFF2F3F7) : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF8E8E8E)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                    color: const Color(0xFF4A4A4A),
                  ),
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _CountPill extends StatelessWidget {
  final int count;
  const _CountPill({required this.count});

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox(width: 26);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE7FBF6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        "$count",
        style: const TextStyle(
          color: Color(0xFF0BAE8A),
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///  MAIN CONTENT WRAPPER CARD
/// ---------------------------------------------------------------------------

class _CardShell extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _CardShell({
    required this.child,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// ---------------------------------------------------------------------------
///  LIST PANEL (Inbox/Sent)
/// ---------------------------------------------------------------------------

class _ListPanel extends StatelessWidget {
  final String mailboxTitle;
  final List<MessageItem> items;
  final void Function(MessageItem item) onTap;
  final bool highlightUnread;

  const _ListPanel({
    super.key,
    required this.mailboxTitle,
    required this.items,
    required this.onTap,
    required this.highlightUnread,
  });

  String _fmt(DateTime d) {
    String two(int v) => v.toString().padLeft(2, "0");
    return "${two(d.day)}-${two(d.month)}-${d.year} ${two(d.hour)}:${two(d.minute)}";
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final m = items[i];
        final bg = (highlightUnread && m.unread)
            ? const Color(0xFFF7F8FC)
            : Colors.white;

        return Material(
          color: bg,
          child: InkWell(
            onTap: () => onTap(m),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFFEDE7F6),
                    child: Text(
                      m.senderName.isNotEmpty
                          ? m.senderName[0].toUpperCase()
                          : "?",
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF6A1B9A),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                m.senderName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2B2B2B),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _fmt(m.date),
                              style: const TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${m.subject}  ",
                                      style: const TextStyle(
                                        color: Color(0xFF333333),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 13,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " - ${m.preview}",
                                      style: const TextStyle(
                                        color: Color(0xFF9E9E9E),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// ---------------------------------------------------------------------------
///  DETAIL PANEL (View message)
/// ---------------------------------------------------------------------------

class _DetailPanel extends StatelessWidget {
  final Color brandPurple;
  final MessageItem message;
  final VoidCallback onReply;

  const _DetailPanel({
    super.key,
    required this.brandPurple,
    required this.message,
    required this.onReply,
  });

  String _fmtDetail(DateTime d) {
    String two(int v) => v.toString().padLeft(2, "0");
    // Similar to screenshot style
    return "Sep ${two(d.day)}, ${d.year} ${two(d.hour)}:${two(d.minute)}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header area (title only like screenshot)
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              message.subject,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF3B3B3B),
              ),
            ),
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFEDE7F6),
                child: Text(
                  message.senderName.isNotEmpty
                      ? message.senderName[0].toUpperCase()
                      : "?",
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF6A1B9A),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message.senderName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              Text(
                _fmtDetail(message.date),
                style: const TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
            child: Text(
              // demo detail text (you’ll bind with API)
              "${message.preview}\n\n"
              "Client: Rohee Reddy Staff: ${message.senderName} Date: 15/09/2025 Time: 7:00AM - 11:00AM\n"
              "Activities: I arrived ... Later give her shower and change her clean clothes. "
              "After change test her blood sugar and note her into her book. "
              "I prepared breakfast, Then I helped her to serve and clean dishes.\n\n"
              "There were no issues to report during the shift.",
              style: const TextStyle(
                height: 1.4,
                fontSize: 13.5,
                color: Color(0xFF4A4A4A),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
          child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: onReply,
              icon: const Icon(Icons.reply, size: 18),
              label: const Text("Reply"),
              style: ElevatedButton.styleFrom(
                backgroundColor: brandPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
///  COMPOSE PANEL (New message)
/// ---------------------------------------------------------------------------

class _ComposePanel extends StatefulWidget {
  final Color brandPurple;
  const _ComposePanel({super.key, required this.brandPurple});

  @override
  State<_ComposePanel> createState() => _ComposePanelState();
}

class _ComposePanelState extends State<_ComposePanel> {
  final _staffCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  @override
  void dispose() {
    _staffCtrl.dispose();
    _subjectCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  InputDecoration _field(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF9FAFD),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: widget.brandPurple, width: 1.2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Purple header strip like screenshot
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.brandPurple,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: const Text(
            "Compose Message",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Label("Staff"),
                  TextField(
                    controller: _staffCtrl,
                    decoration: _field("Select Staff"),
                  ),
                  const SizedBox(height: 14),
                  const _Label("Subject"),
                  TextField(
                    controller: _subjectCtrl,
                    decoration: _field("Subject"),
                  ),
                  const SizedBox(height: 14),
                  const _Label("Description"),
                  TextField(
                    controller: _descCtrl,
                    minLines: 7,
                    maxLines: 10,
                    decoration: _field("Write message..."),
                  ),
                  const SizedBox(height: 14),
                  const _Label("Attachment"),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFD),
                      border: Border.all(color: const Color(0xFFE6E6E6)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.attach_file, size: 18),
                          label: const Text("Choose files"),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "No file chosen",
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Tip: Allow multiple documents (mobile: implement via file_picker).",
                    style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Submit clicked")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.brandPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Color(0xFF5A5A5A),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
///  MOBILE MAILBOX ROW
/// ---------------------------------------------------------------------------

class _MobileMailboxRow extends StatelessWidget {
  final Color brandPurple;
  final Mailbox mailbox;
  final int inboxCount;
  final VoidCallback onInbox;
  final VoidCallback onSent;
  final VoidCallback onCompose;

  const _MobileMailboxRow({
    required this.brandPurple,
    required this.mailbox,
    required this.inboxCount,
    required this.onInbox,
    required this.onSent,
    required this.onCompose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _pill(
            label: "Inbox",
            selected: mailbox == Mailbox.inbox,
            trailing: _CountPill(count: inboxCount),
            onTap: onInbox,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _pill(
            label: "Sent",
            selected: mailbox == Mailbox.sent,
            trailing: const SizedBox(width: 22),
            onTap: onSent,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 44,
          child: ElevatedButton(
            onPressed: onCompose,
            style: ElevatedButton.styleFrom(
              backgroundColor: brandPurple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Icon(Icons.edit_outlined),
          ),
        ),
      ],
    );
  }

  Widget _pill({
    required String label,
    required bool selected,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return Material(
      color: selected ? const Color(0xFFF2F3F7) : Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: selected
                        ? const Color(0xFF3A3A3A)
                        : const Color(0xFF666666),
                  ),
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}
