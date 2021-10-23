import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter/modules/news_app/business/business_screen.dart';
import 'package:udemy_flutter/modules/news_app/science/science_screen.dart';
import 'package:udemy_flutter/modules/news_app/sports/sports_screen.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems =[
    BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports),
        label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'Science'
    ),
    // BottomNavigationBarItem(
    //     icon: Icon(Icons.settings),
    //     label: 'Settings'
    // ),
  ];

  List<Widget> screens =[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    //SettingsScreen(),
  ];
  void changeBottomNavBar (int index){
    currentIndex=index;
    // if(index==1)
    //   getSports();
    // if(index==2)
    //   getScience();
    emit(NewsBottomNavState());
  }

  List< dynamic> business=[];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url:'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'e30e08f72267497a8fc86c06784fb446',
      },).then((value) {
      business= value.data['articles'];
      //print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());

    } ).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorsState(error.toString()));
    });
  }

  List< dynamic> sports=[];
  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(sports.length == 0){
      DioHelper.getData(url:'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'e30e08f72267497a8fc86c06784fb446',
        },).then((value) {
        sports= value.data['articles'];
        //print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());

      } ).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorsState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }


  }

  List< dynamic> science=[];
  void getScience(){
    if(science.length == 0){
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(url:'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'e30e08f72267497a8fc86c06784fb446',
        },).then((value) {
        science= value.data['articles'];
       // print(science[0]['title']);
        emit(NewsGetScienceSuccessState());

      } ).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorsState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }

  List< dynamic> search=[];
  void getSearch(String value){
    emit(NewsGetSearchLoadingState());

    search=[];

    DioHelper.getData(url:'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'e30e08f72267497a8fc86c06784fb446',
      },).then((value) {
      search= value.data['articles'];
      // print(science[0]['title']);
      emit(NewsGetSearchSuccessState());

    } ).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorsState(error.toString()));
    });

  }

}