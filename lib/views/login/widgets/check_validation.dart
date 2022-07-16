import 'package:flutter/material.dart';

import '../../../core/theme/app_typography.dart';

class CheckValidation extends StatelessWidget {
  final String title;
  final bool isValid;

  const CheckValidation({Key? key, required this.title, required this.isValid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: isValid ? Colors.green : Colors.red),
        const SizedBox(width: 8),
        Text(title, style: AppTypography.title.withError(!isValid)),
      ],
    );
  }
}
