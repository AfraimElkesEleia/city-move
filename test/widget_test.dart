import 'package:city_move/features/splash/splash_screen.dart';
import 'package:city_move/features/splash/widgets/splash_logo_badge.dart';
import 'package:city_move/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SplashScreen renders centered logo badge and finishes smoothly', (tester) async {
    // Test on standard mobile size
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const CityMove());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(SplashLogoBadge), findsOneWidget);
    expect(find.byKey(const ValueKey('splash_citymove_wordmark')), findsOneWidget);
    expect(find.byType(SvgPicture), findsNWidgets(2));

    // Let animation finish cleanly
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('citymove-logo.svg animates fade and slide in SplashScreen', (tester) async {
    const totalDuration = Duration(milliseconds: 1000);
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(
          duration: totalDuration,
        ),
      ),
    );

    double getWordmarkOpacity() {
      final opacityWidget = tester.widget<Opacity>(
        find.ancestor(
          of: find.byKey(const ValueKey('splash_citymove_wordmark')),
          matching: find.byType(Opacity),
        ).first,
      );
      return opacityWidget.opacity;
    }

    double getWordmarkOffsetY() {
      final translateWidget = tester.widget<Transform>(
        find.ancestor(
          of: find.byKey(const ValueKey('splash_citymove_wordmark')),
          matching: find.byType(Transform),
        ).first,
      );
      return translateWidget.transform.storage[13];
    }

    // At t=0, wordmark has not started fading in yet
    expect(getWordmarkOpacity(), closeTo(0.0, 0.01));
    expect(getWordmarkOffsetY(), closeTo(16.0, 0.01));

    // Pump to 50% (500ms) - wordmark is actively fading and sliding up
    await tester.pump(const Duration(milliseconds: 500));
    expect(getWordmarkOpacity(), greaterThan(0.2));
    expect(getWordmarkOffsetY(), lessThan(16.0));

    // Pump and settle to completion - fully visible and rested at offset 0
    await tester.pumpAndSettle();
    expect(getWordmarkOpacity(), closeTo(1.0, 0.001));
    expect(getWordmarkOffsetY(), closeTo(0.0, 0.001));
  });

  testWidgets('SplashScreen invokes onFinished callback upon completion', (tester) async {
    var finishedCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: SplashScreen(
          duration: const Duration(milliseconds: 600),
          onFinished: () {
            finishedCalled = true;
          },
        ),
      ),
    );

    expect(finishedCalled, isFalse);

    await tester.pumpAndSettle();

    expect(finishedCalled, isTrue);
  });

  testWidgets('SplashScreen is responsive across compact mobile screen sizes', (tester) async {
    // Test on compact screen (e.g. 320x568)
    tester.view.physicalSize = const Size(320 * 2, 568 * 2);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const CityMove());
    await tester.pumpAndSettle();

    expect(find.byType(SplashLogoBadge), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('SplashScreen logo animates bouncing rotation right and left then settles back to 0', (tester) async {
    const totalDuration = Duration(milliseconds: 1000);
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(
          duration: totalDuration,
        ),
      ),
    );

    double getRotationSin() {
      final transformWidget = tester.widget<Transform>(
        find.byKey(const ValueKey('splash_logo_rotation_transform')),
      );
      // In Matrix4.rotationZ(angle), storage[1] corresponds to sin(angle).
      return transformWidget.transform.storage[1];
    }

    // At t=0, rotation is 0.0
    expect(getRotationSin(), closeTo(0.0, 0.001));

    // Pump to right tilt peak (around 18% of duration -> ~180ms)
    await tester.pump(const Duration(milliseconds: 180));
    final rightTiltSin = getRotationSin();
    expect(rightTiltSin, greaterThan(0.05), reason: 'Logo should tilt right (positive angle)');

    // Pump to left tilt peak (around 36% of duration -> another ~180ms)
    await tester.pump(const Duration(milliseconds: 180));
    final leftTiltSin = getRotationSin();
    expect(leftTiltSin, lessThan(-0.05), reason: 'Logo should bounce left (negative angle)');

    // Settle to completion
    await tester.pumpAndSettle();
    expect(getRotationSin(), closeTo(0.0, 0.0001), reason: 'Logo should settle back to 0');
  });
}

