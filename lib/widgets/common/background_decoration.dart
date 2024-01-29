import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/app_colors.dart';

class BackgroundDecoration extends StatelessWidget {
  final Widget child;
  final bool showGradient;
  const BackgroundDecoration(
      {super.key, required this.child, this.showGradient = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(
              color: showGradient ? null : Theme.of(context).primaryColor,
              gradient: showGradient ? mainGradient() : null),
          child: CustomPaint(
            painter: BackGroundColor(),
          ),
        )),
        Positioned.fill(child: SafeArea(child: child)),
      ],
    );
  }
}

class BackGroundColor extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.1);
    final path1 = Path();
    path1.moveTo(0, 0);
    path1.lineTo(size.width * 0.2, 0);
    path1.lineTo(0, size.height * 0.4);
    path1.close();

    final path2 = Path();
    path2.moveTo(size.width, 0);
    path2.lineTo(size.width * 0.8, 0);
    path2.lineTo(size.width * 0.2, size.height);
    path2.lineTo(size.width, size.height);
    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
