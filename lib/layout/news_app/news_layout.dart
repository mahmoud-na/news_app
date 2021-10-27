import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/news_app/search/search_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        if(state is NewsGetBusinessErrorState){
          print("Error");
        }
      },
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context,SearchScreen(),);

                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeAppThemeMode();
                },
                icon: const Icon(
                  Icons.dark_mode,
                ),
              ),
            ],
          ),
          body: cubit.newsAppScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavBarList,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBarIndex(index);
            },
          ),
        );
      },
    );
  }
}
