import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool isCamposValidos() {
    return nomeController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        senhaController.text.isNotEmpty &&
        emailController.text.contains('@'); // Verifica se o campo de e-mail contém '@'
  }

  void _acessar() {
    if (isCamposValidos()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(
            nome: nomeController.text,
            email: emailController.text,
            senha: senhaController.text,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Por favor, preencha todos os campos corretamente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Acesso'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: senhaController,
              obscureText: true, // Para senha
              decoration: InputDecoration(labelText: 'Senha'),
            ),
            ElevatedButton(
              onPressed: _acessar,
              child: Text('Acessar'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  final String nome;
  final String email;
  final String senha;

  SecondScreen({required this.nome, required this.email, required this.senha});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool mostrarInformacoes = true;

  void _ocultarMostrarInformacoes(bool value) {
    setState(() {
      mostrarInformacoes = value;
    });
  }

  void _exibirInformacoes() {
    setState(() {
      mostrarInformacoes = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo'),
        automaticallyImplyLeading: false, // Remova a seta de voltar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Nome do Usuário: ${widget.nome}'),
            if (mostrarInformacoes)
              Column(
                children: [
                  Text('Email: ${widget.email}'),
                  Text('Senha: ${widget.senha}'),
                ],
              ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmação'),
                      content: Text('Deseja ocultar as informações?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            _ocultarMostrarInformacoes(false);
                            Navigator.of(context).pop();
                          },
                          child: Text('Sim'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Não'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Ocultar Informações'),
            ),
            ElevatedButton(
              onPressed: () {
                _exibirInformacoes();
              },
              child: Text('Exibir Informações'),
            ),
          ],
        ),
      ),
    );
  }
}
