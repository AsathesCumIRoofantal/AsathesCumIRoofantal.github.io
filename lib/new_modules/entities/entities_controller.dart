import 'package:get/get.dart';
import '../../data/models/entity_model.dart';
import '../../data/providers/data_provider.dart';

class EntitiesController extends GetxController {
  var entities = <EntityModel>[].obs;
  var isLoading = true.obs;
  var isEntitiesExpanded = false.obs;
  var selectedCategory = "".obs;
  final List<String> categories = [
    'Living',
    'Non-Living',
    'Abstract',
    'Phenomena',
    'Digital',
  ];
  final DataProvider _dataProvider = DataProvider();

  @override
  void onInit() {
    super.onInit();
    loadEntities();
  }

  void loadEntities() async {
    try {
      isLoading(true);
      var result = await _dataProvider.getEntities();
      entities.assignAll(result);
    } finally {
      isLoading(false);
    }
  }

  void addEntity(EntityModel entity) {
    entities.insert(0, entity);
    isEntitiesExpanded.value = true;
    Get.back(); // Close modal
    Get.snackbar(
      'Success',
      '${entity.name} added to all-space.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primary.withValues(alpha: 0.1),
      colorText: Get.theme.colorScheme.primary,
    );
  }
}
