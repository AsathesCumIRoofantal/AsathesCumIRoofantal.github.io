import 'package:get/get.dart';
import '../../data/models/entity_model.dart';
import '../../data/providers/data_provider.dart';

class EntitiesController extends GetxController {
  var entities = <EntityModel>[].obs;
  var isLoading = true.obs;
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
}
