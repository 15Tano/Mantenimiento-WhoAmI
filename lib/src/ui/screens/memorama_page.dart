import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import '../theme.dart';

const kPauseColor = Color(0xFFFF9FA3);
const kPurpleStrong = Color(0xFF7A1FA2);

class MemoramaPage extends StatefulWidget {
  const MemoramaPage({super.key});
  static const route = '/games/memorama';

  @override
  State<MemoramaPage> createState() => _MemoramaPageState();
}

class _MemoramaPageState extends State<MemoramaPage>
    with TickerProviderStateMixin {
  final List<IconData> _icons = const [
    Icons.favorite,
    Icons.star,
    Icons.pets,
    Icons.coffee,
    Icons.flash_on,
    Icons.face,
    Icons.catching_pokemon,
    Icons.rocket_launch,
    Icons.apple,
    Icons.sports_basketball,
    Icons.flight,
    Icons.icecream,
  ];

  late List<int> _cards;
  late List<bool> _revealed;
  int? _firstIndex;

  bool _waiting = false;
  bool _started = false;
  bool _paused = false;

  int _moves = 0;
  int _seconds = 0;
  int _score = 0;
  Timer? _timer;
  String? _level;

  final Map<String, int> _starsPerLevel = {};

  late final AnimationController _bannerCtrl;
  late final Animation<double> _bannerOpacity;
  late final Animation<Offset> _bannerSlide;
  bool _showBanner = false;
  String _bannerText = '';

  late final ConfettiController _confettiCtrl;

  @override
  void initState() {
    super.initState();
    _bannerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 250),
    );
    _bannerOpacity = CurvedAnimation(
      parent: _bannerCtrl,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
    _bannerSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _bannerCtrl,
      curve: Curves.decelerate,
      reverseCurve: Curves.easeIn,
    ));
    _confettiCtrl = ConfettiController(duration: const Duration(seconds: 4));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _bannerCtrl.dispose();
    _confettiCtrl.dispose();
    super.dispose();
  }

  // ====== Confirmar salida si hay partida ======
  Future<void> _confirmExitGame() async {
    if (!_started) {
      _goToGamesMenuClearingGame();
      return;
    }

    final salir = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          '¿Estás seguro que quieres salir?',
          style: TextStyle(color: kInk, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Perderás tu partida actual.',
          style: TextStyle(color: kInk),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: TextButton.styleFrom(
              backgroundColor: kBlue,
              foregroundColor: kInk,
            ),
            child: const Text('No, continuar jugando'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              backgroundColor: kPauseColor,
              foregroundColor: kInk,
            ),
            child: const Text('Sí, salir'),
          ),
        ],
      ),
    );

    if (salir == true) _goToGamesMenuClearingGame();
  }

  void _goToGamesMenuClearingGame() {
    _timer?.cancel();
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/games',
      (route) =>
          route.isFirst ||
          route.settings.name == '/home/caregiver' ||
          route.settings.name == '/home/consultant',
    );
  }

  // ====== Configuración de niveles ======
  int get _gridSize {
    switch (_level) {
      case 'Medio':
        return 4;
      case 'Difícil':
        return 6;
      default:
        return 3;
    }
  }

  int get _pairCount {
    switch (_level) {
      case 'Medio':
        return 8;
      case 'Difícil':
        return 12;
      default:
        return 4;
    }
  }

  // ====== Juego ======
  void _startGame() {
    if (_level == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona un nivel antes de iniciar.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final base = List.generate(_pairCount, (i) => i);
    _cards = [...base, ...base]..shuffle(Random());
    _revealed = List<bool>.filled(_cards.length, false);
    _firstIndex = null;
    _waiting = false;
    _moves = 0;
    _seconds = 0;
    _score = 0;
    _paused = false;
    _started = true;

    _showLevelBanner('Nivel $_level iniciado');
    _timer?.cancel();
    _startTimer();
    setState(() {});
  }

  void _resetGame() => _startGame();

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && _started && !_paused) {
        setState(() => _seconds++);
      }
    });
  }

  void _pauseGame() {
    setState(() => _paused = !_paused);
    if (_paused) {
      _timer?.cancel();
      _showPauseDialog();
    } else {
      _startTimer();
    }
  }

  Future<void> _onCardTap(int index) async {
    if (!_started || _paused || _waiting || _revealed[index]) return;

    setState(() => _revealed[index] = true);

    if (_firstIndex == null) {
      _firstIndex = index;
      return;
    }

    _moves++;
    if (_cards[_firstIndex!] != _cards[index]) {
      _waiting = true;
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      setState(() {
        _revealed[_firstIndex!] = false;
        _revealed[index] = false;
      });
      _waiting = false;
    } else {
      _score++;
    }

    _firstIndex = null;

    if (_revealed.every((r) => r)) {
      _timer?.cancel();
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;
      _showWinDialog();
    } else {
      if (mounted) setState(() {});
    }
  }

  // ====== Diálogo de pausa ======
  void _showPauseDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Juego en pausa',
            style: TextStyle(color: kInk, fontWeight: FontWeight.bold)),
        content: const Text('Puedes continuar o reiniciar el juego.',
            style: TextStyle(color: kInk)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pauseGame();
            },
            style: TextButton.styleFrom(
              backgroundColor: kBlue,
              foregroundColor: kInk,
            ),
            child: const Text('Continuar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetGame();
            },
            style: TextButton.styleFrom(
              backgroundColor: kPauseColor,
              foregroundColor: kInk,
            ),
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
  }

  // ====== Cálculo de estrellas ======
  int _computeStars() {
    if (_level == 'Fácil') {
      if (_seconds <= 25 && _moves <= 10) return 3;
      if (_seconds <= 40 && _moves <= 15) return 2;
      if (_seconds <= 60 || _moves <= 20) return 1;
    } else if (_level == 'Medio') {
      if (_seconds <= 40 && _moves <= 14) return 3;
      if (_seconds <= 60 && _moves <= 18) return 2;
      if (_seconds <= 90 || _moves <= 24) return 1;
    } else if (_level == 'Difícil') {
      if (_seconds <= 60 && _moves <= 18) return 3;
      if (_seconds <= 90 && _moves <= 24) return 2;
      if (_seconds <= 120 || _moves <= 30) return 1;
    }
    return 0;
  }

  // ====== Nivel completado ======
  void _showWinDialog() {
    final stars = _computeStars();
    _starsPerLevel[_level ?? ''] = stars;

    String? nextLevel;
    if (_level == 'Fácil') nextLevel = 'Medio';
    else if (_level == 'Medio') nextLevel = 'Difícil';

    if (nextLevel == null) {
      _showFinalAverageDialog();
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Nivel completado',
            style:
                TextStyle(color: kInk, fontWeight: FontWeight.bold, fontSize: 20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Completaste el nivel $_level en $_moves movimientos y ${_seconds}s.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: kInk),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Icon(Icons.star_rounded,
                    size: 34, color: i < stars ? Colors.amber : Colors.grey[300]),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '¿Quieres jugar de nuevo este nivel?',
              textAlign: TextAlign.center,
              style: TextStyle(color: kInk, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetGame();
            },
            style: TextButton.styleFrom(
              backgroundColor: kPurple,
              foregroundColor: kInk,
            ),
            child: const Text('Sí, jugar de nuevo'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _level = nextLevel);
              _startGame();
            },
            child: const Text('Continuar al siguiente nivel',
                style:
                    TextStyle(color: kPurpleStrong, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _goToGamesMenuClearingGame();
            },
            child: const Text('Salir al menú', style: TextStyle(color: kInk)),
          ),
        ],
      ),
    );
  }

  // ====== Promedio final ======
  void _showFinalAverageDialog() {
    _confettiCtrl.play();

    final totalStars = _starsPerLevel.values.fold<int>(0, (a, b) => a + b);
    final avg = totalStars / _starsPerLevel.length;
    final fullStars = avg.floor();
    final hasHalf = avg - fullStars >= 0.5;

    String feedback;
    if (avg >= 2.5) {
      feedback = 'Excelente desempeño, has logrado dominar el juego.';
    } else if (avg >= 1.5) {
      feedback = 'Buen trabajo, tu memoria está mejorando.';
    } else {
      feedback = 'Sigue practicando, puedes hacerlo mejor.';
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiCtrl,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: 0.08,
              numberOfParticles: 14,
              maxBlastForce: 25,
              minBlastForce: 10,
              gravity: 0.25,
              shouldLoop: true,
              colors: const [kPurple, kBlue, Colors.amber, Colors.white],
            ),
          ),
          Center(
            child: Container(
              width: 330,
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: kBlue, width: 2),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Has completado los tres niveles',
                    style: TextStyle(
                      color: kInk,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Estrellas por nivel
                  Column(
                    children: _starsPerLevel.entries.map((entry) {
                      final stars = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${entry.key}: ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kInk,
                              ),
                            ),
                            Row(
                              children: List.generate(
                                3,
                                (i) => Icon(
                                  Icons.star_rounded,
                                  color: i < stars
                                      ? Colors.amber
                                      : Colors.grey[300],
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  const Divider(thickness: 1, color: Colors.black12),
                  const SizedBox(height: 8),

                  const Text(
                    'Estrellas finales',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kInk),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < fullStars; i++)
                        const Icon(Icons.star_rounded,
                            color: Colors.amber, size: 34),
                      if (hasHalf)
                        const Icon(Icons.star_half_rounded,
                            color: Colors.amber, size: 34),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Text(
                    feedback,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: kInk,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  const SizedBox(height: 25),
                  TextButton(
                    onPressed: () {
                      _confettiCtrl.stop();
                      _goToGamesMenuClearingGame();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: kPurple,
                      foregroundColor: kInk,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text(
                      'Volver al menú de juegos',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ====== Banner ======
  Future<void> _showLevelBanner(String text) async {
    setState(() {
      _bannerText = text;
      _showBanner = true;
    });
    await _bannerCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    await _bannerCtrl.reverse();
    if (!mounted) return;
    setState(() => _showBanner = false);
  }

  // ====== UI ======
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(icon: const Icon(Icons.arrow_back), onPressed: _confirmExitGame),
        title: const Text('Memorama'),
        backgroundColor: Colors.white,
        foregroundColor: kInk,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SafeArea(child: !_started ? _buildMenuInicio() : _buildGameUI()),
          if (_showBanner)
            FadeTransition(
              opacity: _bannerOpacity,
              child: SlideTransition(
                position: _bannerSlide,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: kBlue, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _bannerText,
                    style: const TextStyle(
                        color: kInk, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuInicio() {
    return Center(
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kBlue, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Comienza tu juego',
                style:
                    TextStyle(color: kInk, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _level,
              decoration: InputDecoration(
                labelText: 'Selecciona el nivel',
                labelStyle: const TextStyle(color: kInk),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: const [
                DropdownMenuItem(value: 'Fácil', child: Text('Fácil')),
                DropdownMenuItem(value: 'Medio', child: Text('Medio')),
                DropdownMenuItem(value: 'Difícil', child: Text('Difícil')),
              ],
              onChanged: (v) => setState(() => _level = v),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: _level == null ? null : _startGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: kBlue,
                foregroundColor: kInk,
              ),
              child: const Text('Iniciar juego'),
            ),
          ],
        ),
      ),
    );
  }

  // ====== Cartas responsivas ======
  Widget _buildGameUI() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossCount = _gridSize;
        final spacing = 8.0;
        final totalSpacing = spacing * (crossCount + 1);
        final availableWidth = constraints.maxWidth - totalSpacing;
        final cardSize = availableWidth / crossCount;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Movimientos: $_moves',
                            style: const TextStyle(
                                color: kInk, fontWeight: FontWeight.w600)),
                        Text('Pares: $_score',
                            style: const TextStyle(
                                color: kInk, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Text(_formatTime(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: kInk)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _cards.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossCount,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (_, i) {
                    final isUp = _revealed[i];
                    final icon = _icons[_cards[i] % _icons.length];
                    return SizedBox.square(
                      dimension: cardSize,
                      child: InkWell(
                        onTap: () => _onCardTap(i),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isUp
                                ? kBlue.withOpacity(0.9)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color:
                                    isUp ? kPurple : Colors.black26, width: 2),
                          ),
                          child: Center(
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: isUp ? 1 : 0,
                              child: Icon(icon,
                                  size: cardSize * 0.45, color: kInk),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _resetGame,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPurple,
                      foregroundColor: kInk,
                      minimumSize: const Size(140, 48),
                    ),
                    child: const Text('Reiniciar'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _pauseGame,
                    icon: const Icon(Icons.pause),
                    label: const Text('Pausa'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPauseColor,
                      foregroundColor: kInk,
                      minimumSize: const Size(140, 48),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatTime() {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}
