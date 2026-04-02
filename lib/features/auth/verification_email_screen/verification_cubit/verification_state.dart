abstract class VerificationState{}

class VerificationInitial extends VerificationState{}
class VerificationLoading extends VerificationState{}
class VerificationEmailSent extends VerificationState{}
class VerificationEmailNotVerified extends VerificationState{}
class VerificationEmailVerified extends VerificationState{}
class VerificationSuccess extends VerificationState{}
class VerificationError extends VerificationState{
  final String errorMessage;
  VerificationError(this.errorMessage);
}