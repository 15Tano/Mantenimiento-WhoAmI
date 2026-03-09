// lib/src/ui/screens/register_patient_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/patients_service.dart';
import '../theme.dart';

class RegisterPatientPage extends StatefulWidget {
  const RegisterPatientPage({super.key});
  static const route = '/patients/register';

  @override
  State<RegisterPatientPage> createState() => _RegisterPatientPageState();
}

class _RegisterPatientPageState extends State<RegisterPatientPage> {
  final _searchCtrl = TextEditingController();
  late final PatientsService _svc;

  String? get caregiverId => FirebaseAuth.instance.currentUser?.uid;
  String? _selectedPatientId;

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

  @override
  Widget build(BuildContext context) {
    if (caregiverId == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: kInk),
            onPressed: () => Navigator.maybePop(context),
          ),
          centerTitle: true,
          title: const Text(
            'Regístrate',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: kInk,
            ),
          ),
        ),
        body: const Center(child: Text('Inicia sesión para continuar')),
      );
    }

    final q = _searchCtrl.text;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kInk),
          onPressed: () => Navigator.maybePop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Regístrate',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: kInk,
          ),
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
                  const SizedBox(height: 12),

                  const Text(
                    'Registrar nuevo paciente',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kInk,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ===== Campo de búsqueda =====
                  TextField(
                    controller: _searchCtrl,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Buscar consultante',
                      suffixIcon: _searchCtrl.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => _searchCtrl.clear(),
                            )
                          : const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ===== Lista de consultantes =====
                  Expanded(
                    child: StreamBuilder<
                        List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                      stream: _svc.streamUnassignedConsultants(q: q),
                      builder: (context, snap) {
                        if (snap.hasError) {
                          return Center(child: Text('Error: ${snap.error}'));
                        }
                        if (snap.connectionState == ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final docs = snap.data ?? [];
                        if (docs.isEmpty) {
                          return const Center(child: Text('Sin resultados'));
                        }

                        return ListView.separated(
                          itemCount: docs.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, i) {
                            final data = docs[i].data();
                            if ((data['role'] ?? '') != 'Consultante') {
                              return const SizedBox.shrink();
                            }

                            final uid = docs[i].id;
                            final name = (data['displayName'] ??
                                    '${data['firstName'] ?? ''} ${data['lastName'] ?? ''}')
                                .toString()
                                .trim();
                            final birthday = _fmtBirthday(data['birthday']);

                            return _PatientResultTile(
                              name: name.isEmpty ? 'Usuario' : name,
                              subtitle: birthday,
                              selected: uid == _selectedPatientId,
                              onAdd: () {
                                setState(() {
                                  _selectedPatientId = uid;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ===== Botón Guardar =====
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            if (_selectedPatientId == null) return;
                            final id = caregiverId!;
                            try {
                              await _svc.addPatientToCaregiver(
                                caregiverId: id,
                                patientUserId: _selectedPatientId!,
                              );
                              if (!mounted) return;
                              _showDialog(context, 'Hecho',
                                  'Paciente agregado correctamente.');
                            } catch (e) {
                              if (!mounted) return;
                              _showDialog(context, 'Error', e.toString());
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: _selectedPatientId == null
                                  ? const Color(0xFFDCEEFF)
                                  : const Color(0xFF9ED3FF),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.save, size: 18, color: kInk),
                                SizedBox(width: 6),
                                Text(
                                  'Guardar',
                                  style: TextStyle(
                                    color: kInk,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // ===== Botón Cancelar =====
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: _selectedPatientId == null
                                  ? const Color(0xFFFFE4E4)
                                  : const Color(0xFFFFB3B3),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.cancel_outlined,
                                    size: 18, color: kInk),
                                SizedBox(width: 6),
                                Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    color: kInk,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFF4EDFB),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: const TextStyle(color: kInk, fontWeight: FontWeight.w700),
        ),
        content: Text(message, style: const TextStyle(color: kInk)),
        actions: [
          Center(
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: kPurple,
                foregroundColor: kInk,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                Navigator.of(ctx, rootNavigator: true).pop();
                Navigator.pop(context, true);
              },
              child: const Text('Aceptar'),
            ),
          ),
        ],
      ),
    );
  }
}

// ===== Tarjeta de resultado =====
class _PatientResultTile extends StatelessWidget {
  const _PatientResultTile({
    required this.name,
    required this.subtitle,
    required this.onAdd,
    required this.selected,
  });

  final String name;
  final String subtitle;
  final VoidCallback onAdd;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? kBlue.withOpacity(0.3) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? kBlue : Colors.black12,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.black54),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.check_circle,
              color: selected ? kBlue : Colors.grey.shade300,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}
