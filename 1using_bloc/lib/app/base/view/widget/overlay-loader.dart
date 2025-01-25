import 'package:flutter/material.dart';
import 'package:kequele/core/styles/index.dart';

class BossLoadingOverlay extends StatelessWidget {
  BossLoadingOverlay({Key? key, required this.child, required this.overlayWidget, required this.isLoading, this.opacity = 0.8}) : super(key: key);

  final Widget child;
  final Widget overlayWidget;
  final bool isLoading;
  double opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: AppColors.color000000),
          ),
        if (isLoading) overlayWidget,
      ],
    );
  }
}
