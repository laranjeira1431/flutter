class Missao {
  String? id;
  String titulo;
  String dificuldade;
  int pontos;
  bool concluida;

  Missao({
    this.id,
    required this.titulo,
    required this.dificuldade,
    required this.pontos,
    this.concluida = false,
  });
}