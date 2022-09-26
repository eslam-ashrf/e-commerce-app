import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/shared/styles/colors.dart';

class Categorise extends StatelessWidget {
  const Categorise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){} ,
      builder:(context,state)=>ShopCubit.get(context).categoriseModel!=null?
       Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView.separated(itemBuilder: (context,index)=>categoriseListBuilder(ShopCubit.get(context).categoriseModel!.data!.data[index]),
            separatorBuilder: (context,index)=>SizedBox(height: 30,), itemCount: ShopCubit.get(context).categoriseModel!.data!.data.length),
      ):CircularProgressIndicator()
    );
  }
  Widget categoriseListBuilder(DataModel? data)=>Stack(
    alignment:AlignmentDirectional.center,
    children: [
      Container(
        padding: EdgeInsetsDirectional.all(4),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(22) ,
          color:  defaultColor()
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            image: NetworkImage(
              "${data?.image}"
            ),
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Text('${data?.name}',
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25,
            color:Colors.white
        ),)
    ],
  );
}
