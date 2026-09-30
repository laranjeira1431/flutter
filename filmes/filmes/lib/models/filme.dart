// Model - representa um filme
// Aqui a gente só guarda os dados, sem nenhuma regra complicada

class Filme {
  int? id; // vem do SQLite (autoincrement), por isso pode ser nulo antes de salvar
  String titulo;
  bool assistido;

  Filme({
    this.id,
    required this.titulo,
    this.assistido = false,
  });

  // transforma o objeto Filme em um Map, pra poder salvar no SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'assistido': assistido ? 1 : 0, // sqlite não tem bool, então converte pra 0 e 1
    };
  }

  // transforma um Map (que veio do SQLite) de volta em um Filme
  factory Filme.fromMap(Map<String, dynamic> map) {
    return Filme(
      id: map['id'],
      titulo: map['titulo'],
      assistido: map['assistido'] == 1, // 1 vira true, 0 vira false
    );
  }
}
