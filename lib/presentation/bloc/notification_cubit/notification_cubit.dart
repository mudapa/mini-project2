import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../routes/routes.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  Future<void> toggleNotification(bool value) async {
    try {
      emit((NotificationLoading()));
      final isActive = await NotificationRemote().toggleNotification(value);
      emit(NotificationActive(isActive));
    } catch (e) {
      emit(NotificationFailed(e.toString()));
    }
  }

  Future<bool> loadNotificationStatus() async {
    emit(NotificationLoading());

    try {
      final isActive = await NotificationRemote().loadReminderStatus();
      emit(NotificationActive(isActive));
      return isActive;
    } catch (e) {
      emit(NotificationFailed(e.toString()));
      return false;
    }
  }
}
