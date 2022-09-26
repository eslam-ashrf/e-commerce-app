import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/models/Home_model.dart';
import 'package:shop/shared/styles/colors.dart';
import 'package:super_banners/super_banners.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/categories_model.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if(state is ShopSuccessChangeFavoritesState){
            if(!state.model.status){
              Fluttertoast.showToast(
                  msg: state.model.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 5,
                  backgroundColor: defaultColor(),
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, state) {
          return ShopCubit.get(context).homeModel != null&&ShopCubit.get(context).categoriseModel!=null
              ? productBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriseModel,context)
              : Center(child: CircularProgressIndicator());
        });
  }
}

Widget productBuilder(HomeModel? model,CategoriseModel? cat,context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model?.data?.banners
                .map((e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
            )),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categorise',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 160,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder:(context,index)=>  categoriseItemBuilder(cat!.data!.data[index]),
                        separatorBuilder: (context,index)=>SizedBox(width: 20,),
                        itemCount: cat!.data!.data.length),
                  ),
                  SizedBox(height: 20,),
                  Text('New Products',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),)
                ],
              ),
              SizedBox(height: 10,),
              Container(
                color: Colors.white,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1 / 1.60,
                  children: List.generate(model!.data!.products.length,
                      (index) => ProductGridBuilder(model.data!.products[index],context)),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
Widget categoriseItemBuilder(DataModel cat)=>Container(
  padding: EdgeInsetsDirectional.all(10),
  decoration: BoxDecoration(
    color: Colors.deepPurple[100],
    borderRadius:BorderRadius.circular(15) ,
  ),
  width: 120,
  height: 160,
  child:   Column(
    children: [
      Container(
        width: 100,
        height: 100,
        child: CircleAvatar(
          backgroundImage:NetworkImage('${cat.image}'),
        ),
      ),
      SizedBox(height: 10,),
      Text('${cat.name}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),),
    ],
  ),
);
Widget ProductGridBuilder(ProductsModel model,context) {
  return  Container(
    padding: EdgeInsetsDirectional.all(3),
    decoration: BoxDecoration(
      color: Colors.deepPurple[100],
      borderRadius:BorderRadius.circular(20) ,
    ),
    child: Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius:BorderRadius.circular(18) ,
              child: Image(
                image: NetworkImage('${model.image}'),
                width: 180,
                height: 180,
                fit: BoxFit.fill,
              ),
            ),
            if(model.discount!=0)
            CornerBanner(
            bannerPosition: CornerBannerPosition.topLeft,
            bannerColor: Colors.deepPurple,
            child: Text( '${model.discount}% off !!',
            style: TextStyle(color: Colors.white),),
            )
          ],
        ),

        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(height: 1.1),
              ),
               Container(
                 width: 180,
                 child: Row(
                    children: [
                      if(model.discount!=0)
                        Text(
                          '${model.old_price} ',
                          style: TextStyle(
                              fontSize:10,
                              height: 1, decoration: TextDecoration.lineThrough),
                        ),
                      SizedBox(width: 3,),
                      Text(
                        '${model.price} LE',
                        style: TextStyle(height: 1, color: defaultColor(),
                          fontSize:12,),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavoretes(model.id!);
                        },
                        icon: CircleAvatar(
                          radius: 13,
                          backgroundColor: defaultColor() ,
                          child: Icon(Icons.favorite,
                          color:ShopCubit.get(context).favorite[model.id]!?Colors.purpleAccent: Colors.white,
                          size: 17,),
                        ),
                      ),                  ],
                  ),
               ),
            ],
          ),
        ),
      ],
    ),
  );
}
