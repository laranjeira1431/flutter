import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/usuario_provider.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = context.watch<UsuarioProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
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
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              if (usuarioProvider.mensagemErro.isNotEmpty)
                Text(
                  usuarioProvider.mensagemErro,
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () async {
                  final sucesso = await usuarioProvider.cadastrar(
                    nomeController.text.trim(),
                    emailController.text.trim(),
                    senhaController.text,
                  );

                  if (sucesso && mounted) {
                    // avisa que deu certo e volta para o login
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('CADASTRAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
