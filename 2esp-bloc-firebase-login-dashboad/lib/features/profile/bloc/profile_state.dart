part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
class ProfileActionState extends ProfileState{}

class ProfileLoadingState extends ProfileState{}
class ProfileSuccessState extends ProfileState{}

class ProfileErrorState extends ProfileState{
  final String errorMessage;
  ProfileErrorState({required this.errorMessage});
}

class ProfileLogoutSuccessActionState extends ProfileActionState{
  final String logoutMessage;
  ProfileLogoutSuccessActionState({required this.logoutMessage});
}
class ProfileLogoutErrorActionState extends ProfileActionState{
  final String errorMessage;
  ProfileLogoutErrorActionState({required this.errorMessage});
}