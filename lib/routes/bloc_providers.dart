import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/bloc/camera_cubit/camera_cubit.dart';
import '../presentation/bloc/cart_bloc/cart_bloc.dart';
import '../presentation/bloc/notification_cubit/notification_cubit.dart';
import '../presentation/bloc/page_cubit/page_cubit.dart';
import '../presentation/bloc/product_bloc/product_bloc.dart';
import '../presentation/bloc/profile_bloc/profile_bloc.dart';
import '../presentation/bloc/user_cubit/user_cubit.dart';

class BlocProviders {
  static List<SingleChildWidget> providers = [
    BlocProvider(
      create: (context) => UserCubit(),
    ),
    BlocProvider(
      create: (context) => PageCubit(),
    ),
    BlocProvider(
      create: (context) => ProfileBloc(),
    ),
    BlocProvider(
      create: (context) => CartBloc(),
    ),
    BlocProvider(
      create: (context) => ProductBloc(),
    ),
    BlocProvider(
      create: (context) => NotificationCubit(),
    ),
    BlocProvider(
      create: (context) => CameraCubit(),
    ),
  ];
}
