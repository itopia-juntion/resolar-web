import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resolar_web/app/api_client.dart';
import 'package:resolar_web/app/core/utils/app_utils.dart';
import 'package:resolar_web/app/models/subject.dart';
import 'package:resolar_web/app/models/web_page.dart';
import 'package:universal_html/html.dart' as html;

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

  final _searchQuery = ''.obs;

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  final RxBool _isGeneratingPdf = RxBool(false);
  bool get isGeneratingPdf => _isGeneratingPdf.value;

  @override
  void onInit() {
    super.onInit();
    _fetchSubjects();
    newTopicController.addListener(() {
      _isTopicNameValid.value = newTopicController.text.isNotEmpty;
    });

    searchController.addListener(() {
      _searchQuery.value = searchController.text;
    });

    debounce(
      _searchQuery,
      (_) => searchPages(),
      time: const Duration(milliseconds: 100),
    );
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
    searchController.clear();
    await _fetchPages(sub.id);
  }

  Future<void> createNewTopic() async {
    final topicName = newTopicController.text.trim();
    if (topicName.isEmpty) return;

    if (_subjectList
        .where((s) => s.name.toLowerCase() == topicName.toLowerCase())
        .toList()
        .isNotEmpty) {
      AppUtils.showSnackBar('Topic already exists');
      return;
    }

    newTopicController.clear();

    RequestResult reqRet = await Get.find<ApiClient>().createSubject(topicName);
    if (reqRet is RequestFail) {
      AppUtils.showSnackBar('Failed to create topic');
      return;
    }

    await _fetchSubjects();
    if (_subjectList.isNotEmpty) selectSubject(_subjectList.first);
  }

  Future<void> deleteSubject(Subject subject) async {
    RequestResult reqRet = await Get.find<ApiClient>().deleteSubject(
      subject.id,
    );
    if (reqRet is RequestFail) {
      AppUtils.showSnackBar('Failed to delete subject');
      return;
    }

    if (_selectedSubject.value == subject) {
      _selectedSubject.value = null;
      _pages.clear();
    }

    await _fetchSubjects();

    if (_selectedSubject.value == null && _subjectList.isNotEmpty) {
      selectSubject(_subjectList.first);
    }
  }

  Future<void> searchPages() async {
    final keyword = searchController.text.trim();
    final subject = _selectedSubject.value;

    if (subject == null) {
      // This case should ideally not happen if a subject is always selected.
      return;
    }

    if (keyword.isEmpty) {
      await _fetchPages(subject.id);
      return;
    }

    RequestResult reqRet = await Get.find<ApiClient>().searchPages(
      keyword,
      subject.id,
    );
    if (reqRet is RequestFail) {
      AppUtils.showSnackBar('Failed to search pages');
      return;
    }

    RequestSuccess<List<WebPage>> success =
        reqRet as RequestSuccess<List<WebPage>>;
    _pages.assignAll(success.data);
  }

  Future<void> searchAiPages() async {
    try {
      _isLoading.value = true;
      final keyword = askController.text.trim();
      final subject = _selectedSubject.value;

      pages.clear();
      askController.clear();

      if (subject == null) {
        return;
      }

      if (keyword.isEmpty) {
        return;
      }

      RequestResult reqRet = await Get.find<ApiClient>().searchAi(
        keyword,
        subject.id,
      );

      if (reqRet is RequestFail) {
        AppUtils.showSnackBar('Failed to search pages');
        return;
      }

      RequestSuccess<WebPage> success = reqRet as RequestSuccess<WebPage>;
      _pages.clear();
      _pages.add(success.data);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> generateAndDownloadPdf() async {
    if (_selectedSubject.value == null) return;

    try {
      _isGeneratingPdf.value = true;
      final subject = _selectedSubject.value!;

      final result = await Get.find<ApiClient>().getSubjectSummary(subject.id);

      if (result is RequestSuccess) {
        final blob = html.Blob([
          (result as RequestSuccess).data,
        ], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute("download", "${subject.name}_summary.pdf")
          ..click();
        html.Url.revokeObjectUrl(url);
      } else if (result is RequestFail) {
        AppUtils.showSnackBar(result.reason);
      }
    } catch (e) {
      AppUtils.showSnackBar('Failed to generate PDF: $e');
    } finally {
      _isGeneratingPdf.value = false;
    }
  }
}
