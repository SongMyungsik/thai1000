import 'dart:math';

import 'package:flutter/material.dart';

/// 태국어 글자 대부분에 적용되는 "머리(หัว)부터 시계 반대 방향" 원칙을
/// 특정 글자와 무관하게 추상적으로 보여주는 도식. 원 + 화살표 + 시작점
/// 표시로 구성되며, 실제 글자 위에 위치를 겹치지 않아 정확성 문제가 없다.
class CounterclockwiseDiagram extends StatelessWidget {
  const CounterclockwiseDiagram({super.key, this.size = 140.0});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CounterclockwisePainter(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _CounterclockwisePainter extends CustomPainter {
  _CounterclockwisePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 12.0;

    final circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    // 시작점(오른쪽 아래, 4시 방향)에서 시계 반대 방향으로 약 300도만 그려서
    // "여기서 시작해서 이 방향으로" 라는 느낌을 준다.
    const startAngle = 0.35 * pi; // 대략 4시 방향
    const sweepAngle = -1.7 * pi; // 반시계 방향으로 크게 회전
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, startAngle, sweepAngle, false, circlePaint);

    // 끝나는 지점에 화살촉 그리기.
    final endAngle = startAngle + sweepAngle;
    final tip = center + Offset(cos(endAngle), sin(endAngle)) * radius;
    final tangent = endAngle - pi / 2; // 반시계 방향 진행 방향의 접선
    final arrowLength = 14.0;
    final arrowSpread = 0.5;
    final left = tip -
        Offset(cos(tangent - arrowSpread), sin(tangent - arrowSpread)) *
            arrowLength;
    final right = tip -
        Offset(cos(tangent + arrowSpread), sin(tangent + arrowSpread)) *
            arrowLength;
    final arrowPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(
      Path()
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(left.dx, left.dy)
        ..lineTo(right.dx, right.dy)
        ..close(),
      arrowPaint,
    );

    // 시작점 표시(작은 점 + "1").
    final startPoint = center + Offset(cos(startAngle), sin(startAngle)) * radius;
    canvas.drawCircle(startPoint, 6.0, Paint()..color = color);

    final textPainter = TextPainter(
      text: TextSpan(
        text: '시작',
        style: TextStyle(
          color: color,
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      startPoint + const Offset(6.0, 4.0),
    );
  }

  @override
  bool shouldRepaint(covariant _CounterclockwisePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
