import 'package:flutter/material.dart';

abstract class AppColors {
  static Color get primaryblue => const Color(0xFF00B2F5);

  static Color get white => const Color(0xFFF5EDED);

  static Color get lightgreycolor => const Color(0xFFA9A9A9);

  static Color get darkgreycolor => const Color(0xFF3B3939);

  static Color get secondaryBlue => const Color(0xFF282C38);

  static LinearGradient get bluegradient => const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1D8AB4),
            Color(0xFF0F4B62),
          ]);
  static LinearGradient get greengradient => const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF148C41),
            Color(0xFF0A4621),
          ]);
  static LinearGradient get orangegradient => LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFCD5815).withOpacity(0.9),
            Color(0xFFC01A95),
          ]);
}
