import 'package:flutter/material.dart';

import '../models/tone.dart';

/// 성조의 음높이 변화를 시간(가로) vs 음높이(세로) 곡선으로 그리는 작은 그래프.
class ToneContourChart extends StatelessWidget {
  const ToneContourChart({
    super.key,
    required this.tone,
    this.width = 56.0,
    this.height = 40.0,
    this.strokeWidth = 3.0,
  });

  final Tone tone;
  final double width;
  final double height;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: CustomPaint(
        size: Size(width, height),
        painter: _ToneContourPainter(
          points: tone.contourPoints,
          color: Theme.of(context).colorScheme.primary,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _ToneContourPainter extends CustomPainter {
  _ToneContourPainter({
    required this.points,
    required this.color,
    required this.strokeWidth,
  });

  final List<(double, double)> points;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final (t, pitch) = points[i];
      final dx = t * size.width;
      final dy = size.height - pitch * size.height;
      if (i == 0) {
        path.moveTo(dx, dy);
      } else {
        path.lineTo(dx, dy);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ToneContourPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
