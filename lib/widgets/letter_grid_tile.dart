import 'package:flutter/material.dart';

/// 자음/모음 목록에서 공용으로 쓰는 카드형 타일.
class LetterGridTile extends StatelessWidget {
  const LetterGridTile({
    super.key,
    required this.mainText,
    required this.subText,
    required this.badgeText,
    required this.onTap,
    this.boxColor,
    this.boxTextColor,
  });

  final String mainText;
  final String subText;
  final String badgeText;
  final VoidCallback onTap;

  /// 카드 전체 배경색(자음 클래스·모음 종류 구분용). 넘기지 않으면 기존 테마 색 유지.
  final Color? boxColor;
  final Color? boxTextColor;

  @override
  Widget build(BuildContext context) {
    final textColor = boxTextColor;
    return Card(
      elevation: 2.0,
      color: boxColor,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mainText,
                style: TextStyle(fontSize: 30.0, color: textColor),
              ),
              const SizedBox(height: 4.0),
              Text(
                subText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.0, color: textColor),
                overflow: TextOverflow.fade,
                maxLines: 1,
              ),
              const SizedBox(height: 4.0),
              Text(
                badgeText,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: textColor ?? Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
