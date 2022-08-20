abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppChangeBottomNavabBarState extends AppStates{}

class IotGetUserInitialStates extends AppStates {}

class IotGetUserLoadingStates extends AppStates {}

class IotGetUserSuccessStates extends AppStates {}

class IotGetUserErrorStates extends AppStates {
  final String error;

  IotGetUserErrorStates(this.error);
}
class CounterInitialState extends AppStates{}

class CounterPlusState extends AppStates{}

class CounterMinisState extends AppStates{}

class IotProfileImagePickedSuccessState extends AppStates {}

class IotProfileImagePickedErrorState extends AppStates {}

class IotCoverImagePickedSuccessState extends AppStates {}

class IotCoverImagePickedErrorState extends AppStates {}

class IotUploadProfileImageSuccessState extends AppStates {}

class IotUploadProfileImageErrorState extends AppStates {}

class IotUploadCoverImageSuccessState extends AppStates {}

class IotUploadCoverImageErrorState extends AppStates {}

class IotUserUpdateErrorState extends AppStates {}

class IotUserUpdateLoadingState extends AppStates {}
