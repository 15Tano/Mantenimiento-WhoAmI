import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.radius = 60});
  final double radius;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, authSnap) {
        final user = authSnap.data ?? FirebaseAuth.instance.currentUser;
        if (user == null) return _fallback(radius);
        final uid = user.uid;

        return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
          builder: (context, docSnap) {
            String? url;
            int? tsMs;

            if (docSnap.hasData && docSnap.data!.data() != null) {
              final data = docSnap.data!.data()!;
              url = (data['photoURL'] as String?)?.trim();
              final ts = data['photoUpdatedAt'];
              if (ts is Timestamp) tsMs = ts.millisecondsSinceEpoch;
            }

            url ??= user.photoURL;
            if (url == null || url.isEmpty) return _fallback(radius);

            final displayUrl = tsMs == null ? url : '$url?ts=$tsMs';
            return CircleAvatar(
              radius: radius,
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage(displayUrl),
            );
          },
        );
      },
    );
  }

  Widget _fallback(double r) => CircleAvatar(
        radius: r,
        backgroundColor: Colors.black,
        child: const Icon(Icons.person, color: Colors.white, size: 54),
      );
}
