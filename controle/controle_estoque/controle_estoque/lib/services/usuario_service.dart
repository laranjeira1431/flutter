import '../models/usuario.dart';
import 'banco_dados.dart';

// Essa classe é quem realmente "conversa" com o SQLite
// para tudo que for relacionado a usuario (cadastro e login).
class UsuarioService {
  // Verifica se já existe um usuario com esse email
  // (usado para não deixar cadastrar email repetido)
  Future<bool> emailJaExiste(String email) async {
    final db = await BancoDados.getBanco();

    final resultado = await db.query(
      'usuarios',
      where: 'email = ?',
      whereArgs: [email],
    );

    // Se encontrou pelo menos 1 registro, o email já existe
    return resultado.isNotEmpty;
  }

  // Salva um novo usuario no banco -> INSERT
  Future<void> cadastrarUsuario(Usuario usuario) async {
    final db = await BancoDados.getBanco();

    await db.insert('usuarios', usuario.toMap());

    print('INSERT -> Usuario cadastrado: ${usuario.nome}');
  }

  // Procura um usuario pelo email e senha -> SELECT
  // Se encontrar, devolve o Usuario. Se não encontrar, devolve null.
  Future<Usuario?> login(String email, String senha) async {
    final db = await BancoDados.getBanco();

    print('SELECT -> Procurando usuario: $email');

    final resultado = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );

    if (resultado.isNotEmpty) {
      final usuario = Usuario.fromMap(resultado.first);
      print('SELECT -> Usuario encontrado: ${usuario.nome}');
      return usuario;
    } else {
      print('SELECT -> Usuario nao encontrado');
      return null;
    }
  }
}
