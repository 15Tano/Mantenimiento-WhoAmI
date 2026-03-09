// lib/ui/theme.dart
import 'package:flutter/material.dart';

/// ===========================================================
/// PALETA DE COLORES PRINCIPAL - WHO AM I?
/// ===========================================================
/// Los colores se centralizan aquí para mantener coherencia visual
/// en toda la aplicación. Cualquier cambio de tono o identidad
/// visual puede hacerse en un solo punto.

// Colores base
const kPurple = Color(0xFFD6A7F4); // Morado principal
const kBlue   = Color(0xFF9ED3FF); // Azul del mockup
const kInk    = Color(0xFF111111); // Texto principal
const kGrey1  = Color(0xFF6B7280); // Texto secundario / placeholders

// Verde pastel (para secciones de juegos y acentos suaves)
const kGreenPastel = Color(0xFFB6E2B6);

// Campos y bordes
const kFieldBorder = Color(0xFFE5E7EB);
const kFieldFill   = Color(0xFFF7F8FA);

/// ===========================================================
/// TEMA GLOBAL DE LA APLICACIÓN
/// ===========================================================
final appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,

  // --- Estilo de barra superior ---
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: kInk,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: kInk,
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),
  ),

  // --- Tipografías globales ---
  textTheme: const TextTheme(
    headlineLarge:
        TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: kInk),
    titleLarge:
        TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: kInk),
    bodyMedium: TextStyle(fontSize: 16, color: kInk),
    labelLarge:
        TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: kInk),
  ),

  // --- Campos de texto ---
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    filled: true,
    fillColor: kFieldFill,
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    hintStyle: const TextStyle(color: kGrey1),
    labelStyle: const TextStyle(color: kGrey1),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: kFieldBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: kBlue, width: 1.4),
    ),
  ),

  // --- Botones rellenos (FilledButton) ---
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size.fromHeight(56),
      shape: const StadiumBorder(),
      elevation: 0,
      foregroundColor: kInk, // texto negro
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),

  // --- Íconos ---
  iconTheme: const IconThemeData(color: kInk),
);

/// ===========================================================
/// HELPERS DE BOTONES (para consistencia de estilo)
/// ===========================================================
/// Se usan para mantener la identidad de color en botones tipo pastilla
ButtonStyle pillBlue() => FilledButton.styleFrom(backgroundColor: kBlue);
ButtonStyle pillLav()  => FilledButton.styleFrom(backgroundColor: kPurple);
ButtonStyle pillGreen() => FilledButton.styleFrom(backgroundColor: kGreenPastel);
ButtonStyle pill(Color c) => FilledButton.styleFrom(backgroundColor: c);

/// ===========================================================
/// ESTILOS DE TEXTO ESPECÍFICOS
/// ===========================================================
/// Usado en la pantalla de bienvenida o elementos introductorios.
const welcomeKicker = TextStyle(
  letterSpacing: 1.5,
  color: kGrey1,
  fontSize: 12,
  fontWeight: FontWeight.w600,
);
