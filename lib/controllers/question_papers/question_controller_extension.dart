import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/controllers/auth_controller.dart';
import 'package:study_app/controllers/question_papers/questions_controller.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:get/get.dart';

extension QuestionControllerExtention on QuestionsController {
  int get correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestion =>
      '$correctQuestionCount out of ${allQuestions.length} are correct';

  String get points {
    var point = (correctQuestionCount / allQuestions.length) *
        100 *
        (questionPaperModel.timeSeconds - remainSecnds) /
        questionPaperModel.timeSeconds *
        100;
    return point.toStringAsFixed(2);
  }

  void saveTestResult() async {
    final batch = fireStore.batch();
    User? user = Get.find<AuthController>().getUser();
    if (user == null) return;
    batch.set(
      userRF
          .doc(user.email)
          .collection('my_recent_tests')
          .doc(questionPaperModel.id),
      {
        "points": points,
        "correct_answer": "$correctQuestionCount/${allQuestions.length}",
        "question_id": questionPaperModel.id,
        "time": questionPaperModel.timeSeconds - remainSecnds
      },
    );
    batch.commit();
    navigateToHome();
  }
}
