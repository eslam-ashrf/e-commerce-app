import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/layout/cubit/states.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/home_layout.dart';
import '../../shared/components/component.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/remote/cash_helper.dart';
import '../../shared/styles/colors.dart';

class SignUpScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {
        if (state is RegisterSuccessState) {
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

      },
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            leading:IconButton(onPressed: () {Navigator.pop(context); }, icon:Icon( Icons.arrow_back_ios_new,
            color: defaultColor(),)),
            backgroundColor: Colors.white,
          ),
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Spacer(
                      flex: 4,
                    ),
                    const Text(
                      "Sign Up ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Fill ditails & creat account',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Spacer(),
                    formField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        prefix: Icons.person,
                        label: 'user name',
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your name";
                          }
                        }),
                    Spacer(),
                    formField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        prefix: Icons.phone,
                        label: 'phone number',
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your phone";
                          }
                        }),
                    Spacer(),
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
                            ShopCubit.get(context).register(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text);
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

                     state is RegisterLoadingState
                        ? const CircularProgressIndicator():
                    button(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).register(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text);
                        }
                      },
                      color: defaultColor(),
                      text: "SIGNUP",
                      height: 45,
                      width: 270,
                    ),
                    const Spacer(
                      flex: 8,
                    ),
                  ],
                ),
              )),
        );
      },



    );
  }
}
