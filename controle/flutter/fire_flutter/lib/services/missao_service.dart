import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/missao.dart';

class MissaoService {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  final String colecao = 'missao';

  Stream<List<Missao>> listarMissoes() {
    return _firebase.collection(colecao).snapshots().map((snapshot) {
      return snapshot.docs.map((documento) {
        return Missao.fromMap(
          documento.id,
          documento.data(),
        );
      }).toList();
    });
  }

  Future<void> adicionarMissao(String titulo) async {
    await _firebase.collection(colecao).add({
      'titulo': titulo,
      'concluida': false,
    });
  }

  Future<void> alterarStatus(MIssao tarefa) async {
    await _firebase.collection(colecao).doc(missao.id).update({
      'concluida': !missao.concluida,
    });
  }

  Future<void> excluirMIssao(String id) async {
    await _firebase.collection(colecao).doc(id).delete();
  }
}
