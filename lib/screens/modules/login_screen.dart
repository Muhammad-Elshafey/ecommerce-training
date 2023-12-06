import 'package:ecommerce_trainning/core/controllers/login_cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/controllers/login_cubit/login_cubit.dart';
import '../../core/managers/nav.dart';
import '../../core/managers/values.dart';
import '../../core/network/local/cache_helper.dart';
import '../widgets/botton.dart';
import '../widgets/text_form.dart';
import 'product_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit , LoginStates>(
      listener:(context, state) {
        if (state is LoginDoneState) {
          if (state.userModel.status == "success") {
            print(state.userModel.message);
            //showToast(state.userModel.message!, ToastStates.SUCCESS);
            print(state.userModel.user!.token);
            CacheHelper.saveData(
                key: 'userId', value: state.userModel.user!.nationalId)
                .then((value) {
              natoinalId = state.userModel.user!.nationalId;
            });
            CacheHelper.saveData(
              key: 'token',
              value: state.userModel.user!.token,
            ).then((value) {
              token = state.userModel.user!.token!;
              navigateAndFinishThisScreen(
                context,
                const ProductScreen(),
              );
            });
          } else {
            print(state.userModel.message);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DefaultFieldForm(
                  labelStyle: const TextStyle(color: Colors.black),
                  controller: emailController,
                  keyboard: TextInputType.emailAddress,
                  valid: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter your Email';
                    }
                    return null;
                  },
                  label: 'Email Address',
                  prefix: Icons.email,
                  hint: 'Email Address',
                  hintStyle: const TextStyle(color: Colors.grey),
                  show: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                DefaultFieldForm(
                  labelStyle: const TextStyle(color: Colors.black),
                  controller: passwordController,
                  keyboard: TextInputType.visiblePassword,
                  valid: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return null;
                  },
                  label: 'Password',
                  prefix: Icons.password,
                  hint: 'Password',
                  hintStyle: const TextStyle(color: Colors.grey),
                  show: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                DefaultButton(
                  function: () {
                    if (formKey.currentState!.validate()) {
                      cubit.userLogin(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  },
                  buttonWidget:const Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
