import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_app/cubit/cubit.dart';
import 'package:todo_app/layout/news_app/cubit/states.dart';
import 'package:todo_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  List list = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context, state) {},
      builder:(context, state) {
        var list = NewsCubit.get(context).search;
        
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  textEditingController: searchController,
                  textInputType: TextInputType.text,
                  labelText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  onChanged: (value) {
                    print('hello');
                    NewsCubit.get(context).getSearchData(value);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Search must not be empty';
                    }
                  },
                ),
              ),
              Expanded(
                child: articleBuilder(list, context),
              ),
            ],
          ),
        );
      },
    );
  }
}
