import 'package:city_move/core/theme/app_colors.dart';
import 'package:city_move/core/utils/responsive_size.dart';
import 'package:city_move/features/splash/widgets/splash_logo_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Minimalist, high-performance Splash Screen featuring the central
/// signature brand logo with smooth fade, scale, dynamic bouncing rotation
/// (right, left, and settle to 0), and subtle organic breathing/glow pulse animations.
class SplashScreen extends StatefulWidget {
  /// Optional callback invoked after the splash sequence completes.
  final VoidCallback? onFinished;

  /// Duration of the orchestrated splash entrance and breathing sequence.
  final Duration duration;

  const SplashScreen({
    super.key,
    this.onFinished,
    this.duration = const Duration(milliseconds: 2400),
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotationAnimation;
  late final Animation<double> _glowIntensityAnimation;
  late final Animation<double> _glowOpacityAnimation;
  late final Animation<double> _glowScaleAnimation;
  late final Animation<double> _wordmarkFadeAnimation;
  late final Animation<double> _wordmarkSlideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // 1. Entrance Fade-in (0.0 -> 0.38)
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.38, curve: Curves.easeOut),
    );

    // 2. Entrance Scale (0.82 -> 1.0) followed by subtle smooth breath (1.0 -> 1.035 -> 1.0)
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.82, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.035)
            .chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.035, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 25,
      ),
    ]).animate(_controller);

    // 3. Bouncing rotation: swings right, bounces left, decaying rebound, then settles to 0.0
    _rotationAnimation = TweenSequence<double>([
      // 1. Swing right (clockwise tilt ~ +11.5°)
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.20)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 18,
      ),
      // 2. Bounce left (counter-clockwise tilt ~ -7.5°)
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.20, end: -0.13)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 18,
      ),
      // 3. Decaying bounce back to the right (~ +2.9°)
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.13, end: 0.05)
            .chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 14,
      ),
      // 4. Settle cleanly back to upright (0.0)
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.05, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOutSine)),
        weight: 10,
      ),
      // 5. Rest at 0.0 for the remaining sequence
      TweenSequenceItem(
        tween: ConstantTween<double>(0.0),
        weight: 40,
      ),
    ]).animate(_controller);

    // 4. Badge shadow glow intensity modulation
    _glowIntensityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.3, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.25)
            .chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.25, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 25,
      ),
    ]).animate(_controller);

    // 5. Ambient background aura opacity
    _glowOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.85)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.85, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.85)
            .chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 25,
      ),
    ]).animate(_controller);

    // 6. Ambient background aura scale
    _glowScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.70, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.12)
            .chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.12, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 25,
      ),
    ]).animate(_controller);

    // 7. Wordmark subtle fade-in (Interval 0.38 -> 0.65)
    _wordmarkFadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.38, 0.65, curve: Curves.easeOut),
    );

    // 8. Wordmark gentle upward drift (Interval 0.38 -> 0.65)
    _wordmarkSlideAnimation = Tween<double>(begin: 16.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.38, 0.65, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward().then((_) {
      if (mounted && widget.onFinished != null) {
        widget.onFinished!();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final badgeSize =
        context.responsiveWidth(108.0, min: 88.0, max: 132.0);
    final wordmarkWidth =
        context.responsiveWidth(168.0, min: 136.0, max: 200.0);
    final wordmarkHeight = wordmarkWidth * (95.0 / 300.0);
    final spacing =
        context.responsiveHeight(20.0, min: 16.0, max: 26.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Soft ambient neon glow expanding behind the badge
                    Opacity(
                      opacity: _glowOpacityAnimation.value,
                      child: Container(
                        width: badgeSize * 2.5 * _glowScaleAnimation.value,
                        height: badgeSize * 2.5 * _glowScaleAnimation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppColors.primaryNeon.withValues(alpha: 0.18),
                              AppColors.primaryNeon.withValues(alpha: 0.05),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.45, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Centered logo badge with dynamic bouncing rotation, entrance scale & glow
                    Transform.rotate(
                      key: const ValueKey('splash_logo_rotation_transform'),
                      angle: _rotationAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Opacity(
                          opacity: _fadeAnimation.value,
                          child: SplashLogoBadge(
                            size: badgeSize,
                            rotationAngle: 0.0, // Handled by outer Transform.rotate
                            glowIntensity: _glowIntensityAnimation.value,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spacing),
                // CityMove wordmark: subtle, tasteful fade-in and smooth upward slide
                Opacity(
                  opacity: _wordmarkFadeAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, _wordmarkSlideAnimation.value),
                    child: SvgPicture.asset(
                      'icons/citymove-logo.svg',
                      key: const ValueKey('splash_citymove_wordmark'),
                      width: wordmarkWidth,
                      height: wordmarkHeight,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
