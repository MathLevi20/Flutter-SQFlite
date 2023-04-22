import 'package:flutter/material.dart';
import 'database.dart';
import 'package:uuid/uuid.dart';

void main() async {
  runApp(const RegisterApp());
  await createDatabase();
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const RegisterPage(), // alterado de CadastroPage para ContatosPage
    );
  }
}

var uuid = const Uuid();

class ListUserPage extends StatefulWidget {
  const ListUserPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: FutureBuilder<List<User>>(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final contato = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      title: Text(contato.email),
                      subtitle: Text(contato.senha),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar contatos: ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: Text('Nenhum contato encontrado.'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  Future<void> _cadastrar() async {
    String email = _emailController.text;
    String senha = _senhaController.text;

    User novoContato = User(
      id: DateTime.now().microsecondsSinceEpoch,
      email: email,
      senha: senha,
    );

    await insertContato(novoContato);

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Cadastro realizado!'),
        content: const Text('Seus dados foram salvos com sucesso.'),
        actions: <Widget>[
          TextButton(
            child: const Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastro",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
      ),
body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Image.asset(
          'assets/images/user_.png',
          width: 100,
          height: 150,
        ), 
        const SizedBox(height: 16.0), 
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'E-mail'),
        ),
        const SizedBox(height: 1.0),
        TextField(
          controller: _senhaController,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Senha'),
        ),
        const SizedBox(height: 24.0),
        ElevatedButton(
          onPressed: _cadastrar,
          child: const Text('Fazer Cadastro'),
        ),
        ElevatedButton(
          child: const Text('Ver Usuarios'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ListUserPage()),
            );
          },
        ),
      ],
    ),
  ),
),

      
    );
  }
}
