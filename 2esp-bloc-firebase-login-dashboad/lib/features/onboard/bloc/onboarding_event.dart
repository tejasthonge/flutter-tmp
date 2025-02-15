part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {}

class OnboardingInitialEvent extends OnboardingEvent{}
class OnboardingLoginBTNPressedEvent extends OnboardingEvent{
  final String email;
  final String password;
  OnboardingLoginBTNPressedEvent({
    required this.email,
    required this.password
  });
}

class OnboardingGoogleBTNPressedEvent extends OnboardingEvent{}
class OnboardingSignupBTNPressedEvent extends OnboardingEvent{
  final String name;
  final String email;
  final String password;
  OnboardingSignupBTNPressedEvent({
    required this.name,
    required this.email,
    required this.password
  });
}