import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pemilu_pintar/common/widgets/message_util.dart';
import 'package:pemilu_pintar/models/user.dart';

const String DATA_PENDUKUNG_COLLECTION_REF = 'dataPendukung';

class DatabaseServices {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _dataPendukungRef;

  DatabaseServices() {
    _dataPendukungRef = _firestore
        .collection(DATA_PENDUKUNG_COLLECTION_REF)
        .withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
            toFirestore: (userData, _) => userData.toJson());
  }

  Stream<QuerySnapshot> getDataPendukung() {
    return _dataPendukungRef.snapshots();
  }

  void addDataPendukung(User user, BuildContext context) async {
    _dataPendukungRef
        .add(user)
        .then((value) => MessageUtil.showMessage(
            context, 'Data Berhasil ditambahkan', MessageType.normal))
        .catchError((error) => MessageUtil.showMessage(
            context, 'Gagal Menambahkan Data', MessageType.error));
  }
}
