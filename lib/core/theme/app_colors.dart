import 'package:flutter/material.dart';

/// Centralized color palette for the application.
abstract final class AppColors {
  // Brand Colors
  static const Color primaryNeon = Color(0xFFD2FE46); // Electric Lime
  static const Color primaryNeonDark = Color(0xFFA6D02A);
  
  // Background & Surface
  static const Color background = Color(0xFF090D0A); // Deep dark space background
  static const Color backgroundCard = Color(0xFF141914);
  
  // Radar & Glow Effects
  static const Color radarGlow = Color(0xFF1E381C); // Subtle green ambient glow
  static const Color radarRing = Color(0x1AD2FE46); // Faint concentric rings
  static const Color radarDashedRing = Color(0x3BD2FE46); // Orbit dashed line
  static const Color orbitLine = Color(0x2ED2FE46); // Angled trajectory line
  static const Color ambientCornerGlow = Color(0xFF274A20); // Bottom corner glow
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF); // Pure white for title
  static const Color textSecondary = Color(0xFF9EA39E); // Muted light grey for tagline
  
  // Indicator & UI Controls
  static const Color progressTrack = Color(0xFF1D221D);
  static const Color iconDark = Color(0xFF0A0F0A); // Arrow inside neon badge
}
