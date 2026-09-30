// Essa classe representa um usuario do sistema.
// Ela só guarda os dados, não faz nada com o banco.
class Usuario {
  int? id; // id é opcional, porque só existe DEPOIS de salvar no banco
  String nome;
  String email;
  String senha;

  Usuario({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
  });

  // Transforma o Usuario em um Map, para poder salvar no SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
    };
  }

  // Faz o caminho contrário: pega um Map que veio do SQLite
  // e transforma em um objeto Usuario
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      email: map['email'] as String,
      senha: map['senha'] as String,
    );
  }
}
