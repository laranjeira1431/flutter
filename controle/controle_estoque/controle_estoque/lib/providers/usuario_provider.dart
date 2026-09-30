import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../services/usuario_service.dart';

// O Provider fica "no meio" entre a tela e o Service.
// A tela nunca fala direto com o banco, ela fala com o Provider.
class UsuarioProvider extends ChangeNotifier {
  final UsuarioService _service = UsuarioService();

  // Guarda o usuario que fez login (começa vazio = ninguém logado)
  Usuario? usuarioLogado;

  // Guarda uma mensagem de erro para mostrar na tela
  String mensagemErro = '';

  // Tenta cadastrar um usuario novo.
  // Devolve true se deu certo, false se o email já existe.
  Future<bool> cadastrar(String nome, String email, String senha) async {
    final jaExiste = await _service.emailJaExiste(email);

    if (jaExiste) {
      mensagemErro = 'E-mail já cadastrado.';
      notifyListeners(); // avisa a tela que algo mudou
      return false;
    }

    final novoUsuario = Usuario(nome: nome, email: email, senha: senha);
    await _service.cadastrarUsuario(novoUsuario);

    mensagemErro = '';
    notifyListeners();
    return true;
  }

  // Tenta fazer login.
  // Devolve true se deu certo, false se email/senha estiverem errados.
  Future<bool> fazerLogin(String email, String senha) async {
    final usuario = await _service.login(email, senha);

    if (usuario == null) {
      mensagemErro = 'E-mail ou senha incorretos.';
      usuarioLogado = null;
      notifyListeners();
      return false;
    }

    usuarioLogado = usuario;
    mensagemErro = '';
    notifyListeners();
    return true;
  }

  // Faz logout
  void sair() {
    usuarioLogado = null;
    notifyListeners();
  }
}
