import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/modules/products/products_screen.dart';
import 'package:shop/modules/search/cubit/search_cubit.dart';
import 'package:shop/modules/search/cubit/search_states.dart';
import 'package:super_banners/super_banners.dart';
import '../../shared/components/component.dart';
import '../../shared/styles/colors.dart';

class Search extends StatelessWidget {
var searchController=TextEditingController();
var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (BuildContext context,  state) {  },
        builder: (BuildContext context, state) {
         // var cubit= SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
               titleSpacing:0,
               title: Text('search')

            ),
            body:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                formField(
                    height: 20,
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    prefix: Icons.search,
                    label: "search",
                    validate: (String? value){
                      if(value!.isEmpty){
                        return 'enter text to search';
                      }
                      return null;
                    },
                    onSubmit: (String? value) {
                      if (formKey.currentState!.validate()) {
                        SearchCubit.get(context).search(text: value!);
                      }
                      }
                    ),
                    SizedBox(height: 10,),
                     if (state is SearchLoadingState) LinearProgressIndicator(),
                        const SizedBox(
                          height: 10,
                        ),
                         if (state is SearchSuccessState)
                      Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>searchItem(SearchCubit.get(context).model?.data.data[index], context),
                          separatorBuilder:(context,index)=> SizedBox(height: 10,),
                          itemCount: SearchCubit.get(context).model!.data.data.length),
                    ),
                  ],
                ),
              ),
            ),
          );
       },
   ),
    );
  }

// class Search extends StatelessWidget {
//   var searchController = TextEditingController();
//   var formKey = GlobalKey<FormState>();
//
//   Search({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SearchCubit(),
//       child: BlocConsumer<SearchCubit, SearchStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(),
//             body: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   children: [
//                     formField(
//                         controller: searchController,
//                         keyboardType: TextInputType.name,
//                         validate: (String? value) {
//                           if (value!.isEmpty) {
//                             return "Enter Text to Search";
//                           }
//                           return null;
//                         },
//                         label: "Search",
//                         prefix: Icons.search,
//                         onSubmit: (String? text) {
//                           SearchCubit.get(context).search(text: text!);
//                         }),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     if (state is SearchLoadingState) LinearProgressIndicator(),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     if (state is SearchSuccessState)
//                       Expanded(
//                         child: ListView.separated(
//                             physics: BouncingScrollPhysics(),
//                             itemBuilder: (context, index) => searchItem(
//                                 SearchCubit
//                                     .get(context)
//                                     .model!
//                                     .data
//                                     .data[index],
//                                 context,
//                                 ),
//                             separatorBuilder: (context, index) => Container(
//                               color: Colors.grey,
//                               width: 1,
//                               height: 1,
//                             ),
//                             itemCount: SearchCubit
//                                 .get(context)
//                                 .model!
//                                 .data
//                                 .data
//                                 .length),
//                       )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }


  Widget searchItem(ProductData? model,context)=>Padding(
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
                    image: NetworkImage('${model!.image}'),
                    width: 120,
                    height: 120,
                    fit: BoxFit.fill,
                  ),
                ),

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
                    '${model.name}',
                    maxLines:2,
                    overflow: TextOverflow.ellipsis,
                    // style: TextStyle(height: 1.1),
                  ),
                  Spacer(),
                  Container(
                    width:210,
                    child: Row(
                      children: [
                        Text(
                          '${model.price} LE',
                          style: TextStyle(height: 1, color: defaultColor(),
                            fontSize:12,),
                        ),

                      ],
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