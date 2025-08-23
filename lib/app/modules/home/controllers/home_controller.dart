import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resolar_web/app/api_client.dart';
import 'package:resolar_web/app/core/utils/app_utils.dart';
import 'package:resolar_web/app/models/subject.dart';
import 'package:resolar_web/app/models/web_page.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  final askController = TextEditingController();
  final newTopicController = TextEditingController();

  final RxList<Subject> _subjectList = RxList();
  List<Subject> get subjectList => _subjectList.value;

  final RxList<WebPage> _pages = RxList();
  List<WebPage> get pages => _pages.value;

  final Rxn<Subject> _selectedSubject = Rxn();
  Subject? get selectedSubject => _selectedSubject.value;

  final RxBool _isTopicNameValid = RxBool(false);
  bool get isTopicNameValid => _isTopicNameValid.value;

  @override
  void onInit() {
    super.onInit();
    _fetchSubjects();
    newTopicController.addListener(() {
      _isTopicNameValid.value = newTopicController.text.isNotEmpty;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    askController.dispose();
    newTopicController.dispose();
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

  Future<void> _fetchPages(int subjectId) async {
    RequestResult reqRet = await Get.find<ApiClient>().getPages(subjectId);
    if (reqRet is RequestFail) {
      AppUtils.showSnackBar('Failed to load pages');
      return;
    }

    RequestSuccess<List<WebPage>> success =
        reqRet as RequestSuccess<List<WebPage>>;
    _pages.assignAll(success.data);
  }

  Future<void> selectSubject(Subject sub) async {
    _selectedSubject.value = sub;
    await _fetchPages(sub.id);
  }

  Future<void> createNewTopic() async {
    final topicName = newTopicController.text.trim();
    if (topicName.isEmpty) return;

    RequestResult reqRet = await Get.find<ApiClient>().createSubject(topicName);
    if (reqRet is RequestFail) {
      AppUtils.showSnackBar('Failed to create topic');
      return;
    }

    RequestSuccess<Subject> success = reqRet as RequestSuccess<Subject>;
    _subjectList.add(success.data);
    newTopicController.clear();
    selectSubject(success.data);
  }
}
