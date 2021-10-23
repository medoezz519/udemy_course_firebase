abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorsState extends NewsStates {

  final String error;

  NewsGetBusinessErrorsState(this.error);

}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorsState extends NewsStates {

  final String error;

  NewsGetSportsErrorsState(this.error);

}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorsState extends NewsStates {

  final String error;

  NewsGetScienceErrorsState(this.error);

}

class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorsState extends NewsStates {

  final String error;

  NewsGetSearchErrorsState(this.error);

}