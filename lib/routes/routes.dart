import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../data/model/cart_model.dart';
import '../data/model/product_model.dart';
import '../data/remote/product_remote.dart';
import '../presentation/bloc/notification_cubit/notification_cubit.dart';
import '../presentation/bloc/page_cubit/page_cubit.dart';
import '../presentation/bloc/product_bloc/product_bloc.dart';
import '../presentation/bloc/cart_bloc/cart_bloc.dart';
import '../presentation/bloc/profile_bloc/profile_bloc.dart';
import '../presentation/bloc/user_cubit/user_cubit.dart';
import '../shared/list_icon.dart';
import '../shared/lottie.dart';
import '../shared/style.dart';

part 'app_routes.dart';
part 'named_routes.dart';
part '../shared/theme.dart';
part '../presentation/ui/pages/splash_page.dart';
part '../presentation/ui/pages/sign_in_page.dart';
part '../presentation/ui/pages/main_page.dart';
part '../presentation/ui/pages/product_page.dart';
part '../presentation/ui/pages/detail_product_page.dart';
part '../presentation/ui/pages/cart_page.dart';
part '../presentation/ui/pages/profile_page.dart';

part '../presentation/ui/widgets/custom_button.dart';
part '../presentation/ui/widgets/custom_text_form.dart';
part '../presentation/ui/widgets/custom_buttom_navigation_item.dart';
part '../presentation/ui/widgets/map/mini_map.dart';
part '../presentation/ui/widgets/cart/custom_tile_cart.dart';
part '../presentation/ui/widgets/cart/history_cart.dart';
part '../presentation/ui/widgets/product/custom_tile_product.dart';

part '../utils/utils.dart';
part '../utils/notification_helper.dart';
part '../utils/date_time_helper.dart';

part '../data/remote/notification_remote.dart';
part '../data/remote/background_remote.dart';
