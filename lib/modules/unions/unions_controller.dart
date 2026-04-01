import 'package:get/get.dart';
import '../../data/models/union_model.dart';
import '../../data/providers/data_provider.dart';

class UnionsController extends GetxController {
  var unions = <UnionModel>[].obs;
  var isLoading = true.obs;
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
}
