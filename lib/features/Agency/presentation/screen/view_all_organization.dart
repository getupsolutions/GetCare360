import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getcare360/core/constant/app_color.dart';
import 'package:getcare360/core/widget/custom_appbar.dart';
import 'package:getcare360/features/Agency/data/data_source/org_remotedatasource.dart';
import 'package:getcare360/features/Agency/data/repositoryImpl/org_repositoryimpl.dart';
import 'package:getcare360/features/Agency/domain/usecase/get_organization_usecase.dart';
import 'package:getcare360/features/Agency/presentation/bloc/organization/org_bloc.dart';
import 'package:getcare360/features/Agency/presentation/bloc/organization/org_event.dart';
import 'package:getcare360/features/Agency/presentation/bloc/organization/org_state.dart';
import 'package:getcare360/features/Agency/presentation/widget/Organization/org_filterbar.dart';
import 'package:getcare360/features/Agency/presentation/widget/Organization/org_table.dart';

class ViewAllOrganizationPage extends StatelessWidget {
  const ViewAllOrganizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simple DI for demo. Replace with get_it/injectable later.
    final bloc = OrgBloc(
      GetOrganizations(OrgRepositoryImpl(OrgRemoteDataSourceImpl())),
    )..add(OrgStarted());

    return BlocProvider(create: (_) => bloc, child: const _ViewAllOrgView());
  }
}

class _ViewAllOrgView extends StatelessWidget {
  const _ViewAllOrgView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'View All Organization', centerTitle: true),
      backgroundColor: AppColors.pageBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Purple header container (like screenshot)
              Container(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                decoration: BoxDecoration(
                  color: AppColors.purple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const OrgFilterBar(),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<OrgBloc, OrgState>(
                  builder: (context, state) {
                    if (state.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.error != null) {
                      return Center(child: Text("Error: ${state.error}"));
                    }
                    return OrgTable(data: state.filtered);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
