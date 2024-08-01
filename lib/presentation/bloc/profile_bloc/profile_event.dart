part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LoadProfileEvent extends ProfileEvent {
  final String id;

  const LoadProfileEvent({required this.id});

  @override
  List<Object> get props => [
        id,
      ];
}
