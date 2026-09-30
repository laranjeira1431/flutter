import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../services/produto_service.dart';

class ProdutoProvider extends ChangeNotifier {
  final ProdutoService _service = ProdutoService();

  // Lista de produtos que a tela de estoque vai mostrar
  List<Produto> produtos = [];

  // Busca os produtos no banco e guarda na lista
  Future<void> carregarProdutos() async {
    produtos = await _service.listarProdutos();
    notifyListeners();
  }

  // Cadastra um produto novo e já recarrega a lista
  Future<void> cadastrarProduto(
    String nome,
    String categoria,
    int quantidade,
    double preco,
  ) async {
    final produto = Produto(
      nome: nome,
      categoria: categoria,
      quantidade: quantidade,
      preco: preco,
    );

    await _service.cadastrarProduto(produto);
    await carregarProdutos();
  }

  // Aumenta 1 na quantidade do produto
  Future<void> aumentarQuantidade(Produto produto) async {
    final nova = produto.quantidade + 1;
    await _service.alterarQuantidade(produto, nova);
    await carregarProdutos();
  }

  // Diminui 1 na quantidade do produto
  Future<void> diminuirQuantidade(Produto produto) async {
    final nova = produto.quantidade - 1;
    await _service.alterarQuantidade(produto, nova);
    await carregarProdutos();
  }

  // Exclui o produto
  Future<void> excluirProduto(Produto produto) async {
    await _service.excluirProduto(produto);
    await carregarProdutos();
  }
}
