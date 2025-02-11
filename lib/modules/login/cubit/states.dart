abstract class SocialLoginStates{}

class SocialLoginInitialState extends SocialLoginStates {}

class OnLoadingLogin extends SocialLoginStates {}

class LoginSuccessful extends SocialLoginStates {
  final String uId;
  LoginSuccessful(this.uId);
}

class LoginError extends SocialLoginStates {
  final String error;
  LoginError(this.error);
}

class SocialChangeLoginPasswordVisibilityState extends SocialLoginStates {}

class SocialOnLoadingGetUserState extends SocialLoginStates{}

class SocialGetUserSuccessState extends SocialLoginStates{}

class SocialGetUserErrorState extends SocialLoginStates{}

class SocialRegisterOnLoadingState extends SocialLoginStates{}

class SocialRegisterErrorState extends SocialLoginStates{
  final String error;
  SocialRegisterErrorState(this.error);
}
class SocialUserCreateSuccessState extends SocialLoginStates{
  final String uId;
  SocialUserCreateSuccessState(this.uId);
}

class SocialUserCreateErrorState extends SocialLoginStates{
  final String error;
  SocialUserCreateErrorState(this.error);
}

class OnLoadingCreateUserState extends SocialLoginStates{}








