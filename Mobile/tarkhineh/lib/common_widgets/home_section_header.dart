import 'package:flutter/material.dart';
import 'package:tarkhineh/core/theme.dart';

class AppHomeSectionHeader extends StatelessWidget {
  final String title;
  final bool isWhite;
  const AppHomeSectionHeader({super.key, required this.title, this.isWhite = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        padding: const EdgeInsets.fromLTRB(40, 10, 20, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), topLeft: Radius.circular(8)),
          color: isWhite ? Colors.white : Color(0xffE5F2E9),
        ),
        child: Text(title, style: AppTheme.lightTheme.textTheme.headlineMedium),
      ),
    );
  }
}
