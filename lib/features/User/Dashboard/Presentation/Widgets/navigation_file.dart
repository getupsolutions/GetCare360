import 'package:flutter/material.dart';
import 'package:getcare360/core/widget/navigator_helper.dart';
import 'package:getcare360/features/User/Dashboard/Data/Model/drawer_model.dart';
import 'package:getcare360/features/User/Dashboard/Presentation/screens/dashboard_page.dart';
import 'package:getcare360/features/User/MyAccount/Presentation/screens/document_page.dart';
import 'package:getcare360/features/User/MyAccount/Presentation/screens/empl_app_form.dart';
import 'package:getcare360/features/User/MyAccount/Presentation/screens/personal_detailspage.dart';
import 'package:getcare360/features/User/MyAccount/Presentation/screens/signed_document_page.dart';
import 'package:getcare360/features/User/Participant/Presentation/screens/Incident_register/add_new_inc.dart';
import 'package:getcare360/features/User/Participant/Presentation/screens/Incident_register/view_all_inc.dart';
import 'package:getcare360/features/User/Participant/Presentation/screens/my_participant_page.dart';

void handleNavigation(BuildContext context, DrawerRouteKey route) {
  switch (route) {
    case DrawerRouteKey.dashboard:
      NavigatorHelper.push(context, const DashboardPage());
      break;

    case DrawerRouteKey.employeeApplicationForm:
      NavigatorHelper.push(context, const EmployeeApplicationFormPage());
      break;

    case DrawerRouteKey.myAccountDocuments:
      NavigatorHelper.push(context, const MyAccountDocumentsPage());
      break;

    case DrawerRouteKey.myAccountSignedDocument:
      NavigatorHelper.push(context, const SignedDocumentsPage());
      break;

    case DrawerRouteKey.myAccountPersonalDetails:
      NavigatorHelper.push(context, const MyAccountPersonalDetailsPage());
      break;

    case DrawerRouteKey.participantsList:
      NavigatorHelper.push(context, const ParticipantsListPage());
      break;

    case DrawerRouteKey.incidentRegisterList:
      NavigatorHelper.push(context, const IncidentRegisterPage());
      break;

    case DrawerRouteKey.incidentRegisterAdd:
      NavigatorHelper.push(context, const AddIncidentPage());

      break;

    case DrawerRouteKey.rosterCalendar:
      break;

    case DrawerRouteKey.rosterMyRoster:
      break;

    case DrawerRouteKey.timesheetList:
      break;

    case DrawerRouteKey.timesheetSubmit:
      break;

    case DrawerRouteKey.availableShiftsList:
      break;

    case DrawerRouteKey.availableShiftsClaimed:
      break;

    case DrawerRouteKey.clockInOutClockIn:
      break;

    case DrawerRouteKey.clockInOutHistory:
      break;
  }
}
