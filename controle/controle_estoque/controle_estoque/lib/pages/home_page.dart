import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/usuario_provider.dart';
import 'cadastro_produto_page.dart';
import 'estoque_page.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = context.watch<UsuarioProvider>();
    final nome = usuarioProvider.usuarioLogado?.nome ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Controle de Estoque')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Olá, $nome!',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EstoquePage()),
                );
              },
              child: const Text('VER PRODUTOS'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CadastroProdutoPage()),
                );
              },
              child: const Text('CADASTRAR PRODUTO'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                usuarioProvider.sair();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false, // apaga todas as telas anteriores
                );
              },
              child: const Text('SAIR'),
            ),
          ],
        ),
      ),
    );
  }
}
