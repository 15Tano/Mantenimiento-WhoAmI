import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/patients_service.dart';
import '../theme.dart';
import 'register_patient_page.dart';

class PatientsListPage extends StatefulWidget {
  const PatientsListPage({super.key});
  static const route = '/patients/list';

  @override
  State<PatientsListPage> createState() => _PatientsListPageState();
}

class _PatientsListPageState extends State<PatientsListPage> {
  final _searchCtrl = TextEditingController();
  late final PatientsService _svc;

  String get caregiverId => FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _svc = PatientsService(FirebaseFirestore.instance);
    _searchCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = _searchCtrl.text.trim().toLowerCase();

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Lista de pacientes'),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0.5,
          leading: IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // ===== Buscador + botón (+) =====
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchCtrl,
                            decoration: InputDecoration(
                              hintText: 'Buscar',
                              suffixIcon: _searchCtrl.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () => _searchCtrl.clear(),
                                    )
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton.filled(
                          style: IconButton.styleFrom(
                            backgroundColor: kPurple,
                            foregroundColor: kInk,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              RegisterPatientPage.route,
                            );
                            if (result == true && mounted) {
                              await showDialog(
                                context: context,
                                builder: (ctx) => _SuccessDialog(
                                  title: 'Hecho',
                                  message: 'Paciente agregado correctamente.',
                                ),
                              );
                              setState(() {});
                            }
                          },
                          icon: const Icon(Icons.add, size: 28),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // ===== Lista de pacientes =====
                    Expanded(
                      child: StreamBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
                        stream: _svc.streamPatientsOfCaregiver(caregiverId),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snap.hasError) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text('Error: ${snap.error}'),
                              ),
                            );
                          }

                          var docs = (snap.data ?? [])
                              .where((d) => (d.data()?['role'] ?? '') == 'Consultante')
                              .toList();

                          docs.sort((a, b) {
                            String n(DocumentSnapshot<Map<String, dynamic>> x) {
                              final m = x.data() ?? {};
                              return (m['displayName'] ??
                                      '${m['firstName'] ?? ''} ${m['lastName'] ?? ''}')
                                  .toString()
                                  .toLowerCase()
                                  .trim();
                            }

                            return n(a).compareTo(n(b));
                          });

                          if (q.isNotEmpty) {
                            docs = docs.where((d) {
                              final data = d.data() ?? {};
                              final name = ((data['displayName'] ??
                                      '${data['firstName'] ?? ''} ${data['lastName'] ?? ''}')
                                  .toString()
                                  .toLowerCase());
                              return name.contains(q);
                            }).toList();
                          }

                          if (docs.isEmpty) {
                            return const Center(child: Text('Sin pacientes'));
                          }

                          return ListView.separated(
                            itemCount: docs.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 8),
                            itemBuilder: (context, i) {
                              final data = docs[i].data()!;
                              final patientId = docs[i].id;
                              final name = (data['displayName'] ??
                                      '${data['firstName'] ?? ''} ${data['lastName'] ?? ''}')
                                  .toString()
                                  .trim();
                              final birthday = _fmtBirthday(data['birthday']);

                              return _PatientRow(
                                name: name.isEmpty ? 'Usuario' : name,
                                subtitle: birthday,
                                onRemove: () async {
                                  final ok = await showDialog<bool>(
                                    context: context,
                                    builder: (ctx) => _ConfirmRemoveDialog(name: name),
                                  );
                                  if (ok != true) return;

                                  try {
                                    await _svc.removePatientFromCaregiver(
                                      caregiverId: caregiverId,
                                      patientUserId: patientId,
                                    );

                                    if (mounted) {
                                      await showDialog(
                                        context: context,
                                        builder: (ctx) => _SuccessDialog(
                                          title: 'Hecho',
                                          message: 'Paciente desvinculado.',
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    if (mounted) {
                                      await showDialog(
                                        context: context,
                                        builder: (ctx) => _SuccessDialog(
                                          title: 'Error',
                                          message: e.toString(),
                                        ),
                                      );
                                    }
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _fmtBirthday(dynamic value) {
    if (value is Timestamp) {
      final d = value.toDate();
      final dd = d.day.toString().padLeft(2, '0');
      final mm = d.month.toString().padLeft(2, '0');
      final yy = d.year.toString();
      return '$dd/$mm/$yy';
    }
    if (value is String && value.isNotEmpty) return value;
    return '';
  }
}

// ===== DIALOGO DE CONFIRMACION =====
class _ConfirmRemoveDialog extends StatelessWidget {
  final String name;
  const _ConfirmRemoveDialog({required this.name});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFF4EDFB),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Desvincular paciente',
        style: TextStyle(color: kInk, fontWeight: FontWeight.w700),
      ),
      content: Text(
        '¿Quitar a "$name" de tu lista?\nPodrás vincularlo de nuevo después.',
        style: const TextStyle(color: kInk),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(
            'Cancelar',
            style: TextStyle(
              color: Color(0xFF6C4FA1), // 💜 Morado fuerte exacto de la segunda imagen
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Center(
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFFFB3B3), // rojo pastel
              foregroundColor: kInk,
              minimumSize: const Size(160, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Desvincular'),
          ),
        ),
      ],
    );
  }
}

// ===== DIALOGO DE EXITO =====
class _SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  const _SuccessDialog({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFF4EDFB),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(title, style: const TextStyle(color: kInk, fontWeight: FontWeight.w700)),
      content: Text(message, style: const TextStyle(color: kInk)),
      actions: [
        Center(
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: kPurple,
              foregroundColor: kInk,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ),
      ],
    );
  }
}

// ===== FILA DE PACIENTE =====
class _PatientRow extends StatefulWidget {
  const _PatientRow({
    required this.name,
    required this.subtitle,
    required this.onRemove,
  });

  final String name;
  final String subtitle;
  final Future<void> Function() onRemove;

  @override
  State<_PatientRow> createState() => _PatientRowState();
}

class _PatientRowState extends State<_PatientRow> {
  bool _busy = false;

  Future<void> _handleRemove() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await widget.onRemove();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                const SizedBox(height: 4),
                if (widget.subtitle.isNotEmpty)
                  Text(widget.subtitle, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          FilledButton.icon(
            onPressed: _busy ? null : _handleRemove,
            icon: _busy
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.link_off),
            label: Text(_busy ? 'Quitando…' : 'Desvincular'),
            style: FilledButton.styleFrom(
              minimumSize: const Size(150, 44),
              backgroundColor: const Color(0xFFFFB3B3),
              foregroundColor: Colors.black87,
              textStyle: const TextStyle(fontWeight: FontWeight.w700),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }
}
