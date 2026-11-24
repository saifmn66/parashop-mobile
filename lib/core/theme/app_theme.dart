// lib/core/theme/app_theme.dart
//
// Parapharmacie app theme: colors, sizes, typography, light + dark themes.
// Requires: flutter pub add google_fonts   (Flutter 3.27+)

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/* ────────────────────────────────────────────────────────────────
   COLORS
   ──────────────────────────────────────────────────────────────── */
class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF454B20); // dark green
  static const Color primaryLight = Color(0xFF6B7338); // hover / pressed tint
  static const Color oliveDark = Color(0xFF3A411B); // deep olive CTA
  static const Color secondary = Color(0xFFB4D2A9); // light green
  static const Color secondarySoft = Color(0xFFE3EFDD); // chips, badges
  static const Color secondaryDeep = Color(0xFF8DB77F); // icons on light bg

  // Warm editorial ivory & beige surfaces
  static const Color ivory = Color(0xFFFAF8F3); // warm ivory canvas & panels
  static const Color beigeCard = Color(0xFFF1ECE1); // soft beige product cards
  static const Color beigeSoft = Color(0xFFE8E2D5); // unselected chips & icon discs
  static const Color darkBeigeCard = Color(0xFF232617); // dark mode card surface

  // Light surfaces
  static const Color background = Color(0xFFFAF8F3);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1ECE1);
  static const Color border = Color(0xFFE5DFD2);

  // Text (light)
  static const Color textPrimary = Color(0xFF1B1F10);
  static const Color textSecondary = Color(0xFF5E6552);
  static const Color textHint = Color(0xFF9AA08F);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Dark mode
  static const Color darkBackground = Color(0xFF12140A);
  static const Color darkSurface = Color(0xFF1C1F10);
  static const Color darkSurfaceVariant = Color(0xFF262A16);
  static const Color darkBorder = Color(0xFF353A22);
  static const Color darkTextPrimary = Color(0xFFF1F5EC);
  static const Color darkTextSecondary = Color(0xFFA9B09C);

  // Status
  static const Color success = Color(0xFF3E8E41);
  static const Color warning = Color(0xFFE0A100);
  static const Color error = Color(0xFFC8372D);
  static const Color info = Color(0xFF2F7DA8);

  // E-commerce
  static const Color sale = Color(0xFFD9534F); // discount badge
  static const Color rating = Color(0xFFF5B301); // stars
  static const Color shimmerBase = Color(0xFFE6ECE0);
  static const Color shimmerHighlight = Color(0xFFF7FAF4);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5A6129), primary],
  );

  static const LinearGradient softGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [secondarySoft, background],
  );
}

/* ────────────────────────────────────────────────────────────────
   SIZES  (spacing, radius, icons, components)
   ──────────────────────────────────────────────────────────────── */
class AppSizes {
  AppSizes._();

  // Spacing scale (4pt grid)
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // Screen padding
  static const double screenPadding = 20;
  static const EdgeInsets screenInsets =
      EdgeInsets.symmetric(horizontal: screenPadding);

  // Radius
  static const double radiusXs = 8;
  static const double radiusSm = 12;
  static const double radiusMd = 16;
  static const double radiusLg = 24;
  static const double radiusPill = 100;

  static BorderRadius get rXs => BorderRadius.circular(radiusXs);
  static BorderRadius get rSm => BorderRadius.circular(radiusSm);
  static BorderRadius get rMd => BorderRadius.circular(radiusMd);
  static BorderRadius get rLg => BorderRadius.circular(radiusLg);
  static BorderRadius get rPill => BorderRadius.circular(radiusPill);

  // Icons
  static const double iconSm = 18;
  static const double iconMd = 24;
  static const double iconLg = 32;

  // Components
  static const double buttonHeight = 54;
  static const double buttonHeightSmall = 42;
  static const double inputHeight = 54;
  static const double appBarHeight = 60;
  static const double bottomBarHeight = 68;
  static const double productImageHeight = 140;
  static const double categoryChipHeight = 40;
  static const double avatarSm = 36;
  static const double avatarMd = 56;

  // Elevation (kept soft, modern look uses shadows more than elevation)
  static const double elevationNone = 0;
  static const double elevationLow = 1;
}

