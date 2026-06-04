import 'package:get/get.dart';
import 'projects_assessments_controller.dart';

class ProjectsAssessmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectsAssessmentsController>(() => ProjectsAssessmentsController());
  }
}
