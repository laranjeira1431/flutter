import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/produto_provider.dart';

class CadastroProdutoPage extends StatefulWidget {
  const CadastroProdutoPage({super.key});

  @override
  State<CadastroProdutoPage> createState() => _CadastroProdutoPageState();
}

class _CadastroProdutoPageState extends State<CadastroProdutoPage> {
  final nomeController = TextEditingController();
  final categoriaController = TextEditingController();
  final quantidadeController = TextEditingController();
  final precoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final produtoProvider = context.read<ProdutoProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Produto')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: categoriaController,
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: quantidadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantidade',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: precoController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  final nome = nomeController.text.trim();
                  final categoria = categoriaController.text.trim();

                  // int.tryParse devolve null se não for um número válido
                  // então usamos "?? 0" para não quebrar o app
                  final quantidade = int.tryParse(quantidadeController.text) ?? 0;

                  // trocamos vírgula por ponto, caso a pessoa digite "250,00"
                  final precoTexto = precoController.text.replaceAll(',', '.');
                  final preco = double.tryParse(precoTexto) ?? 0.0;

                  if (nome.isEmpty || categoria.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preencha nome e categoria.')),
                    );
                    return;
                  }

                  await produtoProvider.cadastrarProduto(
                    nome,
                    categoria,
                    quantidade,
                    preco,
                  );

                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('CADASTRAR PRODUTO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
