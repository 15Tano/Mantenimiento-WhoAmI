import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class QuickGuidesPage extends StatefulWidget {
  const QuickGuidesPage({super.key});
  static const route = '/quick-guides';

  @override
  State<QuickGuidesPage> createState() => _QuickGuidesPageState();
}

class _QuickGuidesPageState extends State<QuickGuidesPage> {
  // Colores de la app
  static const Color blue = Color(0xFF9ED3FF);
  static const Color text = Color(0xFF111111);

  final _tts = FlutterTts();
  final _rnd = Random();

  // --- Guías para cuidadores de Alzheimer ---
  final Map<String, List<String>> _guidesByCategory = {
    "Emergencias y señales de alerta": [
      "Si tu paciente se altera, ponle música que le guste para calmarlo.",
      "Si se desorienta en la calle, mantenlo acompañado y muéstrale objetos familiares.",
      "En caso de caída, revisa si puede moverse; si hay dolor fuerte, no lo levantes y busca ayuda médica.",
      "Ten siempre a la mano un kit con medicamentos, identificación y números de emergencia.",
      "Si notas fiebre, dificultad para respirar o cambios bruscos de conducta, contacta al médico de inmediato.",
    ],
    "Rutina diaria": [
      "Mantén horarios fijos para dormir, comer y bañarse; eso le da seguridad.",
      "Coloca siempre la ropa en el mismo lugar para que pueda identificarla.",
      "Divide actividades en pasos simples: ‘primero lávate las manos, luego siéntate’.",
      "Permite que participe en tareas fáciles como doblar ropa o regar plantas.",
      "Anticipa lo que van a hacer: avísale con calma lo que viene después.",
    ],
    "Comunicación": [
      "Háblale con frases cortas y claras, usando un tono calmado.",
      "Evita discutir o corregir; en su lugar, cambia de tema suavemente.",
      "Mantén contacto visual y usa gestos o señas cuando hables.",
      "Haz preguntas simples de sí o no para que le sea más fácil responder.",
      "Si no entiende una palabra, muéstrale un objeto o una imagen como apoyo.",
    ],
    "Seguridad en el hogar": [
      "Coloca candados o seguros en puertas que no debe abrir, como cocina o despensa.",
      "Ilumina bien pasillos y escaleras; la poca luz aumenta la desorientación.",
      "Retira objetos pequeños o alfombras que puedan provocar caídas.",
      "Pon etiquetas con dibujos en puertas y cajones: baño, cocina, ropa.",
      "Guarda objetos peligrosos como cuchillos, cerillos o productos de limpieza.",
    ],
    "Medicamentos": [
      "Organiza las pastillas en un pastillero semanal y usa alarmas para recordatorios.",
      "Explícale cada medicina con calma, mostrando el envase o pastillero.",
      "Apunta en una libreta los horarios de cada medicamento y verifica al final del día.",
      "Nunca cambies la dosis sin consultar al médico.",
      "Si notas somnolencia, mareos o malestar después de una medicina, notifícalo al doctor.",
    ],
    "Alimentación e hidratación": [
      "Ofrécele agua constantemente, incluso si dice que no tiene sed.",
      "Usa platos de colores para que identifique mejor la comida.",
      "Evita el ruido o la televisión durante las comidas para que se concentre.",
      "Corta los alimentos en trozos pequeños y fáciles de masticar.",
      "Si rechaza un plato, ofrece otro alimento que le guste en porciones pequeñas.",
    ],
    "Estimulación cognitiva y física": [
      "Muestra fotos familiares y repitan los nombres en voz alta juntos.",
      "Realiza caminatas cortas en lugares seguros, de 10 a 15 minutos diarios.",
      "Pon canciones conocidas y cántenlas juntos para estimular recuerdos.",
      "Jueguen memoramas, rompecabezas grandes o clasificar objetos por color.",
      "Practiquen respiraciones profundas por 2 minutos para relajarse.",
    ],
    "Autocuidado del cuidador": [
      "Si te sientes agotado, pide ayuda a un familiar o amigo antes de sobrecargarte.",
      "Tómate 10 minutos al día para ti: respira, escucha música o haz algo que disfrutes.",
      "No descuides tus horas de sueño; tu descanso es clave para cuidar mejor.",
      "Habla con otros cuidadores o busca un grupo de apoyo; compartir experiencias ayuda.",
      "Pedir ayuda no es debilidad: es parte del cuidado responsable.",
    ],
  };

  late final List<String> _categories;
  String _selected = "Aleatorias";
  List<String> _visible = const [];

  @override
  void initState() {
    super.initState();
    _categories = ["Aleatorias", ..._guidesByCategory.keys];
    _configureTts();
    _pickVisible();
  }

  Future<void> _configureTts() async {
    await _tts.setLanguage("es-MX");
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.5); // más lento para claridad
  }

  List<String> _poolFor(String c) =>
      c == "Aleatorias"
          ? _guidesByCategory.values.expand((e) => e).toList()
          : (_guidesByCategory[c] ?? const []);

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
      appBar: AppBar(
        title: const Text("Guías rápidas"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
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
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() => _selected = v);
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

            // Lista de guías
            Expanded(
              child: ListView.builder(
                itemCount: _visible.length,
                itemBuilder: (_, i) {
                  final guide = _visible[i];
                  return _GuideCard(
                    text: guide,
                    onTap: () => _speak(guide),
                  );
                },
              ),
            ),

            // Botón que resetea a Aleatorias siempre
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _selected = "Aleatorias"; // 👈 forzar a aleatorias
                  });
                  _pickVisible();
                },
                icon: const Icon(Icons.refresh),
                label: Text(
                  _selected == "Aleatorias"
                      ? "Mostrar otras guías"
                      : "Ver guías aleatorias",
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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _GuideCard({required this.text, required this.onTap});

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
            const Icon(Icons.health_and_safety, size: 22),
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
