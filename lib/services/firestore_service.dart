import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ev_station.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Stream<List<EVStation>> streamStations() {
    return _db.collection('ev_stations').snapshots().map((snap) {
      return snap.docs.map((d) => EVStation.fromMap(d.id, d.data())).toList();
    });
  }
}
