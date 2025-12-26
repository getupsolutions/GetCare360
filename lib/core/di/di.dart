import 'package:get_it/get_it.dart';
import 'package:getcare360/features/User/Dashboard/Presentation/Bloc/drawer_bloc.dart';
import 'package:getcare360/features/User/MyAccount/Presentation/Cubit/empl_for_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerLazySingleton<DrawerBloc>(() => DrawerBloc());
  sl.registerFactory<EmployeeFormCubit>(() => EmployeeFormCubit());

  // Example (later):
  // sl.registerFactory(() => AuthBloc(sl()));

  // -------------------------
  // UseCases (Lazy Singleton)
  // -------------------------
  // Example:
  // sl.registerLazySingleton(() => LoginUseCase(sl()));

  // -------------------------
  // Repositories
  // -------------------------
  // Example:
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // -------------------------
  // Data Sources
  // -------------------------
  // Example:
  // sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource());
}
