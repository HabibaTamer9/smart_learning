abstract class SignupState{}

class SignupInitial extends SignupState{}
class SignupLoading extends SignupState{}
class SignupSuccess extends SignupState{}
class SignupEmailNotVerified extends SignupState{}
class SignupError extends SignupState{
  final String errorMessage;
  SignupError(this.errorMessage);
}