import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resolar_web/app/api_client.dart';
import 'package:resolar_web/app/core/utils/app_utils.dart';
import 'package:resolar_web/app/models/subject.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  final askController = TextEditingController();

  final RxList<Subject> _subjectList = RxList();
  List<Subject> get subjectList => _subjectList.value;

  final Rxn<Subject> _selectedSubject = Rxn();
  Subject? get selectedSubject => _selectedSubject.value;

  @override
  void onInit() {
    super.onInit();
    _fetchSubjects();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    askController.dispose();
    super.onClose();
  }

  Future<void> _fetchSubjects() async {
    RequestResult reqRet = await Get.find<ApiClient>().getSubjects();
    if (reqRet is RequestFail) {
      AppUtils.showSnackBar('Failed to load subjects');
      return;
    }

    RequestSuccess success = reqRet as RequestSuccess;
    List<Subject> subjects = success.data;
    _subjectList.assignAll(subjects);

    if (subjects.isNotEmpty && _selectedSubject.value == null) {
      selectSubject(subjects[0]);
    }
  }

  Future<void> selectSubject(Subject sub) async {
    _selectedSubject.value = sub;
  }
}
