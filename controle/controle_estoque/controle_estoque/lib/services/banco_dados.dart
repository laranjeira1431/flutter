import 'package:sqflite_common/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

// Essa classe só tem UMA responsabilidade:
// abrir o banco de dados e criar as tabelas, se ainda não existirem.
//
// Assim, tanto o usuario_service quanto o produto_service
// usam o MESMO banco, sem precisar abrir de novo toda hora.
class BancoDados {
  // "static" porque queremos o MESMO banco em todo o app
  static Database? _database;

  static Future<Database> getBanco() async {
    // Se o banco já foi aberto antes, não abre de novo
    if (_database != null) {
      return _database!;
    }

    // Aqui a gente avisa para o sqflite usar a versão para navegador
    // (é essa parte que usa o sqlite3.wasm e o sqflite_sw.js)
    databaseFactory = databaseFactoryFfiWeb;

    _database = await databaseFactory.openDatabase(
      'controle_estoque.db',
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          // Essa função só roda UMA vez, na primeira vez que o banco é criado

          // Tabela de usuarios (para login e cadastro)
          await db.execute('''
            CREATE TABLE usuarios (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nome TEXT,
              email TEXT,
              senha TEXT
            )
          ''');

          // Tabela de produtos (para o estoque)
          await db.execute('''
            CREATE TABLE produtos (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nome TEXT,
              categoria TEXT,
              quantidade INTEGER,
              preco REAL
            )
          ''');

          print('Banco de dados criado com sucesso!');
        },
      ),
    );

    return _database!;
  }
}
