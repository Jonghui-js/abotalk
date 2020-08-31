import 'package:abotalk/redux/Actions.dart';
import 'package:abotalk/redux/AppState.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is CheckAuth) {
    //newState.isAuth = action.payload;
  } else if (action is CheckMsg) {
    newState.msg = action.msg;
  } else if (action is SetCurrentPost) {
    newState.currentPost = action.currentPost;
  }
  return newState;
}
