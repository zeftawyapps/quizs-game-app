import 'dart:async';

import 'package:quiz_module/bloc/base_bloc/base_bloc.dart';
import 'package:quiz_module/medules_test.dart';
import 'package:quiz_module/model/depratment.dart';
import 'package:quiz_module/model/quiz_model.dart';
import 'package:quiz_module/reposetory/quiz_firebase_repo.dart';
import 'package:quiz_module/source/department_firebase_source.dart';
import 'package:quiz_module/source/https/dep_http_source.dart';
import 'package:quiz_module/utilis/models/base_data_model.dart';
import 'package:quiz_module/utilis/models/base_model.dart';

import '../models/dep_model.dart';

class DepBloc {
  String depNamekey = "depName";
  String depSortkey = "sort";
  String depMonykey = "mony";

  QuizModuleBaseBloc<DepartmentBaseModel> bloc =
      QuizModuleBaseBloc<DepartmentBaseModel>();
  QuizModuleBaseBloc<RemoteBaseModel> httpInputbloc =
      QuizModuleBaseBloc<RemoteBaseModel>();

  QuizModuleBaseBloc<List<DepartmentBaseModel>> bloclist =
      QuizModuleBaseBloc<List<DepartmentBaseModel>>();

  QuizRepo? quizRepo;
  void addDepartmentUseFireStore({required Map<String, dynamic> map}) async {
    quizRepo = QuizRepo(
        inputSource: DepartmentFirebaseSource.inputs(
            DepartmentBaseModel(depName: map["depName"])));
    bloc.loadingState();
    Timer(Duration(seconds: 1), () {
      bloc.successState(QuizDep.fromJson(map, "1"));
    });
    var result = await quizRepo!.addData();
    result.pick(onData: (v) {
      bloc.successState(QuizDep.fromJson(v.map, v.depId));
    }, onError: (error) {
      bloc.failedState(error, () {});
    });
  }

  void addDepartment({required Map<String, dynamic> map}) async {
    String name = map[depNamekey];
    quizRepo = QuizRepo(depHttpSoucre: QuizGameHttpSource());
    httpInputbloc.loadingState();

    var result = await quizRepo!.createDepartmant(name: name);
    result.pick(onData: (v) {
      httpInputbloc.successState(v);
    }, onError: (error) {
      httpInputbloc.failedState(error, () {});
    });
  }

  void publisDepartment({required bool ispublis, required String id}) async {
    quizRepo = QuizRepo(depHttpSoucre: QuizGameHttpSource());

    var result =
        await quizRepo!.publishDepartmant(depId: id, publish: ispublis);
    result.pick(onData: (v) {
      var data = v;
      httpInputbloc.successState(data);
    }, onError: (error) {
      httpInputbloc.failedState(error, () {});
    });
  }

// sort dep by specific number
  void sortDepartment(
      {required Map<String, dynamic> sortMap, required String id}) async {
    int sort = sortMap["sort"];
    quizRepo = QuizRepo(depHttpSoucre: QuizGameHttpSource());
    httpInputbloc.loadingState();
    var result = await quizRepo!.sortDepartmant(depId: id, sort: sort);
    result.pick(onData: (v) {
      var data = v;
      httpInputbloc.successState(data);
    }, onError: (error) {
      httpInputbloc.failedState(error, () {});
    });
  }

  void addMonyDepartment(
      {required Map<String, dynamic> monyMap, required String id}) async {
    int mony = monyMap["mony"];
    quizRepo = QuizRepo(depHttpSoucre: QuizGameHttpSource());
    httpInputbloc.loadingState();
    var result = await quizRepo!.monyDepartmant(depId: id, mony: mony);
    result.pick(onData: (v) {
      var data = v;
      httpInputbloc.successState(data);
    }, onError: (error) {
      httpInputbloc.failedState(error, () {});
    });
  }

  void editDepartment(
      {required Map<String, dynamic> map, required String id}) async {
    quizRepo = QuizRepo(
        inputSource: DepartmentFirebaseSource.inputs(
            DepartmentBaseModel(depName: map["depName"])));
    bloc.loadingState();
    Timer(Duration(seconds: 1), () {
      bloc.successState(QuizDep.fromJson(map, "1"));
    });
    var result = await quizRepo!.updateData(id);
    result.pick(onData: (v) {
      bloc.successState(QuizDep.fromJson(v.map, v.depId));
    }, onError: (error) {
      bloc.failedState(error, () {});
    });
  }

  void deleteDepartment({required String id}) async {
    quizRepo = QuizRepo(
        inputSource:
            DepartmentFirebaseSource.inputs(DepartmentBaseModel(depName: "")));
    bloc.loadingState();
    Timer(Duration(seconds: 5), () {
      bloc.successState(QuizDep(depName: "1"));
    });
    var result = await quizRepo!.deleteData(id);
    result.pick(onData: (v) {
      bloc.successState(QuizDep.fromJson(v.map, v.depId));
    }, onError: (error) {
      bloc.failedState(error, () {});
    });
  }

  void getDepartments() async {
    quizRepo = QuizRepo(inputSource: DepartmentFirebaseSource());
    bloclist.loadingState();
    // Timer(Duration(seconds: 5), () {
    //   bloclist.successState(DepartmentBaseModel(depName: "1"));});

      var result = await quizRepo!.getData(((query) => query.orderBy('sort', descending: false)));
    result.pick(onData: (v) {
      bloclist.successState(v as List<DepartmentBaseModel>);
    }, onError: (error) {
      bloclist.failedState(error, () {});
    });
  }

  void getDepartment(String id) async {
    quizRepo = QuizRepo(inputSource: DepartmentFirebaseSource());
    bloc.loadingState();
    // Timer(Duration(seconds: 5), () {
    //   bloclist.successState(DepartmentBaseModel(depName: "1"));});
    var result = await quizRepo!.getSingleData(id);
    result.pick(onData: (v) {
      var data = v;
      bloc.successState(QuizDep.fromJson(data, id));
    }, onError: (error) {
      bloc.failedState(error, () {});
    });
  }
}
