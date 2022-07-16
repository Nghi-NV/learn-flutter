import 'package:flutter/material.dart';

extension CustomColor on Color {
  Color get error {
    return Colors.red;
  }

  Color get success {
    return Colors.green;
  }
}

extension CustomTextStyle on TextStyle {
  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.bold);
  }

  TextStyle get italic {
    return copyWith(fontStyle: FontStyle.italic);
  }

  TextStyle get error {
    return copyWith(color: Colors.red);
  }

  TextStyle withError(bool isError) {
    return copyWith(color: isError ? Colors.red : Colors.green);
  }
}

class AppTypography {
  static TextStyle title = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
}
