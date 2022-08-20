abstract class IotRegisterStates {}

class IotRegisterInitialStates extends IotRegisterStates {}

class IotRegisterLoadingStates extends IotRegisterStates {}

class IotRegisterSuccessStates extends IotRegisterStates {}

class IotRegisterChangePasswordVisibilityStates
    extends IotRegisterStates {}

class IotRegisterFailStates extends IotRegisterStates {
  final String error;

  IotRegisterFailStates(this.error);
}

class IotCreateUserSuccessStates extends IotRegisterStates {}

class IotCreateUserFailStates extends IotRegisterStates {
  final String error;

  IotCreateUserFailStates(this.error);
}
