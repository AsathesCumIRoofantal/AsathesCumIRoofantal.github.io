import 'package:get/get.dart';
import '../../data/models/union_model.dart';
import '../../data/providers/data_provider.dart';

class UnionsController extends GetxController {
  var unions = <UnionModel>[].obs;
  var isLoading = true.obs;
  var isUnionsExpanded = false.obs;
  var selectedCategory = "".obs;
  var selectedEntities = <String>[].obs;
  final List<String> categories = [
    'Pairs',
    'Groups',
    'Organisations',
    'Conceptual',
  ];
  final DataProvider _dataProvider = DataProvider();

  @override
  void onInit() {
    super.onInit();
    loadUnions();
  }

  void loadUnions() async {
    try {
      isLoading(true);
      var result = await _dataProvider.getUnions();
      unions.assignAll(result);
    } finally {
      isLoading(false);
    }
  }

  void addUnion(UnionModel union) {
    unions.insert(0, union);
    isUnionsExpanded.value = true;
    Get.back(); // Close modal
    Get.snackbar(
      'Success',
      '${union.name} added to all-space.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.secondary.withValues(alpha: 0.1),
      colorText: Get.theme.colorScheme.secondary,
    );
  }
}
