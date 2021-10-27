abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class ChangeNewsBottomNavIndexState extends NewsStates {}

////////////////////////////Business //////////////////////////////
class NewsGetBusinessLoadingsState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

////////////////////////////  Science //////////////////////////////
class NewsGetScienceLoadingsState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final String error;

  NewsGetScienceErrorState(this.error);
}

///////////////////////////// Sports ////////////////////////////
class NewsGetSportsLoadingsState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String error;

  NewsGetSportsErrorState(this.error);
}

//////////////////////////////  Search  ////////////////////////////
class NewsGetSearchLoadingsState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final String error;

  NewsGetSearchErrorState(this.error);
}
