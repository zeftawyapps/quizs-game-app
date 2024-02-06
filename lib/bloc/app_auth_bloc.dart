import 'package:quiz_module/https/commerce_http_urls.dart';
import 'package:users_module/bloc/base_bloc/base_bloc.dart';
import 'package:users_module/modele/base_model/inhertid_models/user_model.dart';
import 'package:users_module/reposetory/auth_repo.dart';
import 'package:users_module/reposetory/profile_repo.dart';
import 'package:users_module/source/accountLoginLogout/auth_email_source.dart';
import 'package:users_module/source/accountLoginLogout/auth_google_source.dart';
import 'package:users_module/source/account_actions.dart';
import 'package:users_module/utilis/shardeprefrance/shard_check.dart';

import '../models/user_model.dart';


class AppAuthBloc {
  String emailKey = "email";
  String nameKey = "name";
  String passKey = "pass";
// add singelton to bloc





  UserModuleBaseBloc<AppuserModel> userModuleBaseBloc =
  UserModuleBaseBloc<AppuserModel>();

  void signUp( ) async {
    // var source = EmailPassowrdAuthSource(email: "mm@dd.com", pass: "12345678" , name: "mohamed");
    var source = GoogleAuthSoucre();
    AuthRepo accountSource = AuthRepo(  source);
    userModuleBaseBloc.loadingState();
    var result = await accountSource.createAccount();
    result.pick(onData: (v) async{
      SharedPrefranceChecking sharedPrefranceChecking =  SharedPrefranceChecking();
   await    sharedPrefranceChecking.setDataInShardRefrace(  uid: v.uid!  , token:  v.token);

      QuizHttpHeader().setToken(v.token!) ;

      userModuleBaseBloc.successState(  AppuserModel.formJson(v.map));
    }, onError: (error) {
      userModuleBaseBloc.failedState(error, () {});
    });
  }

  void logIn({required Map<String, dynamic> map}) async {
    AuthRepo accountSource = AuthRepo(EmailPassowrdAuthSource(email: map[emailKey], pass: map[passKey]));
    userModuleBaseBloc.loadingState();
    var result = await accountSource.logIn();
    result.pick(onData: (v) async {
      SharedPrefranceChecking sharedPrefranceChecking =  SharedPrefranceChecking();
     await   sharedPrefranceChecking.setDataInShardRefrace(  uid: v.uid!, email: v.email! , pass: map[passKey]!);
      userModuleBaseBloc.successState( AppuserModel.formJson(v.toJson()));
    }, onError: (error) {
      userModuleBaseBloc.failedState(error, () {});
    });
  }
void getUserProfile( )async{
var accountSource = ProfilRebo(UserProfileFirebaseActions());
userModuleBaseBloc.loadingState();
 var result = await  accountSource.getProfile();
 result.pick(onData: (v) {
   userModuleBaseBloc.successState( AppuserModel.formJson(v.toJson()));
 }, onError: (error) {
   userModuleBaseBloc.failedState(error, () {});
 });
}


  void setUserProfile( int mony )async{
    Map<String , dynamic> map = {"mony" : mony};
    var accountSource = ProfilRebo(UserProfileFirebaseActions ( data: map));
    userModuleBaseBloc.loadingState();
    var result = await  accountSource.editProfile(map);
    result.pick(onData: (v) {
      userModuleBaseBloc.successState( AppuserModel.formJson(v.toJson()));
    }, onError: (error) {
      userModuleBaseBloc.failedState(error, () {});
    });
  }

}
