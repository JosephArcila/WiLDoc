import 'package:flutter/material.dart';
import 'util.dart';

final ThemeData lightHighContrastTheme = ThemeData(
  useMaterial3: true,
  colorScheme: MaterialTheme.lightHighContrastScheme().toColorScheme(),
  textTheme: createTextTheme().apply(
    bodyColor: MaterialTheme.lightHighContrastScheme().onSurface,
    displayColor: MaterialTheme.lightHighContrastScheme().onSurface,
  ),
);

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00347f),
      surfaceTint: Color(0xff2b5bb5),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2757b1),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff004a0e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2d6f2f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff536067),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffb9c7ce),
      onTertiaryContainer: Color(0xff2a373c),
      error: Color(0xff95000b),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcc2d29),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffaf8ff),
      onBackground: Color(0xff1a1b21),
      surface: Color(0xfffdf8f8),
      onSurface: Color(0xff1c1b1b),
      surfaceVariant: Color(0xffe0e3e5),
      onSurfaceVariant: Color(0xff444749),
      outline: Color(0xff747879),
      outlineVariant: Color(0xffc4c7c9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inverseOnSurface: Color(0xfff4f0ef),
      inversePrimary: Color(0xffb0c6ff),
      primaryFixed: Color(0xffd9e2ff),
      onPrimaryFixed: Color(0xff001945),
      primaryFixedDim: Color(0xffb0c6ff),
      onPrimaryFixedVariant: Color(0xff00429c),
      secondaryFixed: Color(0xffacf4a4),
      onSecondaryFixed: Color(0xff002203),
      secondaryFixedDim: Color(0xff91d78a),
      onSecondaryFixedVariant: Color(0xff0c5216),
      tertiaryFixed: Color(0xffd7e5ec),
      onTertiaryFixed: Color(0xff101d23),
      tertiaryFixedDim: Color(0xffbbc9d0),
      onTertiaryFixedVariant: Color(0xff3c494f),
      surfaceDim: Color(0xffddd9d8),
      surfaceBright: Color(0xfffdf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00347f),
      surfaceTint: Color(0xff2b5bb5),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2757b1),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff004a0e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2d6f2f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff38454b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff69777d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c000a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcc2d29),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffaf8ff),
      onBackground: Color(0xff1a1b21),
      surface: Color(0xfffdf8f8),
      onSurface: Color(0xff1c1b1b),
      surfaceVariant: Color(0xffe0e3e5),
      onSurfaceVariant: Color(0xff404345),
      outline: Color(0xff5c6061),
      outlineVariant: Color(0xff787b7d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inverseOnSurface: Color(0xfff4f0ef),
      inversePrimary: Color(0xffb0c6ff),
      primaryFixed: Color(0xff4671cd),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff2858b2),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff418340),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff276929),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff69777d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff515e64),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffddd9d8),
      surfaceBright: Color(0xfffdf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff001f52),
      surfaceTint: Color(0xff2b5bb5),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff003e94),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff002905),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff054e12),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff172429),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff38454b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0003),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c000a),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffaf8ff),
      onBackground: Color(0xff1a1b21),
      surface: Color(0xfffdf8f8),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffe0e3e5),
      onSurfaceVariant: Color(0xff212426),
      outline: Color(0xff404345),
      outlineVariant: Color(0xff404345),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffe7ebff),
      primaryFixed: Color(0xff003e94),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff002967),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff054e12),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003508),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff38454b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff222f34),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffddd9d8),
      surfaceBright: Color(0xfffdf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData lightHighContrast() {
    return ThemeData(
      useMaterial3: true,
      brightness: lightHighContrastScheme().brightness,
      colorScheme: lightHighContrastScheme().toColorScheme(),
      textTheme: createTextTheme().apply(
        bodyColor: lightHighContrastScheme().onSurface,
        displayColor: lightHighContrastScheme().onSurface,
      ),
      scaffoldBackgroundColor: lightHighContrastScheme().surface,
      canvasColor: lightHighContrastScheme().surface,
    );
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb0c6ff),
      surfaceTint: Color(0xffb0c6ff),
      onPrimary: Color(0xff002d6f),
      primaryContainer: Color(0xff003d93),
      onPrimaryContainer: Color(0xffcbd8ff),
      secondary: Color(0xff91d78a),
      onSecondary: Color(0xff003909),
      secondaryContainer: Color(0xff0d5317),
      onSecondaryContainer: Color(0xffacf3a3),
      tertiary: Color(0xffd4e2e9),
      onTertiary: Color(0xff253238),
      tertiaryContainer: Color(0xffaab8bf),
      onTertiaryContainer: Color(0xff1f2c31),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xffaa1014),
      onErrorContainer: Color(0xfffff6f5),
      background: Color(0xff111319),
      onBackground: Color(0xffe2e2ea),
      surface: Color(0xff141313),
      onSurface: Color(0xffe5e2e1),
      surfaceVariant: Color(0xff444749),
      onSurfaceVariant: Color(0xffc4c7c9),
      outline: Color(0xff8e9193),
      outlineVariant: Color(0xff444749),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inverseOnSurface: Color(0xff313030),
      inversePrimary: Color(0xff2b5bb5),
      primaryFixed: Color(0xffd9e2ff),
      onPrimaryFixed: Color(0xff001945),
      primaryFixedDim: Color(0xffb0c6ff),
      onPrimaryFixedVariant: Color(0xff00429c),
      secondaryFixed: Color(0xffacf4a4),
      onSecondaryFixed: Color(0xff002203),
      secondaryFixedDim: Color(0xff91d78a),
      onSecondaryFixedVariant: Color(0xff0c5216),
      tertiaryFixed: Color(0xffd7e5ec),
      onTertiaryFixed: Color(0xff101d23),
      tertiaryFixedDim: Color(0xffbbc9d0),
      onTertiaryFixedVariant: Color(0xff3c494f),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2b2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb6caff),
      surfaceTint: Color(0xffb0c6ff),
      onPrimary: Color(0xff00143a),
      primaryContainer: Color(0xff648eec),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xff95dc8e),
      onSecondary: Color(0xff001c02),
      secondaryContainer: Color(0xff5da059),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffd4e2e9),
      onTertiary: Color(0xff1d2a2f),
      tertiaryContainer: Color(0xffaab8bf),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab2),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff544a),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff111319),
      onBackground: Color(0xffe2e2ea),
      surface: Color(0xff141313),
      onSurface: Color(0xfffefaf9),
      surfaceVariant: Color(0xff444749),
      onSurfaceVariant: Color(0xffc8cbcd),
      outline: Color(0xffa0a3a5),
      outlineVariant: Color(0xff808485),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inverseOnSurface: Color(0xff2b2a2a),
      inversePrimary: Color(0xff03439d),
      primaryFixed: Color(0xffd9e2ff),
      onPrimaryFixed: Color(0xff000f30),
      primaryFixedDim: Color(0xffb0c6ff),
      onPrimaryFixedVariant: Color(0xff00327a),
      secondaryFixed: Color(0xffacf4a4),
      onSecondaryFixed: Color(0xff001602),
      secondaryFixedDim: Color(0xff91d78a),
      onSecondaryFixedVariant: Color(0xff00400b),
      tertiaryFixed: Color(0xffd7e5ec),
      onTertiaryFixed: Color(0xff061318),
      tertiaryFixedDim: Color(0xffbbc9d0),
      onTertiaryFixedVariant: Color(0xff2b383e),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2b2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffcfaff),
      surfaceTint: Color(0xffb0c6ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb6caff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff1ffe9),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff95dc8e),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff6fbff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffbfcdd4),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab2),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff111319),
      onBackground: Color(0xffe2e2ea),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff444749),
      onSurfaceVariant: Color(0xfff8fbfd),
      outline: Color(0xffc8cbcd),
      outlineVariant: Color(0xffc8cbcd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff002762),
      primaryFixed: Color(0xffdfe6ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb6caff),
      onPrimaryFixedVariant: Color(0xff00143a),
      secondaryFixed: Color(0xffb1f9a8),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff95dc8e),
      onSecondaryFixedVariant: Color(0xff001c02),
      tertiaryFixed: Color(0xffdbe9f0),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffbfcdd4),
      onTertiaryFixedVariant: Color(0xff0b181d),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2b2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}