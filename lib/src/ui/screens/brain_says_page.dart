import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'game_page.dart'; // Asume que esta es la ruta a tu menú de juegos

class BrainSaysPage extends StatefulWidget {
  const BrainSaysPage({super.key});
  static const route = '/games/brain_says';

  @override
  State<BrainSaysPage> createState() => _BrainSaysPageState();
}

class _BrainSaysPageState extends State<BrainSaysPage> {
  int gridSize = 4;
  List<int> pattern = [];
  List<int> userInput = [];
  bool showingPattern = true;
  bool userTurn = false;
  int round = 1;
  int score = 0;
  int highlightedIndex = -1;

  // --- Colores definidos para el Modal de Fin de Juego (manteniendo el estilo mejorado) ---
  final Color primaryPurple =
      Color(0xFFD6A7F4); // Morado oscuro (para texto del modal)
  final Color modalButtonColor =
      Color(0xFFD6A7F4); // Lila/Morado claro (para botón principal del modal)
  final Color starColor = const Color(0xFFFFCC00); // Dorado para las estrellas

  // --- Los colores de la cuadrícula se revertirán a los colores por defecto (gris, azul, morado) ---

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    pattern.clear();
    userInput.clear();
    gridSize = 4;
    round = 1;
    score = 0;
    showingPattern = true;
    _generatePattern();
    _showPattern();
  }

  void _generatePattern() {
    final random = Random();
    pattern.add(random.nextInt(gridSize));
  }

  Future<void> _showPattern() async {
    showingPattern = true;
    userTurn = false;
    setState(() {});

    for (int index in pattern) {
      if (!mounted) return;
      setState(() => highlightedIndex = index);
      // Tiempo para que el usuario observe el patrón
      await Future.delayed(const Duration(milliseconds: 600));
      setState(() => highlightedIndex = -1);
      // Pequeña pausa entre iluminaciones
      await Future.delayed(const Duration(milliseconds: 300));
    }

    showingPattern = false;
    userTurn = true;
    userInput.clear();
    setState(() {});
  }

  void onTileTap(int index) async {
    if (!userTurn) return;

    setState(() => highlightedIndex = index);
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() => highlightedIndex = -1);

    userInput.add(index);

    // 1. Verificar si el toque es incorrecto
    if (userInput.last != pattern[userInput.length - 1]) {
      _showGameOver();
      return;
    }

    // 2. Verificar si el patrón fue completado
    if (userInput.length == pattern.length) {
      score++;
      userTurn = false;
      await Future.delayed(const Duration(milliseconds: 500));

      // Aumentar el tamaño de la cuadrícula cada 3 rondas
      if (round % 3 == 0 && gridSize < 9) {
        gridSize++;
      }

      round++;
      _generatePattern();
      _showPattern();
    }
  }

  // --- Lógica para calcular las estrellas basada en el nivel alcanzado ---
  double _calculateStars(int level) {
    if (level <= 1) return 0.5;
    if (level <= 3) return 1.0;
    if (level <= 5) return 1.5;
    if (level <= 7) return 2.0;
    if (level <= 9) return 2.5;
    return 3.0;
  }

  // --- Función principal para mostrar el modal de fin de partida (Game Over) ---
  void _showGameOver() {
    final int levelReached = round - 1;
    final double starRating = _calculateStars(levelReached);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GameEndModal(
          levelReached: levelReached,
          starRating: starRating,
          onRestart: () {
            Navigator.pop(context); // Cierra el modal
            _startGame(); // Reinicia el juego
          },
          onMenu: () {
            Navigator.pop(context); // Cierra el modal
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const GamesPage()),
            );
          },
          primaryPurple: primaryPurple,
          modalButtonColor: modalButtonColor,
          starColor: starColor,
        );
      },
    );
  }

  // --- Diálogo de confirmación para salir ---
  Future<bool> _onWillPop() async {
    bool salir = false;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('¿Estás seguro que quieres salir?'),
        content: const Text('Perderás tu partida actual.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No, continuar jugando'),
          ),
          TextButton(
            onPressed: () {
              salir = true;
              Navigator.pop(context);
            },
            child: const Text('Sí, salir'),
          ),
        ],
      ),
    );
    return salir;
  }

  // --- Método Build (donde se aplica la lógica de colores de los cuadros) ---
  @override
  Widget build(BuildContext context) {
    final tileCount = gridSize;
    final size = MediaQuery.of(context).size;
    final gridSide = sqrt(tileCount).ceil();
    // Cálculo del tamaño para asegurar que la cuadrícula se vea bien en el espacio disponible
    final tileSize = (size.width - (12 * (gridSide + 1))) / gridSide;

    return WillPopScope(
      onWillPop: () async {
        if (await _onWillPop()) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const GamesPage()),
          );
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Brain Says',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              if (await _onWillPop()) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const GamesPage()),
                );
              }
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  showingPattern
                      ? 'Observa el patrón...'
                      : userTurn
                          ? 'Repite el patrón'
                          : 'Esperando...',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 15),

                // --- Nivel y puntuación encima del tablero ---
                Text(
                  'Nivel: $round  |  Puntuación: $score',
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 20),

                // --- Cuadrícula del juego ---
                Container(
                  padding: const EdgeInsets.all(12),
                  constraints: BoxConstraints(maxWidth: size.width),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tileCount,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridSide,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (context, index) {
                      bool isActive = index == highlightedIndex;
                      return GestureDetector(
                        onTap: () => onTileTap(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            // --- REVERSIÓN DE COLORES AQUÍ (gris, azul, morado) ---
                            color: isActive
                                ? showingPattern
                                    ? Colors
                                        .lightBlueAccent // Iluminación del patrón (azul claro)
                                    : Colors.purpleAccent.withOpacity(
                                        0.6) // Iluminación del toque de usuario (morado claro)
                                : Colors.grey
                                    .shade300, // Color de los bloques inactivos (gris claro)
                            // --- FIN REVERSIÓN DE COLORES ---
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: isActive
                                ? [
                                    BoxShadow(
                                      color: Colors.black26.withOpacity(0.4),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    )
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Widget para generar las estrellas ---
class StarRatingWidget extends StatelessWidget {
  final double rating;
  final Color color;

  const StarRatingWidget({
    super.key,
    required this.rating,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        double diff = rating - index;
        IconData iconData;

        // Lógica simplificada para mostrar estrellas completas, medias o vacías
        if (diff >= 0.75) {
          iconData = Icons.star;
        } else if (diff >= 0.25) {
          iconData = Icons.star_half;
        } else {
          iconData = Icons.star_border;
        }

        return Icon(
          iconData,
          color: color,
          size: 36.0,
        );
      }),
    );
  }
}

// --- Widget para el Modal de Fin de Juego (basado en la imagen) ---
class GameEndModal extends StatelessWidget {
  final int levelReached;
  final double starRating;
  final VoidCallback onRestart;
  final VoidCallback onMenu;
  final Color primaryPurple;
  final Color modalButtonColor;
  final Color starColor;

  const GameEndModal({
    super.key,
    required this.levelReached,
    required this.starRating,
    required this.onRestart,
    required this.onMenu,
    required this.primaryPurple,
    required this.modalButtonColor,
    required this.starColor,
  });

  String getLevelName(int level) {
    if (level >= 10) return "¡Leyenda!";
    if (level >= 7) return "Avanzado";
    if (level >= 4) return "Intermedio";
    return "Fácil";
  }

  @override
  Widget build(BuildContext context) {
    final String levelName = getLevelName(levelReached);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Título del modal
          Text(
            'Partida Terminada',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),

          // Descripción del nivel alcanzado
          Text(
            'Llegaste al nivel $levelReached ($levelName).',
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),

          // Estrellas de valoración
          StarRatingWidget(rating: starRating, color: starColor),
          const SizedBox(height: 20),

          // Pregunta de acción
          Text(
            '¿Quieres seguir jugando?',
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),

          // --- Botones de Acción ---

          // Botón principal: Jugar de nuevo
          ElevatedButton(
            onPressed: onRestart,
            style: ElevatedButton.styleFrom(
              backgroundColor: modalButtonColor,
              foregroundColor: const Color.fromARGB(255, 0, 0, 0),
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 4,
            ),
            child: const Text(
              'Sí, jugar de nuevo',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),

          // Botón secundario: Regresar al menú (texto, sin fondo)
          TextButton(
            onPressed: onMenu,
            child: Text(
              'Salir al menú',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
