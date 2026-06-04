import 'package:get/get.dart';
import '../../data/models/learning_menu_model.dart';
import '../../data/providers/data_provider.dart';

class LearnFunController extends GetxController {
  var menus = <LearningMenuModel>[].obs;
  var isLoading = true.obs;
  final DataProvider _dataProvider = DataProvider();

  @override
  void onInit() {
    super.onInit();
    loadMenus();
  }

  void loadMenus() async {
    try {
      isLoading(true);
      var result = await _dataProvider.getLearningMenus();
      menus.assignAll(result);
    } finally {
      isLoading(false);
    }
  }

  void openCategory(String categoryId, String title) {
    Get.toNamed('/learn-docs', arguments: {
      'categoryId': categoryId,
      'title': title,
    });
  }
}