/* ────────────────────────────────────────────────────────────────
   SHADOWS
   ──────────────────────────────────────────────────────────────── */
class AppShadows {
  AppShadows._();

  static List<BoxShadow> soft = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.06),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> medium = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.12),
      blurRadius: 28,
      offset: const Offset(0, 12),
    ),
  ];

  static List<BoxShadow> button = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.28),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];
}

/* ────────────────────────────────────────────────────────────────
   MOTION
   ──────────────────────────────────────────────────────────────── */
class AppMotion {
  AppMotion._();
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
  static const Curve curve = Curves.easeOutCubic;
}

/* ────────────────────────────────────────────────────────────────
   TYPOGRAPHY
   ──────────────────────────────────────────────────────────────── */
class AppText {
  AppText._();

  static TextTheme textTheme(Color primary, Color secondary) {
    final base = GoogleFonts.plusJakartaSansTextTheme();
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
          fontSize: 34, fontWeight: FontWeight.w800, height: 1.15, letterSpacing: -0.8, color: primary),
      headlineLarge: base.headlineLarge?.copyWith(
          fontSize: 28, fontWeight: FontWeight.w800, height: 1.2, letterSpacing: -0.6, color: primary),
      headlineMedium: base.headlineMedium?.copyWith(
          fontSize: 24, fontWeight: FontWeight.w700, height: 1.25, letterSpacing: -0.4, color: primary),
      headlineSmall: base.headlineSmall?.copyWith(
          fontSize: 20, fontWeight: FontWeight.w700, height: 1.3, letterSpacing: -0.2, color: primary),
      titleLarge: base.titleLarge?.copyWith(
          fontSize: 18, fontWeight: FontWeight.w700, color: primary),
      titleMedium: base.titleMedium?.copyWith(
          fontSize: 16, fontWeight: FontWeight.w600, color: primary),
      titleSmall: base.titleSmall?.copyWith(
          fontSize: 14, fontWeight: FontWeight.w600, color: primary),
      bodyLarge: base.bodyLarge?.copyWith(
          fontSize: 16, fontWeight: FontWeight.w400, height: 1.5, color: primary),
      bodyMedium: base.bodyMedium?.copyWith(
          fontSize: 14, fontWeight: FontWeight.w400, height: 1.5, color: secondary),
      bodySmall: base.bodySmall?.copyWith(
          fontSize: 12, fontWeight: FontWeight.w400, height: 1.4, color: secondary),
      labelLarge: base.labelLarge?.copyWith(
          fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.1, color: primary),
      labelMedium: base.labelMedium?.copyWith(
          fontSize: 13, fontWeight: FontWeight.w600, color: primary),
      labelSmall: base.labelSmall?.copyWith(
          fontSize: 11, fontWeight: FontWeight.w600, color: secondary),
    );
  }

  // Editorial serif display style (for Shop title, promo headlines, curated headers)
  static TextStyle editorialDisplay({
    double fontSize = 28,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double height = 1.18,
    double letterSpacing = -0.3,
  }) =>
      GoogleFonts.playfairDisplay(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  // Price style (use with .copyWith for color)
  static TextStyle price = GoogleFonts.plusJakartaSans(
      fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -0.3);
  static TextStyle priceOld = GoogleFonts.plusJakartaSans(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.lineThrough,
      color: AppColors.textHint);
}

