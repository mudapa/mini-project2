import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_project_team_7/data/model/profile_model.dart';
import 'package:mini_project_team_7/data/remote/profile_remote.dart';
import 'package:http/http.dart' as http;

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final profile = await ProfileRemote().fetchProfile(http.Client());
        emit(ProfileLoadedState(profile: profile));
      } catch (e) {
        emit(ProfileErrorState());
      }
    });
  }
}
