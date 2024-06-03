import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:loading_animation_widget/loading_animation_widget.dart';

Future loading(BuildContext context){
  return showDialog(
    context: context,
    barrierColor: Colors.white.withOpacity(0.8),
    builder: (context) => PopScope(
      canPop: false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.3),
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: LoadingAnimationWidget.threeRotatingDots(
              color: Colors.blue,
              size: 50
            ),
          ),
        ),
      ),
    ),
  );
}
