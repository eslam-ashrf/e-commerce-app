import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_banners/super_banners.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/favorite_model.dart';
import '../../shared/styles/colors.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){} ,
        builder:(context,state) {
        return  state is ShopLoadingFavoritesState ? Center(
              child: CircularProgressIndicator()) :
          ListView.separated(itemBuilder: (context, index) =>
              favItem(ShopCubit
                  .get(context)
                  .favoriteModel
                  ?.data
                  ?.favData![index], context),
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              itemCount: ShopCubit
                  .get(context)
                  .favoriteModel!
                  .data!
                  .favData!
                  .length);
        });
  }
  Widget favItem(FavData? model,context)=>Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      // padding: EdgeInsetsDirectional.all(5),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.deepPurple[100],
        borderRadius:BorderRadius.circular(20) ,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:BorderRadius.circular(18) ,
                  child: Image(
                    image: NetworkImage('${model!.product!.image}'),
                    width: 120,
                    height: 120,
                    fit: BoxFit.fill,
                  ),
                ),
                 if(model.product!.discount!=0)
                CornerBanner(
                  bannerPosition: CornerBannerPosition.topLeft,
                  bannerColor: Colors.deepPurple,
                  child: Text( '${model.product!.discount}off!!',
                    style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 12, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.product!.name}',
                      maxLines:2,
                      overflow: TextOverflow.ellipsis,
                     // style: TextStyle(height: 1.1),
                    ),
                    Spacer(),
                    Container(
                      width:210,
                      child: Row(
                        children: [
                          if(model.product!.discount!=0)
                          Text(
                            '${model.product!.oldPrice}',
                            style: TextStyle(
                                fontSize:10,
                                height: 1, decoration: TextDecoration.lineThrough),
                          ),
                          SizedBox(width: 3,),
                          Text(
                            '${model.product!.price} LE',
                            style: TextStyle(height: 1, color: defaultColor(),
                              fontSize:12,),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFavoretes(model.product!.id!);
                            },
                            icon: CircleAvatar(
                              radius: 13,
                              backgroundColor: defaultColor() ,
                              child: Icon(Icons.favorite,
                                color:ShopCubit.get(context).favorite[model.product!.id]!?Colors.purpleAccent:
                                Colors.white,
                                size: 17,),
                            ),
                          ),                  ],
                      ),
                    ),
                  ],
                ),
              
            ),
          ),
        ],
      ),
    ),
  );
}