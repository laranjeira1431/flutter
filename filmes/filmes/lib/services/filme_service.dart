// Service - é o único lugar do projeto que conversa com o SQLite
// A View e a ViewModel NUNCA acessam o banco direto, só passam por aqui

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/filme.dart';

class FilmeService {
  Database? _db;

  // pega o banco já aberto, ou abre se ainda não tiver aberto
  Future<Database> getDatabase() async {
    if (_db != null) {
      return _db!;
    }
    _db = await _abrirBanco();
    return _db!;
  }

  // abre (ou cria, se não existir) o banco filmes.db
  Future<Database> _abrirBanco() async {
    String caminhoPasta = await getDatabasesPath();
    String caminhoCompleto = join(caminhoPasta, 'filmes.db');

    return openDatabase(
      caminhoCompleto,
      version: 1,
      onCreate: (db, versao) {
        // só roda essa parte na primeira vez que o banco é criado
        return db.execute('''
          CREATE TABLE filmes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT NOT NULL,
            assistido INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // INSERT - cadastrar um filme novo
  Future<void> inserirFilme(Filme filme) async {
    final db = await getDatabase();
    await db.insert('filmes', filme.toMap());
  }

  // SELECT - buscar todos os filmes salvos
  Future<List<Filme>> listarFilmes() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> resultado = await db.query('filmes');

    // transforma cada Map do resultado em um objeto Filme
    return resultado.map((mapa) => Filme.fromMap(mapa)).toList();
  }

  // UPDATE - marcar ou desmarcar como assistido
  Future<void> atualizarStatus(Filme filme) async {
    final db = await getDatabase();
    await db.update(
      'filmes',
      filme.toMap(),
      where: 'id = ?',
      whereArgs: [filme.id],
    );
  }
}
