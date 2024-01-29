import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/question_papers/questions_controller.dart';
import 'package:get/get.dart';
import 'package:study_app/screens/question/result_screen.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:study_app/widgets/common/custom_appbar.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/questions/answer_card.dart';

class AnswerCheckScreen extends GetView<QuestionsController> {
  const AnswerCheckScreen({super.key});

  static const String routeName = '/answercheckscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          () => Text(
            "Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}",
            style: appBarTs,
          ),
        ),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(ResultScreen.routeName);
        },
      ),
      body: BackgroundDecoration(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: ContentArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: [
                        Text(
                          controller.currentQuestion.value!.question,
                          style: questionTS,
                        ),
                        GetBuilder<QuestionsController>(
                            id: 'answer_review_list',
                            builder: (_) {
                              return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(top: 25),
                                  itemBuilder: (context, index) {
                                    final answer = controller
                                        .currentQuestion.value!.answers[index];
                                    final correctAnswer = controller
                                        .currentQuestion.value!.correctAnswer;
                                    final selectedAnswer = controller
                                        .currentQuestion.value!.selectedAnswer;
                                    final String answerText =
                                        "${answer.identifier}. ${answer.answer}";
                                    if (kDebugMode) {
                                      print(correctAnswer);
                                      print(answer.identifier);
                                      print(selectedAnswer);
                                      print(selectedAnswer == null);
                                    }
                                    if (answer.identifier == correctAnswer) {
                                      return CorrectAnswer(answer: answerText);
                                    } else if (selectedAnswer ==
                                        answer.identifier) {
                                      return WrongAnswer(answer: answerText);
                                    } else if (selectedAnswer == null) {
                                      return NotAnswer(answer: answerText);
                                    }
                                    return AnswerCard(
                                      answer: answerText,
                                      onTap: () {},
                                      isSelected: false,
                                    );
                                  },
                                  separatorBuilder: (_, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemCount: controller
                                      .currentQuestion.value!.answers.length);
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CorrectAnswer extends StatelessWidget {
  const CorrectAnswer({super.key, required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBoaderRadius,
          color: correctAnsweredColor.withOpacity(0.1)),
      child: Text(
        answer,
        style: const TextStyle(
            color: correctAnsweredColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class WrongAnswer extends StatelessWidget {
  const WrongAnswer({super.key, required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBoaderRadius,
          color: wrongAnsweredColor.withOpacity(0.1)),
      child: Text(
        answer,
        style: const TextStyle(
            color: wrongAnsweredColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class NotAnswer extends StatelessWidget {
  const NotAnswer({super.key, required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBoaderRadius,
          color: notAnsweredColor.withOpacity(0.1)),
      child: Text(
        answer,
        style: const TextStyle(
            color: notAnsweredColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
