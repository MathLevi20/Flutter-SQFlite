import 'package:flutter/material.dart';


import 'database.dart';

import 'package:uuid/uuid.dart';

void main() async {
  runApp(const LoginApp());
  await createDatabase();
}



class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const CadastroPage(), // alterado de CadastroPage para ContatosPage
    );
  }
}


var uuid = const Uuid();

class ContatosPage extends StatefulWidget {
  @override
  _ContatosPageState createState() => _ContatosPageState();
}

class _ContatosPageState extends State<ContatosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: FutureBuilder<List<Contato>>(
        future: getContatos(),
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
            } 
            else if (snapshot.hasError) {
  return Center(
    child: Text('Erro ao carregar contatos: ${snapshot.error}'),
  );
}
else {
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

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  Future<void> _cadastrar() async {
    String email = _emailController.text;
    String senha = _senhaController.text;

    Contato novoContato = Contato(
      id: DateTime.now().microsecondsSinceEpoch,
      email: email,
      senha: senha,
    );

    await insertContato(novoContato);

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
              child: const Text('Cadastrar'),
              onPressed: _cadastrar,
            )
          ],
        ),
      ),
    );
  }
}
