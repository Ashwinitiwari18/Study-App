import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/app_icons.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/configs/themes/ui_parameters.dart';
import 'package:study_app/controllers/question_papers/question_paper_controller.dart';
import 'package:get/get.dart';
import 'package:study_app/controllers/zoom_drawer_controller.dart';
import 'package:study_app/screens/home/menu_screen.dart';
import 'package:study_app/screens/home/question_card.dart';
import 'package:study_app/widgets/app_circle_button.dart';
import 'package:study_app/widgets/content_area.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    QuestionPaperController _questionPaperController = Get.find();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(
        builder: (_) {
          return Container(
            decoration: BoxDecoration(gradient: mainGradient()),
            child: Stack(
              children: [
                ZoomDrawer(
                  controller: _.zoomDrawerController,
                  borderRadius: 50,
                  style: DrawerStyle.defaultStyle,
                  angle: 0.0,
                  slideWidth: MediaQuery.of(context).size.width * 0.8,
                  menuScreen: const MyMenuScreen(), // Empty container for now
                  mainScreen: Container(
                    decoration: BoxDecoration(gradient: mainGradient()),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(mobileScreenPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppCircleButton(
                                  onTap: controller.toggleDrawer,
                                  child: const Icon(
                                    AppIcons.menuLeft,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    children: [
                                      const Icon(AppIcons.peace),
                                      Text(
                                        "Hello everyone",
                                        style: detailText.copyWith(
                                          color: onSurfaceTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  "What do you want to learn today?",
                                  style: headerText,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: ContentArea(
                                addPadding: false,
                                child: Obx(() => ListView.separated(
                                    padding: UIParameters.mobileScreenPadding,
                                    itemBuilder: (BuildContext context, index) {
                                      return QuestionCard(
                                          model: _questionPaperController
                                              .allPapers[index]);
                                    },
                                    separatorBuilder:
                                        (BuildContext context, index) {
                                      return const SizedBox(
                                        height: 20,
                                      );
                                    },
                                    itemCount: _questionPaperController
                                        .allPapers.length)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
