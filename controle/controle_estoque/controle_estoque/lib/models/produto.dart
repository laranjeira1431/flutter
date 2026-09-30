// Essa classe representa um produto do estoque.
class Produto {
  int? id;
  String nome;
  String categoria;
  int quantidade;
  double preco;

  Produto({
    this.id,
    required this.nome,
    required this.categoria,
    required this.quantidade,
    required this.preco,
  });

  // Transforma o Produto em Map para salvar no SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'categoria': categoria,
      'quantidade': quantidade,
      'preco': preco,
    };
  }

  // Transforma um Map (que veio do SQLite) em um Produto
  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      categoria: map['categoria'] as String,
      quantidade: map['quantidade'] as int,
      // o preco vem como num, então convertemos para double
      preco: (map['preco'] as num).toDouble(),
    );
  }
}
