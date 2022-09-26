import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/modules/search/cubit/search_states.dart';
import 'package:shop/shared/components/constants.dart';

import '../../../shared/network/end_points.dart';
import '../../../shared/network/local/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super (SearchInitState());
  static SearchCubit get(context)=>BlocProvider.of(context);
   SearchModel? model;
  void search({required String text}){
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH,
        token :token,
        data: {
      "text":text,
    }).then((value) {
      emit(SearchSuccessState());
      model=SearchModel.fromJson(value?.data);
    }).catchError((error){
      emit(SearchErrorState(error));
      print(error.toString());
    });
  }

}