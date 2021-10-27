abstract class ShopLoginScreenStates {}

class ShopLoginInitialState extends ShopLoginScreenStates {}

class ShopLoginLoadingState extends ShopLoginScreenStates {}

class ShopLoginSuccessState extends ShopLoginScreenStates {}

class ShopLoginErrorState extends ShopLoginScreenStates {
  final String error;

  ShopLoginErrorState(this.error);
}


class ShopLoginChangeVisibilityState extends ShopLoginScreenStates {}
