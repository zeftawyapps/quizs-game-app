

import 'package:quiz_module/bloc/base_bloc/base_bloc.dart';
import 'package:quiz_module/interface/sources/dep/i_dep_http_source.dart';
import 'package:quiz_module/medules_test.dart';
import 'package:quiz_module/model/depratment.dart';
import 'package:quiz_module/reposetory/quiz_firebase_repo.dart';
import 'package:quiz_module/source/department_firebase_source.dart';
import 'package:quiz_module/source/https/dep_http_source.dart';
import 'package:quiz_module/utilis/models/base_data_model.dart';
import 'package:quiz_module/utilis/models/base_model.dart';

class AppDepBloc {
  String depNamekey = "depName";
  QuizModuleBaseBloc<RemoteBaseModel> blocHttp =
  QuizModuleBaseBloc<RemoteBaseModel>();
  QuizModuleBaseBloc<DepartmentBaseModel> bloc =
      QuizModuleBaseBloc<DepartmentBaseModel>();
  QuizModuleBaseBloc<List<DepartmentBaseModel>> bloclist =
      QuizModuleBaseBloc<List<DepartmentBaseModel>>();

  QuizRepo? quizRepo;


  void getDepartment() async {
    quizRepo = QuizRepo(inputSource: DepartmentFirebaseSource());
    bloclist.loadingState();
    var result = await quizRepo!.getData((query) => query.orderBy("sort").where("isPublish",isEqualTo: true) );
    result.pick(onData: (v) {
      bloclist.successState(v  as List<DepartmentBaseModel>);
    }, onError: (error) {
      bloclist.failedState(error, () {});
    });
  }

  void setDepGameResult(String depId , int score , int currectAnseowr ,
      int wrongAnswer , int totalQuestion , int depLevel , int mony

      )async{
    quizRepo = QuizRepo(depHttpSoucre: QuizGameHttpSource());
    blocHttp.loadingState();
    var result = await  quizRepo!.setGameResult(depId:depId , score: score , currectAnswer: currectAnseowr);
    result.pick(onData: (v) {
      blocHttp.successState(v  as RemoteBaseModel);
    }, onError: (error) {
      blocHttp.failedState(error, () {});
    });
  }
}
