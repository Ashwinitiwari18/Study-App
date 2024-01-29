import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:study_app/controllers/question_papers/question_paper_controller.dart';
import 'package:study_app/firebase_ref/loading_status.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/models/question_paper_model.dart';
import 'package:study_app/screens/home/home_screen.dart';
import 'package:study_app/screens/question/result_screen.dart';

class QuestionsController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late QuestionPaperModel questionPaperModel;
  final allQuestions = <Questions>[];
  final questionIndex = 0.obs;
  bool get isFirstQuestion => questionIndex.value == 0;
  bool get isLastQuestion => questionIndex.value == allQuestions.length - 1;
  Rxn<Questions> currentQuestion = Rxn<Questions>();

  Timer? _timer;
  int remainSecnds = 1;
  final time = '00:00'.obs;
  @override
  void onReady() {
    final _questionPaper = Get.arguments as QuestionPaperModel;
    if (kDebugMode) {
      print(_questionPaper.title);
    }
    loadingData(_questionPaper);
    super.onReady();
  }

  void loadingData(QuestionPaperModel questionPaper) async {
    loadingStatus.value = LoadingStatus.loading;
    questionPaperModel = questionPaper;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuary =
          await questionPapersRF
              .doc(questionPaperModel.id)
              .collection("questions")
              .get();
      final questions = questionQuary.docs
          .map((snapShot) => Questions.fromSnapshot(snapShot))
          .toList();
      questionPaper.questions = questions;
      currentQuestion.value = questionPaper.questions![0];
      for (Questions _question in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answerQuary =
            await questionPapersRF
                .doc(questionPaper.id)
                .collection("questions")
                .doc(_question.id)
                .collection("answers")
                .get();
        final answers = answerQuary.docs
            .map((snapShot) => Answers.fromSnapshot(snapShot))
            .toList();
        _question.answers = answers;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (questionPaper.questions != null &&
        questionPaper.questions!.isNotEmpty) {
      _startTimer(questionPaper.timeSeconds);
      allQuestions.assignAll(questionPaper.questions!);
      if (kDebugMode) {
        print(questionPaper.questions![0].question);
      }
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list','answer_review_list']);
  }

  String get completedTest {
    final answered = allQuestions
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return '$answered out of ${allQuestions.length} answered';
  }

  void jumpToNextQuestion(int index, {bool goBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if (goBack) {
      Get.back();
    }
  }

  void nextQuestion() {
    if (!isLastQuestion) {
      if (kDebugMode) {
        print(questionIndex.value);
      }
      questionIndex.value++;
      currentQuestion.value = allQuestions[questionIndex.value];
    }
  }

  void prevQuestion() {
    if (questionIndex.value > 0) {
      questionIndex.value--;
      currentQuestion.value = allQuestions[questionIndex.value];
    }
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSecnds = seconds;
    _timer = Timer.periodic(duration, (timer) {
      if (remainSecnds == 0) {
        timer.cancel();
      } else {
        int minutes = remainSecnds ~/ 60;
        int seconds = remainSecnds % 60;
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainSecnds--;
      }
    });
  }

  void complete() {
    _timer!.cancel();
    Get.offAndToNamed(ResultScreen.routeName);
  }

  void tryAgain() {
    Get.find<QuestionPaperController>()
        .navigateToQuestion(paper: questionPaperModel, tryAgain: false);
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.offNamedUntil(HomeScreen.routeName, (route) => false);
  }
}
