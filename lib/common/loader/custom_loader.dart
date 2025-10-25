import 'dart:ui';

import 'package:devel_app/common/resources/app_constants.dart';
import 'package:devel_app/common/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: CustomColors.background.withValues(alpha: 0.2),
        ),
        child: Center(
          child: Image.asset('${AppConstants.animationsPath}loader.gif'),
        ),
      ),
    );
  }
}