/* ────────────────────────────────────────────────────────────────
   THEMES
   ──────────────────────────────────────────────────────────────── */
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.secondary,
      onPrimaryContainer: AppColors.primary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.primary,
      secondaryContainer: AppColors.secondarySoft,
      onSecondaryContainer: AppColors.primary,
      tertiary: AppColors.secondaryDeep,
      onTertiary: AppColors.primary,
      error: AppColors.error,
      onError: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      surfaceContainerHighest: AppColors.surfaceVariant,
      outline: AppColors.border,
      outlineVariant: AppColors.border,
    );
    return _build(
      scheme: scheme,
      background: AppColors.background,
      textPrimary: AppColors.textPrimary,
      textSecondary: AppColors.textSecondary,
      fill: AppColors.surfaceVariant,
      border: AppColors.border,
    );
  }

  static ThemeData get dark {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.secondary, // light green pops on dark
      onPrimary: AppColors.primary,
      primaryContainer: AppColors.primary,
      onPrimaryContainer: AppColors.secondary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.primary,
      secondaryContainer: AppColors.darkSurfaceVariant,
      onSecondaryContainer: AppColors.secondary,
      tertiary: AppColors.secondaryDeep,
      onTertiary: AppColors.darkBackground,
      error: Color(0xFFFF8A80),
      onError: Colors.black,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
      onSurfaceVariant: AppColors.darkTextSecondary,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
      outline: AppColors.darkBorder,
      outlineVariant: AppColors.darkBorder,
    );
    return _build(
      scheme: scheme,
      background: AppColors.darkBackground,
      textPrimary: AppColors.darkTextPrimary,
      textSecondary: AppColors.darkTextSecondary,
      fill: AppColors.darkSurfaceVariant,
      border: AppColors.darkBorder,
    );
  }

  static ThemeData _build({
    required ColorScheme scheme,
    required Color background,
    required Color textPrimary,
    required Color textSecondary,
    required Color fill,
    required Color border,
  }) {
    final isDark = scheme.brightness == Brightness.dark;
    final text = AppText.textTheme(textPrimary, textSecondary);

    OutlineInputBorder inputBorder(Color c, [double w = 1]) =>
        OutlineInputBorder(
          borderRadius: AppSizes.rMd,
          borderSide: BorderSide(color: c, width: w),
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      textTheme: text,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),

      // AppBar: flat, clean, like iOS large-title apps
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        toolbarHeight: AppSizes.appBarHeight,
        titleTextStyle: text.titleLarge,
        iconTheme: IconThemeData(color: textPrimary, size: AppSizes.iconMd),
        systemOverlayStyle:
            isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: AppSizes.rMd),
          textStyle: text.labelLarge,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
          shape: RoundedRectangleBorder(borderRadius: AppSizes.rMd),
          textStyle: text.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
          side: BorderSide(color: border, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: AppSizes.rMd),
          textStyle: text.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: text.labelMedium,
        ),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: fill,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: 16),
        hintStyle: text.bodyMedium?.copyWith(color: AppColors.textHint),
        labelStyle: text.bodyMedium,
        prefixIconColor: textSecondary,
        suffixIconColor: textSecondary,
        border: inputBorder(Colors.transparent),
        enabledBorder: inputBorder(Colors.transparent),
        focusedBorder: inputBorder(scheme.primary, 1.5),
        errorBorder: inputBorder(scheme.error),
        focusedErrorBorder: inputBorder(scheme.error, 1.5),
      ),

      // Cards
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: AppSizes.rMd,
          side: BorderSide(color: border),
        ),
      ),

      // Chips (categories, filters)
      chipTheme: ChipThemeData(
        backgroundColor: fill,
        selectedColor: scheme.primary,
        labelStyle: text.labelMedium,
        secondaryLabelStyle: text.labelMedium?.copyWith(color: scheme.onPrimary),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: AppSizes.rPill),
        showCheckmark: false,
      ),

      // Bottom navigation (Material 3 NavigationBar, pill indicator)
      navigationBarTheme: NavigationBarThemeData(
        height: AppSizes.bottomBarHeight,
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        indicatorColor: isDark ? AppColors.primary : AppColors.secondarySoft,
        indicatorShape: RoundedRectangleBorder(borderRadius: AppSizes.rPill),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return text.labelSmall?.copyWith(
            color: selected ? scheme.primary : textSecondary,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: AppSizes.iconMd,
            color: selected ? scheme.primary : textSecondary,
          );
        }),
      ),

      // Bottom sheets & dialogs (big rounded corners like iOS)
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLg)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: AppSizes.rLg),
        titleTextStyle: text.titleLarge,
        contentTextStyle: text.bodyMedium,
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? AppColors.secondary : AppColors.primary,
        contentTextStyle: text.bodyMedium?.copyWith(
            color: isDark ? AppColors.primary : Colors.white,
            fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: AppSizes.rSm),
      ),

      // Controls
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppSizes.rMd),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith((s) =>
            s.contains(WidgetState.selected) ? scheme.primary : border),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        fillColor: WidgetStateProperty.resolveWith((s) =>
            s.contains(WidgetState.selected) ? scheme.primary : Colors.transparent),
        side: BorderSide(color: border, width: 1.5),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: fill,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
    );
  }
}
