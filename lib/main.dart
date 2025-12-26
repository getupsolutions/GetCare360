import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getcare360/features/Login/presentation/screen/login_screen.dart';
import 'package:getcare360/features/User/Dashboard/Presentation/Bloc/drawer_bloc.dart';
import 'package:getcare360/features/User/MyAccount/Presentation/Cubit/empl_for_cubit.dart';
import 'core/di/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Initialize DI
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<DrawerBloc>()),
        BlocProvider(create: (context) => di.sl<EmployeeFormCubit>()),
      ],
      child: MaterialApp(
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
