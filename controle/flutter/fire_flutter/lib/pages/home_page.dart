import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/missao_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController tarefaController = TextEditingController();

  @override
  void dispose() {
    missaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minhas Missões',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: missaoController,
              decoration: const InputDecoration(
                labelText: 'Digite uma missão',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final provider = context.read<MissaoProvider>();

                  await provider.adicionar(
                    missaoController.text,
                  );

                  missaoController.clear();
                },
                child: const Text(
                  'Adicionar missão',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<MIssaoProvider>(
                builder: (
                  context,
                  provider,
                  child,
                ) {
                  if (provider.carregando) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (provider.missoes.isEmpty) {
                    return const Center(
                      child: Text(
                        'Nenhuma missão cadastrada.',
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: provider.missoes.length,
                    itemBuilder: (context, index) {
                      final missao = provider.missoes[index];

                      return Card(
                        child: ListTile(
                          leading: Checkbox(
                            value: missao.concluida,
                            onChanged: (valor) {
                              provider.alterarStatus(
                                missao,
                              );
                            },
                          ),
                          title: Text(
                            missao.titulo,
                            style: TextStyle(
                              decoration: missao.concluida
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                            ),
                            onPressed: () {
                              provider.excluir(
                                missao.id,
                              );
                            },
                          ),
                        ),
                      );
                    },
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
