import 'package:get/get.dart';
import '../../data/models/learning_doc_model.dart';
import '../../data/providers/data_provider.dart';

class CategoryDocsController extends GetxController {
  final categoryId = Get.arguments?['categoryId'] ?? '';
  final title = Get.arguments?['title'] ?? 'Category';

  var docs = <LearningDocModel>[].obs;
  var filteredDocs = <LearningDocModel>[].obs;
  var isLoading = true.obs;

  var currentFilter = 'All'.obs;
  var filterTypes = ['All', 'Class 8', 'Class 10', 'PDF', 'Image'].obs;

  final DataProvider _dataProvider = DataProvider();

  @override
  void onInit() {
    super.onInit();
    loadDocs();
  }

  void loadDocs() async {
    try {
      isLoading(true);
      var result = await _dataProvider.getLearningDocs();
      docs.assignAll(result.where((d) => d.categoryId == categoryId).toList());
      filteredDocs.assignAll(docs);

      // dynamically generate filters based on available docs
      Set<String> dynamicFilters = {'All'};
      for (var d in docs) {
        if (d.classCategory != 'All') dynamicFilters.add(d.classCategory);
        dynamicFilters.add(d.type);
      }
      filterTypes.assignAll(dynamicFilters.toList());
    } finally {
      isLoading(false);
    }
  }

  void applyFilter(String filter) {
    currentFilter.value = filter;
    if (filter == 'All') {
      filteredDocs.assignAll(docs);
    } else {
      filteredDocs.assignAll(
        docs
            .where(
              (d) =>
                  d.classCategory == filter ||
                  d.type == filter ||
                  d.targetAge == filter,
            )
            .toList(),
      );
    }
  }
}
