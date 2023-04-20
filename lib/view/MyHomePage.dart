import 'package:flutter/material.dart';
import '../model/Pessoa.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class HomePage extends StatelessWidget {
  Pessoa pessoa = Pessoa("Otilio Gato", "OtilioGato@gmail.com");

  final List<String> _randomMessages = [
    'O sucesso é a soma de pequenos esforços repetidos diariamente.',
    'Acredite em si próprio e tudo será possível.',
    'A única maneira de fazer um excelente trabalho é amar o que você faz.',
    'A sorte favorece os audazes.',
    'O fracasso é a oportunidade de começar de novo, com mais experiência.'
  ];

  String _getRandomMessage() {
    final random = Random();
    final index = random.nextInt(_randomMessages.length);
    return _randomMessages[index];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mensagem do Dia",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Bem-vindo(a), ${pessoa.RetornaName()}!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[900],
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  _getRandomMessage(),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blueGrey[900],
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Styles extends StatelessWidget {
  Pessoa pessoa = Pessoa("Otilio Gato", "OtilioGato@gmail.com");

  final List<String> _randomMessages = [
    'O sucesso é a soma de pequenos esforços repetidos diariamente.',
    'Acredite em si próprio e tudo será possível.',
    'A única maneira de fazer um excelente trabalho é amar o que você faz.',
    'A sorte favorece os audazes.',
    'O fracasso é a oportunidade de começar de novo, com mais experiência.'
  ];

  String _getRandomMessage() {
    final random = Random();
    final index = random.nextInt(_randomMessages.length);
    return _randomMessages[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Test de layout",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('images/pic1.jpg'),
                      Image.asset('images/pic2.jpg'),
                      Image.asset('images/pic3.jpg'),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  _getRandomMessage(),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blueGrey[900],
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Pessoa pessoa = Pessoa("Otilio Gato", "OtilioGato@gmail.com");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://cdn.pixabay.com/photo/2017/02/20/18/03/cat-2083492_960_720.jpg',
              width: 200,
              height: 200,
            ),
            Text(pessoa.RetornaName()),
            Text(pessoa.RetornaEmail()),
            Column(children: [
              ElevatedButton(
                child: const Text('Exibir Mensagem'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Estilo'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Styles()),
                  );
                },
              )
            ]),
          ],
        ),
      ),
    );
  }
}
