import 'dart:developer';

import 'package:bloc/bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../core/index.dart';
import '../../../shared/services/index.dart';
import '../../index.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AppLocalData local = AppDependencyInjection.getIt.get<AppLocalData>();
  final ProfileUsecase profileUsecase =
      AppDependencyInjection.getIt.get<ProfileUsecase>();
  String? id;

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialFeatchingEvent>(profileInitialFeatchingEvent);
    on<ProfileLogoutUserEvent>(profileLogoutUserEvent);
  }

  profileInitialFeatchingEvent(
      ProfileInitialFeatchingEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      id = await local.getFirebaseUid();
      if (id != null) {
        emit(ProfileSuccessState());
      }
    } catch (e) {
      log(e.toString());
      emit(ProfileErrorState(errorMessage: e.toString()));
    }
  }

  profileLogoutUserEvent(
      ProfileLogoutUserEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    bool isLogout = await profileUsecase.logOutUser();
    if (isLogout) {
      emit(ProfileLogoutSuccessActionState(
          logoutMessage: "User logged out successfully"));
    } else {
      emit(ProfileLogoutErrorActionState(
          errorMessage: "Failed to log out user"));
    }
  }
}
