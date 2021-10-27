import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/shop_app/login/cubit/states.dart';
import 'package:todo_app/shared/network/end_points.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginScreenStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      emit(ShopLoginSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  bool isPasswordVisible = true;
  void changePasswordVisibilityState() {
    isPasswordVisible = !isPasswordVisible;
    emit(ShopLoginChangeVisibilityState());
  }
}
