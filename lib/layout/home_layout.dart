import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/search/search_screen.dart';
import '../shared/components/component.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
    builder: (context,state) {
      var cubit=ShopCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          leading:  Icon(Icons.shopping_basket
          ),
          title: Text('salla',
          ),
          actions: [
            IconButton(onPressed: (){
              navigatTo(context, Search());
            }, icon: Icon(
              Icons.search,
            )),

          ],
        ),
        body:cubit.screens[cubit.currentState],
        bottomNavigationBar: BottomNavigationBar(
          type:BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          currentIndex:cubit.currentState ,
          onTap:(index){ cubit.changeBottomNavBar(index);},
          items: [
            BottomNavigationBarItem(
                icon:Icon(Icons.home),
                label: "Home"
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.dashboard),
                label: "Categorise"
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.favorite),
                label: "Favorites"
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.person),
                label: "Profile"
            ),
          ],

        ),
      );
    }
    );
  }
}
