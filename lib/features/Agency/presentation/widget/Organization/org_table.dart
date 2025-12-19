import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/responsive.dart';
import 'package:getcare360/features/Agency/domain/entity/org_entity.dart';
import 'package:getcare360/features/Agency/presentation/widget/Organization/org_tableheader.dart';
import 'org_table_row.dart';

class OrgTable extends StatelessWidget {
  final List<OrgEntity> data;
  const OrgTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    if (isMobile) {
      // ✅ Mobile: cards
      return ListView.separated(
        itemCount: data.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) => OrgTableRow.mobile(item: data[index]),
      );
    }

    // ✅ Tablet/Desktop: table-like rows + horizontal scroll only if needed
    final minTableWidth = isTablet ? 920.0 : 1250.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          OrgTableHeader(isTablet: isTablet),
          const Divider(height: 1),
          Expanded(
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: minTableWidth,
                      // if screen is wider than minWidth, table expands to screen
                      maxWidth: constraints.maxWidth > minTableWidth
                          ? constraints.maxWidth
                          : minTableWidth,
                    ),
                    child: ListView.separated(
                      itemCount: data.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) => OrgTableRow.desktop(
                        slNo: index + 1,
                        item: data[index],
                        isTablet: isTablet,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
