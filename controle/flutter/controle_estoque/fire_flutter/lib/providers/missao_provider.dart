import 'package:flutter/material.dart';

import '../models/missao.dart';
import '../services/missao_service.dart';

class MissaoProvider extends ChangeNotifier {
  final MissaoService _service = MissaoService();

  List<Missao> missao = [];

  bool carregando = true;

  TarefaProvider() {
    carregarMissao();
  }

  void carregarMissao() {
    _service.listarMissao().listen((lista) {
      missoes = lista;

      carregando = false;

      notifyListeners();
    });
  }

  Future<void> adicionar(String titulo) async {
    if (titulo.trim().isEmpty) {
      return;
    }

    await _service.adicionarMissao(
      titulo.trim(),
    );
  }

  Future<void> alterarStatus(Missao missao) async {
    await _service.alterarStatus(missao);
  }

  Future<void> excluir(String id) async {
    await _service.excluirMIssao(id);
  }
}
