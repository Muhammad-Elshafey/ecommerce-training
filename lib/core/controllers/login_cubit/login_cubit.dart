import 'package:ecommerce_trainning/core/controllers/login_cubit/login_states.dart';
import 'package:ecommerce_trainning/core/network/constants.dart';
import 'package:ecommerce_trainning/core/network/remote/dio_helper.dart';
import 'package:ecommerce_trainning/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  void userLogin({required email,required password}){
    emit(LoginLoadingState());
    DioHelperStore.postData(url: ApiConstants.loginApi, data:{
      "email":email,
      "password":password,
    }).then((value){
      userModel = UserModel.fromJson(value.data);
      print(userModel!.user!.name!);
      emit(LoginDoneState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(LoginFailedState());
    });
  }
}