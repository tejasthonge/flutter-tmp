part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

class OnboardingActionState extends OnboardingState {}

class OnboardingLoadingState extends OnboardingState {}

class OnboardingSuccessState extends OnboardingState {}

class OnboardingErrorState extends OnboardingState {
  final String error;
  OnboardingErrorState({required this.error});
}

class SignupSuccessState extends OnboardingActionState {
  final String message;
  SignupSuccessState({required this.message});
}

class SignupErrorState extends OnboardingActionState {
  final String error;
  SignupErrorState({required this.error});
}

class LoginSuccessState extends OnboardingActionState {
  final String message;
  LoginSuccessState({required this.message});
}

class LoginErrorState extends OnboardingActionState {
  final String error;
  LoginErrorState({required this.error});
}
