import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController timeTextEditingController = TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();

  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: state is! AppGetLoadingDatabaseState
                ? cubit.appScreens[cubit.currentIndex]
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomBarItems,
              currentIndex: cubit.currentIndex,
              elevation: 30.0,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                cubit.changeIndex(value);
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: cubit.isBottomSheetShown
                  ? const Icon(Icons.add)
                  : const Icon(Icons.edit),
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit
                        .insertDatabase(
                      title: titleTextEditingController.text,
                      date: dateTextEditingController.text,
                      time: timeTextEditingController.text,
                    )
                        .then(
                      (value) {
                        titleTextEditingController.text = '';
                        timeTextEditingController.text = '';
                        dateTextEditingController.text = '';
                      },
                    );
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) {
                          return Container(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                              bottom: 20.0,
                              top: 40.0,
                            ),
                            color: Colors.grey[100],
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultFormField(
                                    textEditingController:
                                        titleTextEditingController,
                                    textInputType: TextInputType.text,
                                    labelText: 'Task Title',
                                    prefixIcon: const Icon(Icons.title),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Title must be not empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                    textEditingController:
                                        timeTextEditingController,
                                    textInputType: TextInputType.datetime,
                                    labelText: 'Task Time',
                                    prefixIcon: const Icon(Icons.access_time),
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then(
                                        (value) {
                                          timeTextEditingController.text =
                                              value!.format(context);
                                        },
                                      );
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Time must be not empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultFormField(
                                    textEditingController:
                                        dateTextEditingController,
                                    textInputType: TextInputType.datetime,
                                    labelText: 'Task Date',
                                    prefixIcon: const Icon(Icons.date_range),
                                    enableInteractiveSelection: false,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2021-12-31'),
                                      ).then(
                                        (value) {
                                          dateTextEditingController.text =
                                              DateFormat.yMMMd().format(value!);
                                        },
                                      );
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Date must be not empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) {
                        cubit.changeBottomSheetState(isShow: false);
                      });
                  cubit.changeBottomSheetState(isShow: true);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
