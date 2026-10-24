 import 'package:flutter/material.dart';

/// Extension on [BuildContext] providing dynamic, responsive dimension helpers.
/// Prevents rigid static pixel constraints and allows UI to gracefully scale
/// across compact phones, modern flagships, and larger tablet displays.
extension ResponsiveSize on BuildContext {
  /// Total screen width from [MediaQuery].
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Total screen height from [MediaQuery].
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Width proportional to screen width percentage (0 to 100).
  double widthPercent(double percentage) => screenWidth * (percentage / 100);

  /// Height proportional to screen height percentage (0 to 100).
  double heightPercent(double percentage) => screenHeight * (percentage / 100);

  /// Computes a responsive value proportional to reference screen width (390dp),
  /// bounded by [min] and [max] to prevent extreme scaling.
  double responsiveWidth(double baseSize, {double? min, double? max}) {
    final scale = screenWidth / 390.0;
    final computed = baseSize * scale;
    if (min != null && max != null) {
      return computed.clamp(min, max);
    } else if (min != null) {
      return computed < min ? min : computed;
    } else if (max != null) {
      return computed > max ? max : computed;
    }
    return computed;
  }

  /// Computes a responsive value proportional to reference screen height (844dp),
  /// bounded by [min] and [max].
  double responsiveHeight(double baseSize, {double? min, double? max}) {
    final scale = screenHeight / 844.0;
    final computed = baseSize * scale;
    if (min != null && max != null) {
      return computed.clamp(min, max);
    } else if (min != null) {
      return computed < min ? min : computed;
    } else if (max != null) {
      return computed > max ? max : computed;
    }
    return computed;
  }
}
