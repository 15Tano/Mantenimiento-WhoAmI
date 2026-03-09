import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MotivationalPhrasesPage extends StatefulWidget {
  const MotivationalPhrasesPage({super.key});
  static const route = '/motivational-phrases';

  @override
  State<MotivationalPhrasesPage> createState() => _MotivationalPhrasesPageState();
}

class _MotivationalPhrasesPageState extends State<MotivationalPhrasesPage> {
  // Colores base
  static const Color blue = Color(0xFF9ED3FF);
  static const Color text = Color(0xFF111111);

  final _tts = FlutterTts();
  final _rnd = Random();

  // ================== 40 FRASES (agrupadas) ==================
  final Map<String, List<String>> _phrasesByCategory = {
    "Ánimo diario": [
      "Hoy es un buen día para intentarlo con calma.",
      "Paso a pasito, lo estoy haciendo bien.",
      "Puedo aprender algo pequeño hoy.",
      "Mi esfuerzo de hoy cuenta y vale.",
      "Respiro hondo y sigo adelante.",
      "Soy más fuerte de lo que pienso.",
      "Cada momento es una nueva oportunidad.",
      "Hago lo mejor que puedo y eso está bien.",
    ],
    "Calma y respiración": [
      "Respiro lento tres veces y siento paz.",
      "Puedo pausar un momento y descansar.",
      "Mi cuerpo se relaja cuando respiro suave.",
      "Puedo tomarme mi tiempo, no hay prisa.",
      "Si me confundo, respiro y vuelvo a empezar.",
      "La calma llega cuando escucho mi respiración.",
      "Estoy a salvo aquí y ahora.",
      "Puedo soltar la tensión de mis hombros y seguir.",
    ],
    "Memoria e identidad": [
      "Mi nombre es importante y vale mucho.",
      "Hay recuerdos bonitos guardados en mi corazón.",
      "Puedo pedir ayuda cuando la necesito.",
      "Lo que soy no se pierde: sigo siendo yo.",
      "Cada día puedo recordar algo sencillo.",
      "Soy valioso para mi familia y para mí.",
      "Puedo mirar una foto y sonreír.",
      "Mi historia sigue, paso a paso.",
    ],
    "Autonomía y pequeños logros": [
      "Hoy puedo lograr una tarea sencilla.",
      "Si no sale a la primera, lo intento de nuevo.",
      "Puedo seguir instrucciones cortas y claras.",
      "Un pequeño logro es un gran avance.",
      "Puedo organizar mis cosas con ayuda.",
      "Mi ritmo es perfecto para mí.",
      "Celebro lo que sí pude hacer hoy.",
      "Puedo pedir indicaciones y seguirlas.",
    ],
    "Afecto y compañía": [
      "No estoy solo: hay gente que me quiere.",
      "Puedo pedir un abrazo cuando lo necesite.",
      "Mi voz es escuchada con cariño.",
      "Caminar acompañado me hace bien.",
      "Gracias por cuidar de mí; yo también cuido de mí.",
      "Puedo sonreír y agradecer las cosas simples.",
      "Juntos es más fácil y más bonito.",
      "La ternura también es una fuerza.",
    ],
  };
  // ================== FIN FRASES ==================

  late final List<String> _categories;
  String _selected = "Aleatorias";
  List<String> _visible = const [];

  @override
  void initState() {
    super.initState();
    _categories = ["Aleatorias", ..._phrasesByCategory.keys];
    _configureTts();
    _pickVisible();
  }

  Future<void> _configureTts() async {
    await _tts.setLanguage("es-MX");
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.5); // ritmo claro
  }

  List<String> _poolFor(String category) {
    if (category == "Aleatorias") {
      return _phrasesByCategory.values.expand((x) => x).toList();
    }
    return _phrasesByCategory[category] ?? const [];
  }

  void _pickVisible() {
    final pool = _poolFor(_selected);
    final copy = List<String>.from(pool)..shuffle(_rnd);
    setState(() {
      _visible = copy.take(5).toList();
    });
  }

  Future<void> _speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          AppBar(title: const Text("Frases motivadoras"), centerTitle: true, elevation: 0),
      body: Padding(
        // un poco más de padding inferior para “subir” el botón
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 58), // 👈 ajustado
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Selecciona una categoría",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: 38,
                  width: 220,
                  child: DropdownButtonHideUnderline(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selected,
                          items: _categories
                              .map((c) => DropdownMenuItem(
                                    value: c,
                                    child: Text(
                                      c == "Aleatorias"
                                          ? "— Mostrar aleatorias —"
                                          : c,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            if (val == null) return;
                            setState(() => _selected = val);
                            _pickVisible();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Lista de frases
            Expanded(
              child: ListView.builder(
                itemCount: _visible.length,
                itemBuilder: (_, i) {
                  final phrase = _visible[i];
                  return _PhraseCard(
                    text: phrase,
                    onTap: () => _speak(phrase),
                  );
                },
              ),
            ),

            // Botón: cambia automáticamente a “Aleatorias”
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _selected = "Aleatorias"; // 👈 forzar categoría
                  });
                  _pickVisible();
                },
                icon: const Icon(Icons.refresh),
                label: Text(
                  _selected == "Aleatorias"
                      ? "Mostrar otras frases"
                      : "Ver frases aleatorias",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: text,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhraseCard extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _PhraseCard({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF9ED3FF), Color(0xFFE9F6FF)],
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              offset: Offset(0, 2),
              color: Color(0x22000000),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.format_quote, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 15.5),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.volume_up, size: 20),
          ],
        ),
      ),
    );
  }
}
