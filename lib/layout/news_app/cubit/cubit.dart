import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_app/cubit/states.dart';
import 'package:todo_app/modules/news_app/business/business_screen.dart';
import 'package:todo_app/modules/news_app/science/science_screen.dart';
import 'package:todo_app/modules/news_app/sports/sports_screen.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  List<BottomNavigationBarItem> bottomNavBarList = [
    const BottomNavigationBarItem(icon: Icon(Icons.business_center), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];
  List<Widget> newsAppScreens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];
  int currentIndex = 0;

  void changeBottomNavBarIndex(int index) {
    currentIndex = index;
    emit(ChangeNewsBottomNavIndexState());
  }

  List<dynamic> business = [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadingsState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'aa29a31083924d0d834cd6cf632653f8',
      },
    ).then((value) {
      print(value.data['articles'].toString());
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScienceData() {
    emit(NewsGetScienceLoadingsState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'aa29a31083924d0d834cd6cf632653f8',
      },
    ).then((value) {
      print(value.data['articles'].toString());
      science = value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSportsData() {
    emit(NewsGetSportsLoadingsState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'aa29a31083924d0d834cd6cf632653f8',
      },
    ).then((value) {
      print(value.data['articles'].toString());
      sports = value.data['articles'];
      print(sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  List<dynamic> search = [];

  void getSearchData(String value) {
    emit(NewsGetSearchLoadingsState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': 'aa29a31083924d0d834cd6cf632653f8',
      },
    ).then((value) {
      print(value.data['articles'].toString());
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
