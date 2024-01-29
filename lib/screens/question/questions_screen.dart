import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/question_papers/questions_controller.dart';
import 'package:study_app/firebase_ref/loading_status.dart';
import 'package:study_app/screens/question/test_overview_screen.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:get/get.dart';
import 'package:study_app/widgets/common/custom_appbar.dart';
import 'package:study_app/widgets/common/main_button.dart';
import 'package:study_app/widgets/common/question_place_holder.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/questions/answer_card.dart';
import 'package:study_app/widgets/questions/countdown_timer.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  const QuestionsScreen({super.key});

  static const String routeName = "/questionsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: const ShapeDecoration(
              shape: StadiumBorder(
                  side: BorderSide(color: onSurfaceTextColor, width: 2))),
          child: Obx(
            () => CountDownTimer(
              time: controller.time.value,
              color: onSurfaceTextColor,
            ),
          ),
        ),
        showActionIcon: true,
        titleWidget: Obx(
          () => Text(
            "Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}",
            style: appBarTs,
          ),
        ),
      ),
      body: BackgroundDecoration(
        child: Obx(
          () => Column(
            children: [
              if (controller.loadingStatus.value == LoadingStatus.loading)
                const Expanded(
                    child: ContentArea(child: QuestionScreenHolder())),
              if (controller.loadingStatus.value == LoadingStatus.completed)
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
                            id: 'answers_list',
                            builder: (context) {
                              return ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 25),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final answer = controller
                                        .currentQuestion.value!.answers[index];
                                    return AnswerCard(
                                        isSelected: answer.identifier ==
                                            controller.currentQuestion.value!
                                                .selectedAnswer,
                                        answer:
                                            "${answer.identifier}. ${answer.answer}",
                                        onTap: () => controller
                                            .selectedAnswer(answer.identifier));
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 10,
                                      ),
                                  itemCount: controller
                                      .currentQuestion.value!.answers.length);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: Row(children: [
                    if (!controller.isFirstQuestion)
                      Expanded(
                          child: Visibility(
                        visible: !controller.isFirstQuestion,
                        child: MainButton(
                          onTap: () {
                            controller.prevQuestion();
                          },
                          title: 'Previous',
                        ),
                      )),
                    Expanded(
                        child: Visibility(
                      visible: controller.loadingStatus.value ==
                          LoadingStatus.completed,
                      child: MainButton(
                        onTap: () {
                          controller.isLastQuestion
                              ? Get.toNamed(TexstOverviewScreen.routeName)
                              : controller.nextQuestion();
                        },
                        title: controller.isLastQuestion ? 'Submit' : 'Next',
                      ),
                    )),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
