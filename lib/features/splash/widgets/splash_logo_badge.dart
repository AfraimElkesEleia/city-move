import 'package:city_move/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashLogoBadge extends StatelessWidget {
  final double size;
  final double rotationAngle;
  final bool hasGlow;
  final double glowIntensity;

  const SplashLogoBadge({
    super.key,
    required this.size,
    this.rotationAngle = 0.0,
    this.hasGlow = true,
    this.glowIntensity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveGlowAlpha = (0.35 * glowIntensity).clamp(0.0, 1.0);
    final squircleSize = size * (448.0 / 512.0);
    final borderRadius = BorderRadius.circular(size * (140.0 / 512.0));

    Widget badge = SvgPicture.asset(
      'icons/application_icon.svg',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );

    if (hasGlow) {
      badge = Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: squircleSize,
            height: squircleSize,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryNeon.withValues(
                    alpha: effectiveGlowAlpha,
                  ),
                  blurRadius: size * (0.28 * glowIntensity).clamp(0.15, 0.45),
                  spreadRadius:
                      size * (0.02 * (glowIntensity - 1.0)).clamp(-0.02, 0.05),
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.45),
                  blurRadius: size * 0.16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
          ),
          badge,
        ],
      );
    }

    if (rotationAngle != 0.0) {
      badge = Transform.rotate(angle: rotationAngle, child: badge);
    }

    return badge;
  }
}
