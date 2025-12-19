import 'package:flutter/material.dart';
import 'package:getcare360/features/Agency/domain/entity/org_entity.dart';
import 'package:getcare360/features/Agency/presentation/widget/Organization/org_action_button.dart';
import 'package:getcare360/features/Agency/presentation/widget/Organization/org_statuschip.dart';

class OrgTableRow extends StatelessWidget {
  final int? slNo;
  final OrgEntity item;
  final bool mobile;
  final bool isTablet;

  const OrgTableRow.desktop({
    super.key,
    required this.slNo,
    required this.item,
    required this.isTablet,
  }) : mobile = false;

  const OrgTableRow.mobile({super.key, required this.item})
    : slNo = null,
      mobile = true,
      isTablet = false;

  @override
  Widget build(BuildContext context) {
    if (mobile) return _mobileCard(context);

    if (isTablet) {
      // ✅ Tablet compact row
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 50, child: Text("${slNo ?? ""}")),
            SizedBox(
              width: 200,
              child: Text(
                item.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(width: 240, child: Text(item.contact)),
            SizedBox(width: 160, child: StatusChip(status: item.status)),
            SizedBox(
              width: 160,
              child: ActionButtons(
                compact: true,
                onEdit: () {},
                onDelete: () {},
              ),
            ),
          ],
        ),
      );
    }

    // ✅ Desktop full row
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 50, child: Text("${slNo ?? ""}")),
          SizedBox(
            width: 200,
            child: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 260, child: Text(item.contact)),
          SizedBox(width: 260, child: Text(item.services)),
          SizedBox(width: 220, child: Text(item.group)),
          SizedBox(width: 120, child: Text(_fmtDate(item.regDate))),
          SizedBox(width: 130, child: StatusChip(status: item.status)),
          SizedBox(
            width: 160,
            child: ActionButtons(onEdit: () {}, onDelete: () {}),
          ),
        ],
      ),
    );
  }

  Widget _mobileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          _kv("Contact", item.contact),
          _kv("Services", item.services),
          _kv("Group", item.group),
          _kv("Reg. Date", _fmtDate(item.regDate)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusChip(status: item.status),
              ActionButtons(onEdit: () {}, onDelete: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, height: 1.3),
          children: [
            TextSpan(
              text: "$k: ",
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(text: v),
          ],
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yy = d.year.toString();
    return "$dd-$mm-$yy";
  }
}
