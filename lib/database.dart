import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> createDatabase() async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, 'demo1.db');

final database = await openDatabase(
  path,
  version: 1,
  onCreate: (db, version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS contatos (
        id INTEGER PRIMARY KEY,
        email TEXT,
        senha TEXT
      )
    ''');
  },
);

  print('Bancos:${database.isOpen}');
  return database;
}

Future<void> insertContato(Contato contato) async {
  final db = await createDatabase();
  final tableExists = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='contatos'");
  if (tableExists.isEmpty) {
    await db.execute(
        'CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, senha TEXT)');
  }
  await db.insert('contatos', contato.toMap());
}



// Função para buscar todos os contatos do banco de dados
Future<List<Contato>> getContatos() async {
  final db = await createDatabase();
  final List<Map<String, dynamic>> maps = await db.query('contatos');

  var list = List.generate(maps.length, (i) {
    return Contato(
      id: maps[i]['id'],
      email: maps[i]['email'],
      senha: maps[i]['senha'],
    );
  });
  return list;
}

// Função para atualizar um contato no banco de dados
Future<void> updateContato(Contato contato) async {
  final db = await createDatabase();
  await db.update(
    'contatos',
    contato.toMap(),
    where: 'id = ?',
    whereArgs: [contato.id],
  );
}

// Função para deletar um contato do banco de dados
Future<void> deleteContato(int id) async {
  final db = await createDatabase();
  await db.delete(
    'contatos',
    where: 'id = ?',
    whereArgs: [id],
  );
}

// Classe para representar um contato
class Contato {
  int id;
  String email;
  String senha;

  Contato({required this.id, required this.email, required this.senha});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'senha': senha,
    };
  }
}
