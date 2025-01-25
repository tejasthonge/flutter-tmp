import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kequele/core/di/app_dependency_injection.dart';
import 'package:kequele/modules/index.dart';
import 'package:kequele/shared/services/index.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final LoginSignupUsecase loginSignupUsecase =
      AppDependencyInjection.getIt.get<LoginSignupUsecase>();
  final AppLocalData local = AppDependencyInjection.getIt.get<AppLocalData>();
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingInitialEvent>(onboardingInitialEvent);
    on<OnboardingLoginBTNPressedEvent>(onboardingLoginBTNPressedEvent);
    on<OnboardingSignupBTNPressedEvent>(onboardingSignupBTNPressedEvent);
    on<OnboardingGoogleBTNPressedEvent>(onboardingGoogleBTNPressedEvent);
  }
  void onboardingInitialEvent(
      OnboardingInitialEvent event, Emitter<OnboardingState> emit) {
    emit(OnboardingLoadingState());
    try {
      emit(OnboardingSuccessState());
    } catch (e) {
      emit(OnboardingErrorState(error: e.toString()));
    }
  }

  void onboardingLoginBTNPressedEvent(OnboardingLoginBTNPressedEvent event,
      Emitter<OnboardingState> emit) async {
    emit(OnboardingLoadingState());
    try {
      String result = await loginSignupUsecase.loginWithEmailPassword(
          email: event.email, password: event.password);
      if (result == "User Login Successfully") {
        local.setFirebaseUid(
            uid: loginSignupUsecase
                .firebaseServices.firebaseAuth.currentUser!.uid);
        emit(LoginSuccessState(message: result));
      } else {
        emit(LoginErrorState(error: result));
      }
      emit(OnboardingSuccessState());
    } catch (e) {
      emit(LoginErrorState(error: e.toString()));
      emit(OnboardingSuccessState());
    }
  }

  void onboardingSignupBTNPressedEvent(OnboardingSignupBTNPressedEvent event,
      Emitter<OnboardingState> emit) async {
    emit(OnboardingLoadingState());
    try {
      String result = await loginSignupUsecase.singupUserWithEmailAndPassword(
          email: event.email, password: event.password);
      if (result == "User Register Successfully") {
        emit(SignupSuccessState(message: result));
      } else {
        emit(SignupErrorState(error: result));
      }
      emit(OnboardingSuccessState());
    } catch (e) {
      emit(SignupErrorState(error: e.toString()));
      emit(OnboardingSuccessState());
    }
  }

  void onboardingGoogleBTNPressedEvent(OnboardingGoogleBTNPressedEvent event,
      Emitter<OnboardingState> emit) async {
    emit(OnboardingLoadingState());
    String result = '';
    try {
      result = await loginSignupUsecase.googleLoginSingup();
      if (result == "Google Login  Successful") {
        if (FirebaseAuth.instance.currentUser != null) {
          await local.setFirebaseUid(uid: FirebaseAuth.instance.currentUser!.uid);
          emit(LoginSuccessState(message: result));
        }
      } else {
        emit(LoginErrorState(error: result));
      }
    } catch (e) {
      log(e.toString());
      emit(LoginErrorState(error: result));
    }
    emit(OnboardingSuccessState());
  }
}
