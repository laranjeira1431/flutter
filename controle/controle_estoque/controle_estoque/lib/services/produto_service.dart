import '../models/produto.dart';
import 'banco_dados.dart';

// Essa classe conversa com o SQLite para tudo que for produto:
// cadastrar, listar, alterar quantidade e excluir.
class ProdutoService {
  // Salva um produto novo -> INSERT
  Future<void> cadastrarProduto(Produto produto) async {
    final db = await BancoDados.getBanco();

    await db.insert('produtos', produto.toMap());

    print('INSERT -> Produto cadastrado: ${produto.nome}');
  }

  // Busca todos os produtos -> SELECT
  Future<List<Produto>> listarProdutos() async {
    final db = await BancoDados.getBanco();

    final resultado = await db.query('produtos');

    print('SELECT -> Produtos encontrados:');
    for (final linha in resultado) {
      print(linha);
    }

    // Transforma cada Map em um Produto
    return resultado.map((linha) => Produto.fromMap(linha)).toList();
  }

  // Altera a quantidade de um produto -> UPDATE
  Future<void> alterarQuantidade(Produto produto, int novaQuantidade) async {
    final db = await BancoDados.getBanco();

    // Não deixa a quantidade ficar negativa
    if (novaQuantidade < 0) {
      novaQuantidade = 0;
    }

    print('UPDATE -> ${produto.nome}');
    print('Quantidade anterior: ${produto.quantidade}');
    print('Nova quantidade: $novaQuantidade');

    await db.update(
      'produtos',
      {'quantidade': novaQuantidade},
      where: 'id = ?',
      whereArgs: [produto.id],
    );
  }

  // Apaga um produto -> DELETE
  Future<void> excluirProduto(Produto produto) async {
    final db = await BancoDados.getBanco();

    await db.delete(
      'produtos',
      where: 'id = ?',
      whereArgs: [produto.id],
    );

    print('DELETE -> Produto excluido: ${produto.nome}');
  }

  // Função extra, só para conferir no terminal se os dados
  // realmente estão salvos no banco
  Future<void> mostrarProdutosNoTerminal() async {
    final db = await BancoDados.getBanco();

    final produtos = await db.query('produtos');

    print('===== PRODUTOS NO BANCO =====');
    for (final produto in produtos) {
      print(produto);
    }
  }
}
