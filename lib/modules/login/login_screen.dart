import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/styles/colors.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../layout/home_layout.dart';
import '../../shared/components/component.dart';
import '../../shared/network/remote/cash_helper.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
      if (state is LoginSuccessState) {
        if (state.loginModel!.status) {
          CashHelper.saveData(
                  key: 'token', value: state.loginModel!.data!.token
          ).then((value) {
             token=state.loginModel!.data!.token!;
             ShopCubit.get(context).getFavorites();
             ShopCubit.get(context).getUserData();
            navigatAndFinish(context, HomeLayout());
          });
        } else {
          print(state.loginModel?.message);
          Fluttertoast.showToast(
              msg: state.loginModel!.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5,
              backgroundColor: defaultColor(),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }, builder: (context, state) {
      return Scaffold(
          body: Padding(
              padding: const EdgeInsets.all( 20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Spacer(flex: 4,),
                    const Text(
                      "WELCOME BACK ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Image(
                      image: AssetImage('assets/images/login.jpg'),
                      width: 200,
                      height: 200,
                    ),
                    formField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefix: Icons.email_outlined,
                        label: "Email Address",
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Email";
                          }
                        }),
                    const Spacer(),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    formField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        prefix: Icons.lock_outline,
                        label: "password",
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        isPassword: ShopCubit.get(context).isPassword,
                        suffix: ShopCubit.get(context).isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixPressed: () {
                          ShopCubit.get(context).obscurePassword();
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Password is Very Short";
                          }
                        }),
                    const Spacer(),

                    state is LoginLoadingState
                        ? const CircularProgressIndicator()
                        : button(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);

                              }
                            },
                            color: defaultColor(),
                            text: "LOGIN",
                            height: 45,
                            width: 270,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            navigatTo(context, SignUpScreen());
                          },
                          child: Text(
                            "Sign Up ",
                            style: TextStyle(
                              color: defaultColor(),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(flex: 8,),

                  ],
                ),
            )),
          );
    });
  }
}
