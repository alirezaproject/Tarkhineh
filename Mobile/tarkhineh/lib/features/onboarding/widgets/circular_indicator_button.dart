import 'package:flutter/material.dart';
import 'package:tarkhineh/core/theme.dart';

class AnimatedCircularIndicatorButton extends StatefulWidget {
  final double targetProgress; // مقدار هدف بین 0 و 1
  final VoidCallback onTap;
  final IconData icon;

  const AnimatedCircularIndicatorButton({super.key, required this.targetProgress, required this.onTap, required this.icon});

  @override
  State<AnimatedCircularIndicatorButton> createState() => _AnimatedCircularIndicatorButtonState();
}

class _AnimatedCircularIndicatorButtonState extends State<AnimatedCircularIndicatorButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _currentProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // سرعت انیمیشن
    );
    _setupAnimation();
  }

  void _setupAnimation() {
    _animation =
        Tween<double>(begin: _currentProgress, end: widget.targetProgress).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut, // منحنی نرم
          ),
        )..addListener(() {
          setState(() {}); // رندر دوباره
        });
    _controller.forward(from: 0);
    _currentProgress = widget.targetProgress;
  }

  @override
  void didUpdateWidget(covariant AnimatedCircularIndicatorButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.targetProgress != widget.targetProgress) {
      _setupAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      customBorder: const CircleBorder(),
      child: SizedBox(
        width: 64,
        height: 64,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // دایره سبز وسط
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppTheme.lightTheme.primaryColor, shape: BoxShape.circle),
              child: Icon(widget.icon, color: Colors.white, size: 32),
            ),
            // حلقه پیشرفت دور دکمه
            SizedBox(
              width: 64,
              height: 64,
              child: CircularProgressIndicator(
                value: _animation.value,
                strokeWidth: 2,
                color: AppTheme.lightTheme.primaryColor,
                backgroundColor: Colors.grey.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
