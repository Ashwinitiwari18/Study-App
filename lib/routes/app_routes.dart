import 'package:get/get.dart';
import 'package:study_app/controllers/question_papers/question_paper_controller.dart';
import 'package:study_app/controllers/question_papers/questions_controller.dart';
import 'package:study_app/controllers/zoom_drawer_controller.dart';
import 'package:study_app/screens/home/home_screen.dart';
import 'package:study_app/screens/introduction/introduction.dart';
import 'package:study_app/screens/login/login_screen.dart';
import 'package:study_app/screens/question/answer_check_screen.dart';
import 'package:study_app/screens/question/questions_screen.dart';
import 'package:study_app/screens/question/result_screen.dart';
import 'package:study_app/screens/question/test_overview_screen.dart';
import 'package:study_app/screens/splash/splash_screen.dart';
import 'package:study_app/services/firebase_storage_service.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(
            name: '/introduction', page: () => const AppIntroductionScreen()),
        GetPage(
            name: '/home',
            page: () => const HomeScreen(),
            binding: BindingsBuilder(() {
              Get.put(QuestionPaperController());
              Get.put(FirebaseStorageService());
              Get.put(MyZoomDrawerController());
            })),
        GetPage(name: LogInScreen.routeName, page: () => const LogInScreen()),
        GetPage(
            name: QuestionsScreen.routeName,
            page: () => const QuestionsScreen(),
            binding: BindingsBuilder(
              () {
                Get.put<QuestionsController>(QuestionsController());
              },
            )),
        GetPage(
            name: TexstOverviewScreen.routeName,
            page: () => const TexstOverviewScreen()),
        GetPage(name: ResultScreen.routeName, page: () => const ResultScreen()),
        GetPage(
            name: AnswerCheckScreen.routeName,
            page: () => const AnswerCheckScreen()),
      ];
}
