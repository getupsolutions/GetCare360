import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';
import 'package:getcare360/features/Admin/Agency/presentation/widget/Organization/archive_widget.dart';

class AdminOrganizationArchivePage extends StatelessWidget {
  const AdminOrganizationArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Archive', centerTitle: true),
      backgroundColor: const Color(0xFFF3F4F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              ArchiveHeader(),
              SizedBox(height: 14),
              Expanded(child: ArchiveBody()),
            ],
          ),
        ),
      ),
    );
  }
}
