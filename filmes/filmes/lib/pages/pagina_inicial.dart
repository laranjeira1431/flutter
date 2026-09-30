// View - aqui é só interface, nada de SQLite direto aqui
// tudo que precisa ser feito passa pela ViewModel

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/filme_viewmodel.dart';
import '../models/filme.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // quando a tela abre, já busca os filmes que estão salvos no SQLite
    Future.microtask(() {
      final viewModel = Provider.of<FilmeViewModel>(context, listen: false);
      viewModel.carregarFilmes();
    });
  }

  @override
  Widget build(BuildContext context) {
    // aqui a gente "escuta" a ViewModel, então sempre que ela chamar
    // notifyListeners(), essa tela é redesenhada sozinha
    final viewModel = Provider.of<FilmeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Lista de Filmes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Digite o nome do filme',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                viewModel.adicionarFilme(_controller.text);
                _controller.clear();
              },
              child: const Text('Adicionar'),
            ),

            const SizedBox(height: 20),

            // lista de filmes
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.filmes.length,
                itemBuilder: (context, index) {
                  Filme filme = viewModel.filmes[index];

                  return ListTile(
                    leading: Text('${index + 1}'),
                    title: Text(
                      filme.titulo,
                      style: TextStyle(
                        // se já assistiu, o texto fica riscado
                        decoration: filme.assistido
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Checkbox(
                      value: filme.assistido,
                      onChanged: (valorNovo) {
                        viewModel.alterarStatus(filme);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
