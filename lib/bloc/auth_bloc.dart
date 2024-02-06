import 'package:users_module/bloc/base_bloc/base_bloc.dart';
import 'package:users_module/modele/base_model/inhertid_models/user_model.dart';
import 'package:users_module/reposetory/auth_repo.dart';
import 'package:users_module/source/accountLoginLogout/auth_email_source.dart';
import 'package:users_module/utilis/shardeprefrance/shard_check.dart';

import '../models/user_model.dart';


class AuthBloc {
  String emailKey = "email";
  String nameKey = "name";
  String passKey = "pass";

  UserModuleBaseBloc<AppuserModel> userModuleBaseBloc =
      UserModuleBaseBloc<AppuserModel>();

  void signUp({required Map<String, dynamic> map}) async {
    AuthRepo accountSource = AuthRepo( EmailPassowrdAuthSource(email: map[emailKey], pass: map[passKey]));
    userModuleBaseBloc.loadingState();
    var result = await accountSource.createAccountAndProfile(

        UserModule (phone: "56456", address: "sadfsdf", name:  "admin"));
    result.pick(onData: (v) {

      userModuleBaseBloc.successState(  AppuserModel.formJson(v.map));
    }, onError: (error) {
      userModuleBaseBloc.failedState(error, () {});
    });
  }

  void logIn({required Map<String, dynamic> map}) async {
    AuthRepo accountSource = AuthRepo(EmailPassowrdAuthSource(email: map[emailKey], pass: map[passKey]));
    userModuleBaseBloc.loadingState();
    var result = await accountSource.logIn();
    result.pick(onData: (v) {
 SharedPrefranceChecking sharedPrefranceChecking =  SharedPrefranceChecking();
 sharedPrefranceChecking.setDataInShardRefrace(    email: v.email! , pass: map[passKey]!
 , token: v.token!
 );
      userModuleBaseBloc.successState( AppuserModel.formJson(v.toJson()));
    }, onError: (error) {
      userModuleBaseBloc.failedState(error, () {});
    });
  }

}
