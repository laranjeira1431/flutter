// ViewModel - fica no meio do caminho entre a View e o Service
// Ela guarda a lista de filmes na memória, mas quem garante que os
// dados não somem é o Service (SQLite), não essa lista aqui

import 'package:flutter/material.dart';
import '../models/filme.dart';
import '../services/filme_service.dart';

class FilmeViewModel extends ChangeNotifier {
  final FilmeService _service = FilmeService();

  List<Filme> filmes = [];

  // busca os filmes lá no banco e atualiza a tela
  Future<void> carregarFilmes() async {
    filmes = await _service.listarFilmes();
    notifyListeners(); // avisa a View que a lista mudou
  }

  // cadastra um filme novo
  Future<void> adicionarFilme(String titulo) async {
    if (titulo.trim().isEmpty) {
      return; // não deixa cadastrar filme com nome vazio
    }

    Filme novoFilme = Filme(titulo: titulo, assistido: false);

    await _service.inserirFilme(novoFilme);

    // depois de inserir, busca a lista atualizada direto do banco
    await carregarFilmes();
  }

  // troca o status de assistido (marca/desmarca)
  Future<void> alterarStatus(Filme filme) async {
    filme.assistido = !filme.assistido;

    await _service.atualizarStatus(filme);

    await carregarFilmes();
  }
}
