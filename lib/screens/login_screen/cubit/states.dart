abstract class IotLoginStates {}

class IotLoginInitialStates extends IotLoginStates {}

class IotLoginLoadingStates extends IotLoginStates {}

class IotLoginSuccessStates extends IotLoginStates {
  late final String uId;
  IotLoginSuccessStates(this.uId);
}

class IotLoginFailStates extends IotLoginStates {
  final String error;

  IotLoginFailStates(this.error);
}

class IotChangePasswordVisibilityStates extends IotLoginStates {}


