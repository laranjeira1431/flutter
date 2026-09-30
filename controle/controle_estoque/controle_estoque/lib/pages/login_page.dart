import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/usuario_provider.dart';
import 'cadastro_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers servem para "ler" o que a pessoa digitou nos campos
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // "watch" faz a tela atualizar sozinha quando o provider mudar
    final usuarioProvider = context.watch<UsuarioProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Área Restrita')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                obscureText: true, // esconde a senha
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Só mostra a mensagem de erro se ela não estiver vazia
              if (usuarioProvider.mensagemErro.isNotEmpty)
                Text(
                  usuarioProvider.mensagemErro,
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () async {
                  final sucesso = await usuarioProvider.fazerLogin(
                    emailController.text.trim(),
                    senhaController.text,
                  );

                  // se deu certo, e a tela ainda estiver aberta, navega
                  if (sucesso && mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  }
                },
                child: const Text('ENTRAR'),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CadastroPage()),
                  );
                },
                child: const Text('Ainda não possui conta? CRIAR CONTA'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
