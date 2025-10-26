import 'package:devel_app/common/resources/app_constants.dart';
import 'package:devel_app/common/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final bool isConfirmDialog;
  final void Function()? fnOnConfirmPressed;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.description,
    this.isConfirmDialog = false,
    this.fnOnConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: CustomColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
      icon: Image.asset('${AppConstants.imagesPath}logo.jpg', height: 90.0),
      content: Column(
        spacing: 4.0,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: CustomColors.textSecondary),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                if (fnOnConfirmPressed != null) fnOnConfirmPressed!();
              },
              child: Text('Aceptar'),
            ),
          ),
          if (isConfirmDialog)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
            ),
        ],
      ),
    );
  }
}
