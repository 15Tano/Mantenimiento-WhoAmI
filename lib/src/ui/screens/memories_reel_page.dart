// lib/src/ui/screens/memories_reel_page.dart
// Responsable: Alan (UI) + Owen (lógica de carga)
// Reemplaza CalendarPage con scroll vertical tipo reels.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../theme.dart';

class MemoriesReelPage extends StatefulWidget {
  const MemoriesReelPage({super.key});
  static const route = '/memories/reel';

  @override
  State<MemoriesReelPage> createState() => _MemoriesReelPageState();
}

class _MemoriesReelPageState extends State<MemoriesReelPage> {
  List<Map<String, dynamic>> _memories = [];
  bool _loading = true;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _loadMemories();
  }

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  String _dateId(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> _loadMemories() async {
    if (_uid.isEmpty) return;
    setState(() => _loading = true);
    try {
      final snap = await FirebaseFirestore.instance
          .collection('memories')
          .doc(_uid)
          .collection('user_memories')
          .orderBy('dateId', descending: true)
          .get()
          .timeout(const Duration(seconds: 8));

      final list = snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
      if (mounted) setState(() { _memories = list; _loading = false; });
    } catch (_) {
      // Offline: intentar caché local de Firestore
      try {
        final snap = await FirebaseFirestore.instance
            .collection('memories')
            .doc(_uid)
            .collection('user_memories')
            .orderBy('dateId', descending: true)
            .get(const GetOptions(source: Source.cache));
        final list = snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
        if (mounted) {
          setState(() {
            _memories  = list;
            _loading   = false;
            _isOffline = true;
          });
        }
      } catch (_) {
        if (mounted) setState(() { _loading = false; _isOffline = true; });
      }
    }
  }

  // ── Agregar recuerdo ──────────────────────────────────────
  Future<void> _addMemory() async {
    final textCtrl = TextEditingController();
    File? selectedImage;

    await showModalBottomSheet(
      context             : context,
      isScrollControlled  : true,
      backgroundColor     : Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModal) => Container(
          padding: EdgeInsets.only(
            top   : 16,
            left  : 20,
            right : 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          decoration: const BoxDecoration(
            color       : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children    : [
              Container(
                width : 48,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color       : kFieldBorder,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Text(
                'Recuerdo de hoy — ${DateFormat("d 'de' MMMM", 'es').format(DateTime.now())}',
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w700, color: kInk),
              ),
              const SizedBox(height: 14),
              TextField(
                controller : textCtrl,
                maxLines   : 3,
                decoration : const InputDecoration(
                  hintText: '¿Qué pasó hoy?',
                ),
              ),
              const SizedBox(height: 12),

              // Imagen seleccionada
              if (selectedImage != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(selectedImage!,
                      height: 140, width: double.infinity,
                      fit: BoxFit.cover),
                ),
                const SizedBox(height: 10),
              ],

              // Botones de imagen
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _SheetButton(
                    color: kPurple,
                    icon : Icons.image_outlined,
                    label: 'Galería',
                    onTap: () async {
                      final f = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (f != null) setModal(() => selectedImage = File(f.path));
                    },
                  ),
                  _SheetButton(
                    color: kGreenPastel,
                    icon : Icons.camera_alt_outlined,
                    label: 'Cámara',
                    onTap: () async {
                      final f = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (f != null) setModal(() => selectedImage = File(f.path));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Guardar
              SizedBox(
                width : double.infinity,
                height: 50,
                child : FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: kBlue,
                    foregroundColor: kInk,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  icon : const Icon(Icons.save_outlined),
                  label: const Text('Guardar recuerdo',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15)),
                  onPressed: () async {
                    Navigator.pop(ctx);
                    await _saveMemory(textCtrl.text.trim(), selectedImage);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveMemory(String text, File? image) async {
    if (_uid.isEmpty) return;
    final today  = DateTime.now();
    final dateId = _dateId(today);

    String? imageUrl;
    if (image != null) {
      try {
        final ref = FirebaseStorage.instance
            .ref()
            .child('diary_images/$_uid/$dateId.jpg');
        final task = await ref.putFile(image);
        imageUrl = await task.ref.getDownloadURL();
      } catch (_) {}
    }

    await FirebaseFirestore.instance
        .collection('memories')
        .doc(_uid)
        .collection('user_memories')
        .doc(dateId)
        .set({
      'text'     : text,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'dateId'   : dateId,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await _loadMemories();
  }

  // ── Build ─────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      appBar: AppBar(
        backgroundColor  : const Color(0xFF0F0F1A),
        foregroundColor  : Colors.white,
        elevation        : 0,
        surfaceTintColor : Colors.transparent,
        title: const Text('Mis Recuerdos',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        actions: [
          if (_isOffline)
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child  : Icon(Icons.wifi_off_rounded,
                  color: Colors.amber, size: 20),
            ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed  : _addMemory,
        backgroundColor: kPurple,
        foregroundColor: kInk,
        icon       : const Icon(Icons.add_photo_alternate_outlined),
        label      : const Text('Agregar',
            style: TextStyle(fontWeight: FontWeight.w700)),
      ),

      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: kPurple))
          : _memories.isEmpty
              ? _EmptyState(onAdd: _addMemory)
              : PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount      : _memories.length,
                  itemBuilder    : (context, i) =>
                      _MemoryCard(memory: _memories[i]),
                ),
    );
  }
}

// ─── Tarjeta de recuerdo (reel) ───────────────────────────────
class _MemoryCard extends StatelessWidget {
  const _MemoryCard({required this.memory});
  final Map<String, dynamic> memory;

  @override
  Widget build(BuildContext context) {
    final dateId   = memory['id'] as String? ?? '';
    final text     = memory['text'] as String? ?? '';
    final imageUrl = memory['imageUrl'] as String?;

    // Parsear fecha del id "2025-03-15"
    String dateLabel = dateId;
    try {
      final parts = dateId.split('-');
      if (parts.length == 3) {
        final dt = DateTime(
            int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
        dateLabel =
            DateFormat("d 'de' MMMM 'de' y", 'es').format(dt);
      }
    } catch (_) {}

    return Stack(
      fit: StackFit.expand,
      children: [
        // Imagen de fondo (si existe)
        if (imageUrl != null)
          Image.network(
            imageUrl,
            fit       : BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: const Color(0xFF1A1A2E)),
          )
        else
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin  : Alignment.topLeft,
                end    : Alignment.bottomRight,
                colors : [Color(0xFF1A1A2E), Color(0xFF16213E)],
              ),
            ),
          ),

        // Overlay degradado para legibilidad
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin : Alignment.topCenter,
              end   : Alignment.bottomCenter,
              colors: [Colors.transparent, Color(0xCC000000)],
              stops : [0.4, 1.0],
            ),
          ),
        ),

        // Contenido de texto
        Positioned(
          left  : 24,
          right : 24,
          bottom: 80,
          child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize      : MainAxisSize.min,
            children          : [
              // Fecha
              Container(
                padding   : const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color       : kPurple.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  dateLabel,
                  style: const TextStyle(
                    fontSize  : 13,
                    fontWeight: FontWeight.w700,
                    color     : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Texto del recuerdo
              if (text.isNotEmpty)
                Text(
                  text,
                  style: const TextStyle(
                    fontSize  : 22,
                    fontWeight: FontWeight.w600,
                    color     : Colors.white,
                    height    : 1.4,
                    shadows   : [
                      Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 6,
                          color: Colors.black54),
                    ],
                  ),
                  maxLines : 6,
                  overflow : TextOverflow.ellipsis,
                ),

              // Indicador "desliza"
              const SizedBox(height: 20),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.swipe_vertical_rounded,
                      color: Colors.white54, size: 16),
                  SizedBox(width: 6),
                  Text('Desliza para ver más',
                      style: TextStyle(
                          color: Colors.white54, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Estado vacío ─────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children    : [
          const Icon(Icons.photo_album_outlined,
              size: 80, color: Colors.white24),
          const SizedBox(height: 20),
          const Text(
            'Aún no hay recuerdos',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w700,
                color: Colors.white70),
          ),
          const SizedBox(height: 8),
          const Text(
            'Agrega el primero tocando el botón',
            style: TextStyle(color: Colors.white38, fontSize: 14),
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed      : onAdd,
            style          : FilledButton.styleFrom(
              backgroundColor: kPurple,
              foregroundColor: kInk,
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            icon : const Icon(Icons.add_photo_alternate_outlined),
            label: const Text('Agregar primer recuerdo',
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 15)),
          ),
        ],
      ),
    );
  }
}

// ─── Botón del bottom sheet ───────────────────────────────────
class _SheetButton extends StatelessWidget {
  const _SheetButton({
    required this.color,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Color    color;
  final IconData icon;
  final String   label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style    : ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: kInk,
        shape: const StadiumBorder(),
        padding         : const EdgeInsets.symmetric(
            horizontal: 20, vertical: 12),
        elevation: 0,
      ),
      icon : Icon(icon, size: 18),
      label: Text(label,
          style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
