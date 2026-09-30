import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/produto.dart';
import '../providers/produto_provider.dart';

class EstoquePage extends StatefulWidget {
  const EstoquePage({super.key});

  @override
  State<EstoquePage> createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  @override
  void initState() {
    super.initState();

    // Assim que a tela abre, já busca os produtos no banco.
    // Usamos "Future.microtask" para poder chamar o provider
    // logo no início, sem dar erro.
    Future.microtask(() {
      context.read<ProdutoProvider>().carregarProdutos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final produtoProvider = context.watch<ProdutoProvider>();
    final produtos = produtoProvider.produtos;

    return Scaffold(
      appBar: AppBar(title: const Text('Estoque')),
      body: produtos.isEmpty
          ? const Center(child: Text('Nenhum produto cadastrado ainda.'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: produtos.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final produto = produtos[index];
                return _CardProduto(produto: produto);
              },
            ),
    );
  }
}

// Um "cartãozinho" para mostrar cada produto da lista
class _CardProduto extends StatelessWidget {
  final Produto produto;

  const _CardProduto({required this.produto});

  @override
  Widget build(BuildContext context) {
    final produtoProvider = context.read<ProdutoProvider>();

    // Regra do estoque baixo: quantidade menor ou igual a 3
    final estoqueBaixo = produto.quantidade <= 3;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              produto.nome,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(produto.categoria),
            Text('R\$ ${produto.preco.toStringAsFixed(2)}'),

            if (estoqueBaixo)
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  'ESTOQUE BAIXO',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),

            const SizedBox(height: 8),

            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    produtoProvider.diminuirQuantidade(produto);
                  },
                ),
                Text(
                  'Quantidade: ${produto.quantidade}',
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    produtoProvider.aumentarQuantidade(produto);
                  },
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    produtoProvider.excluirProduto(produto);
                  },
                  child: const Text('EXCLUIR', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
