import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/index.dart';
import '../../../shared/services/go_api_services.dart';
import '../../../shared/services/index.dart';
import '../../index.dart';


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
        final token = await loginSignupUsecase
            .firebaseServices.firebaseAuth.currentUser!
            .getIdToken();
        local.setFirebaseUid(
            uid: loginSignupUsecase
                .firebaseServices.firebaseAuth.currentUser!.uid);
        GolainApiService().hitHi(authToken: token!);
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
        result = await loginSignupUsecase.storeUserInfo(
            name: event.name,
            email: event.email,
            password: event.password,
            uid: FirebaseAuth.instance.currentUser!.uid);
        if (result == "User data stored successfully!") {
          result = "User Register Successfully";
          emit(SignupSuccessState(message: result));
        } else {
          emit(SignupErrorState(error: result));
        }
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
          User fUser = FirebaseAuth.instance.currentUser!;
          await local.setFirebaseUid(uid: fUser.uid);
          result = await loginSignupUsecase.storeUserInfo(
              name: fUser.displayName ?? "NA",
              email: fUser.email ?? "NA",
              password: "",
              uid: FirebaseAuth.instance.currentUser!.uid);
          if (result == "User data stored successfully!") {
            result = "Google Login  Successful";
            emit(SignupSuccessState(message: result));
          } else {
            emit(SignupErrorState(error: result));
          }
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
