import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_project_team_7/data/remote/profile_remote.dart';

import '../../../data/model/user_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final profile = await ProfileRemote().getUserById(event.id);
        emit(ProfileLoadedState(profile: profile));
      } catch (e) {
        emit(ProfileErrorState());
      }
    });
  }
}
