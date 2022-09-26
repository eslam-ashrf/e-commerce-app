import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/main.dart';
import 'package:shop/shared/components/component.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/remote/cash_helper.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/styles/colors.dart';
import '../login/login_screen.dart';


class Profile extends StatelessWidget {
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){} ,
        builder:(context,state) {

         // nameController.text=ShopCubit.get(context).user!.data!.name!;
         // phoneController.text=ShopCubit.get(context).user!.data!.phone!;
         // emailController.text=ShopCubit.get(context).user!.data!.email!;

          return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              formField(controller: nameController, keyboardType:TextInputType.name, prefix: Icons.person, label: 'Name'),
              SizedBox(height: 30,),
              formField(controller: phoneController, keyboardType: TextInputType.phone, prefix:Icons.phone , label: 'Phone'),
              SizedBox(height: 30,),
              formField(controller: emailController, keyboardType: TextInputType.emailAddress, prefix: Icons.email_outlined, label: 'Email_Address'),
              SizedBox(height: 30,),
              button(onPressed: (){
                ShopCubit.get(context).logOut();
                navigatAndFinish(context, LoginScreen());
              },
                color: defaultColor(),
                height: 45,
                width: 270,
                text: 'LOGOUT',
              ),
            ],
          ),
        );
        }

    );
  }
}