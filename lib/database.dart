import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> createDatabase() async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, 'database.db');

final database = await openDatabase(
  path,
  version: 1,
  onCreate: (db, version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS user (
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

Future<void> insertContato(User user) async {
  final db = await createDatabase();
  final tableExists = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='user'");
  if (tableExists.isEmpty) {
    await db.execute(
        'CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, senha TEXT)');
  }
  await db.insert('user', user.toMap());
}



// Função para buscar todos os contatos do banco de dados
Future<List<User>> getUser() async {
  final db = await createDatabase();
  final List<Map<String, dynamic>> maps = await db.query('user');

  var list = List.generate(maps.length, (i) {
    return User(
      id: maps[i]['id'],
      email: maps[i]['email'],
      senha: maps[i]['senha'],
    );
  });
  return list;
}

// Função para atualizar um user no banco de dados
Future<void> updateUser(User user) async {
  final db = await createDatabase();
  await db.update(
    'user',
    user.toMap(),
    where: 'id = ?',
    whereArgs: [user.id],
  );
}

// Função para deletar um user do banco de dados
Future<void> deleteUser(int id) async {
  final db = await createDatabase();
  await db.delete(
    'user',
    where: 'id = ?',
    whereArgs: [id],
  );
}

// Classe para representar um user
class User {
  int id;
  String email;
  String senha;

  User({required this.id, required this.email, required this.senha});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'senha': senha,
    };
  }
}
