import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_caregiver.dart';
import 'home_consultant.dart';
import 'home_patient.dart'; // ← AÑADIR ESTE IMPORT

class HomeRouter extends StatelessWidget {
  const HomeRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        final data = snap.data!.data() ?? {};
        final role = (data['role'] as String?)?.trim() ?? 'Consultante';

        // ← REEMPLAZAR el ternario por este switch
        return switch (role) {
          'Cuidador' => const HomeCaregiverPage(),
          'Consultante' => const HomePatientPage(),
          _ => const HomeConsultantPage(),
        };
      },
    );
  }
}
