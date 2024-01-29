import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:get/get.dart';

class CountDownTimer extends StatelessWidget {
  const CountDownTimer({super.key,this.color,required this.time});
  final String time;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          color: color??Theme.of(context).primaryColor,
        ),
        Text(
          time,
          style: countDownTimerTS(Get.context).copyWith(color: color),
        )
      ],
    );
  }
}
