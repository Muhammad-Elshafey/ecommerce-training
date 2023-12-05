import '../../../models/user_model.dart';

abstract class LoginStates{}
class LoginInitState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginDoneState extends LoginStates{
  final UserModel userModel;
  LoginDoneState(this.userModel);
}
class LoginFailedState extends LoginStates{}