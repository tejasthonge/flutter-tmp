part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}
class ProfileInitialFeatchingEvent extends ProfileEvent{}
class ProfileLogoutUserEvent extends ProfileEvent{}
