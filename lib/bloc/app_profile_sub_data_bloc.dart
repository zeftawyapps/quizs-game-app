import 'package:islamic_quizs_game/models/game_dep_model.dart';
import 'package:users_module/bloc/base_bloc/base_bloc.dart';
import 'package:users_module/reposetory/profile_sub_data_repo.dart';
import 'package:users_module/source/prfile_sub_data.dart';
import 'package:users_module/utilis/shardeprefrance/user_data_stored.dart';



class AppProfileSubDataBloc {


  UserModuleBaseBloc<List<GameDepModel>> userModuleBaseBloc =
  UserModuleBaseBloc<List<GameDepModel>>();
 void getSource( ) async {
   String uid = UserDataStored().getUserData()?.uid ?? "";
   ProfileSubDataRebo accountSource = ProfileSubDataRebo((UserProfileFirebaseSubDataActions()));
    userModuleBaseBloc.loadingState();
    var result = await accountSource.getProfileSubData(   subCollection: "depGamrResult" , docId: uid);
    result.pick(onData: (v) {
      GameDepModel gameDepModel = GameDepModel();
      userModuleBaseBloc.successState( gameDepModel.toList(v) );
    }, onError: (error) {
      userModuleBaseBloc.failedState(error, () {});
    });
 }
}
