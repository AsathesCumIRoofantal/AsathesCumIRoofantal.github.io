import 'package:get/get.dart';
import '../../data/models/identity_model.dart';
import '../../data/providers/data_provider.dart';

class IdentityController extends GetxController {
  var questionnaires = <QuestionnaireModel>[].obs;
  var isLoading = true.obs;
  var currentQuestionIndex = 0.obs;
  var answers = <String, String>{}.obs; // question id to selected option
  var isCompleted = false.obs;

  final DataProvider _dataProvider = DataProvider();

  @override
  void onInit() {
    super.onInit();
    loadQuestionnaires();
  }

  void loadQuestionnaires() async {
    try {
      isLoading(true);
      var result = await _dataProvider.getQuestionnaires();
      questionnaires.assignAll(result);
    } finally {
      isLoading(false);
    }
  }

  void answerQuestion(String questionId, String answer) {
    answers[questionId] = answer;
    if (currentQuestionIndex.value < questionnaires.length - 1) {
      currentQuestionIndex.value++;
    } else {
      isCompleted.value = true;
    }
  }

  void reset() {
    currentQuestionIndex.value = 0;
    answers.clear();
    isCompleted.value = false;
  }
}
