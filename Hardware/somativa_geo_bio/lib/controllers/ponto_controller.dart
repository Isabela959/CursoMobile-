import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/point.dart';

class PointController {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  // pegar usuário logado
  User? get currentUser => _auth.currentUser;

  // registrar ponto
  Future<void> addPoint(Point point) async {
    if (currentUser == null) return;

    await _db
        .collection("usuarios")
        .doc(currentUser!.uid)
        .collection("pontos")
        .doc(point.id)
        .set(point.toMap());
  }

  // remover ponto 
  Future<void> removePoint(String pointId) async {
    if (currentUser == null) return;

    await _db
        .collection("usuarios")
        .doc(currentUser!.uid)
        .collection("pontos")
        .doc(pointId)
        .delete();
  }

  // buscar histórico de pontos
  Stream<List<Point>> getPoints() {
    if (currentUser == null) return Stream.value([]);

    return _db
        .collection("usuarios")
        .doc(currentUser!.uid)
        .collection("pontos")
        .orderBy("dataHora", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Point.fromMap(doc.data()))
            .toList());
  }
}
