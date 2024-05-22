// Realizado em aula com o professor (dias 1 e 2)

import 'package:flutter/material.dart';

void main() {
  runApp(AppCrud());
}

class Aluno {
  String nome;
  String email;
  String senha;
  String repetirSenha;

  Aluno(
      {required this.nome,
      required this.email,
      required this.senha,
      required this.repetirSenha});
}

class AppCrud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Aluno',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Adiciona a imagem do logo
                Image.asset(
                  'images/logo.png',
                  height: 244, // Ajuste conforme necessário
                  width: 275, // Ajuste conforme necessário
                ),

                // Adiciona a segunda imagem acima do logo
                Positioned(
                  top: 72, // Ajuste conforme necessário
                  child: Image.asset(
                    'images/imgsesisenai.png',
                    height: 52.11, // Ajuste conforme necessário
                    width: 300, // Ajuste conforme necessário
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Verificar credenciais
                if (_usernameController.text == 'Vedilson' &&
                    _passwordController.text == 'trocar123') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentListPage()),
                  );
                } else {
                  // Exibir mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Credenciais inválidas')),
                  );
                }
              },
              child: Text('Login'),
            ),
            Text('LEANDRO LOVERS DEVS:'),
            Text('Vitor Fogaça')
          ],
        ),
      ),
    );
  }
}

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  // Lista de alunos (simulando um banco de dados)
  List<Aluno> students = [
    Aluno(
        nome: 'Aluno 1',
        email: 'aluno1@example.com',
        senha: 'senha1',
        repetirSenha: 'senha1'),
    Aluno(
        nome: 'Aluno 2',
        email: 'aluno2@example.com',
        senha: 'senha2',
        repetirSenha: 'senha2'),
    Aluno(
        nome: 'Aluno 3',
        email: 'aluno3@example.com',
        senha: 'senha3',
        repetirSenha: 'senha3'),
  ];

  bool _isValidEmail(String email) {
    // Validar o formato do email
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Alunos'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(students[index].nome),
            subtitle: Text(students[index].email),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Excluir aluno
                students.removeAt(index);
                // Atualizar a interface
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Aluno removido')),
                );
                // Atualizar a lista de alunos
                setState(() {});
              },
            ),
            onTap: () async {
              // Editar o aluno
              Aluno updatedStudent = await showDialog(
                context: context,
                builder: (context) {
                  TextEditingController _nomeController =
                      TextEditingController(text: students[index].nome);
                  TextEditingController _emailController =
                      TextEditingController(text: students[index].email);
                  TextEditingController _senhaController =
                      TextEditingController(text: students[index].senha);
                  TextEditingController _repetirSenhaController =
                      TextEditingController(text: students[index].repetirSenha);

                  return AlertDialog(
                    title: Text('Editar Aluno'),
                    content: Column(
                      children: [
                        TextField(
                          controller: _nomeController,
                          decoration: InputDecoration(labelText: 'Nome'),
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        TextField(
                          controller: _senhaController,
                          decoration: InputDecoration(labelText: 'Senha'),
                          obscureText: true,
                        ),
                        TextField(
                          controller: _repetirSenhaController,
                          decoration:
                              InputDecoration(labelText: 'Repetir Senha'),
                          obscureText: true,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Validar e salvar as alterações
                          if (_nomeController.text.isNotEmpty &&
                              _emailController.text.isNotEmpty &&
                              _isValidEmail(_emailController.text) &&
                              _senhaController.text.isNotEmpty &&
                              _repetirSenhaController.text.isNotEmpty &&
                              _senhaController.text ==
                                  _repetirSenhaController.text) {
                            Navigator.pop(
                              context,
                              Aluno(
                                nome: _nomeController.text.trim(),
                                email: _emailController.text.trim(),
                                senha: _senhaController.text.trim(),
                                repetirSenha:
                                    _repetirSenhaController.text.trim(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Preencha todos os campos corretamente')),
                            );
                          }
                        },
                        child: Text('Salvar'),
                      ),
                    ],
                  );
                },
              );

              if (updatedStudent != null) {
                // Atualizar o aluno na lista
                students[index] = updatedStudent;
                // Atualizar a interface
                setState(() {});
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Adicionar novo aluno
          Aluno newStudent = await showDialog(
            context: context,
            builder: (context) {
              TextEditingController _nomeController = TextEditingController();
              TextEditingController _emailController = TextEditingController();
              TextEditingController _senhaController = TextEditingController();
              TextEditingController _repetirSenhaController =
                  TextEditingController();

              // Adicionar novo aluno
              return AlertDialog(
                title: Text('Novo Aluno'),
                content: Column(
                  children: [
                    TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: _senhaController,
                      decoration: InputDecoration(labelText: 'Senha'),
                      obscureText: true,
                    ),
                    TextField(
                      controller: _repetirSenhaController,
                      decoration: InputDecoration(labelText: 'Repetir Senha'),
                      obscureText: true,
                    ),
                  ],
                ),

                // Cancelar operação
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),

                  // Validar e adicionar o novo aluno
                  TextButton(
                    onPressed: () {
                      if (_nomeController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty &&
                          _isValidEmail(_emailController.text) &&
                          _senhaController.text.isNotEmpty &&
                          _repetirSenhaController.text.isNotEmpty &&
                          _senhaController.text ==
                              _repetirSenhaController.text) {
                        Navigator.pop(
                          context,
                          Aluno(
                            nome: _nomeController.text.trim(),
                            email: _emailController.text.trim(),
                            senha: _senhaController.text.trim(),
                            repetirSenha: _repetirSenhaController.text.trim(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Preencha todos os campos corretamente')),
                        );
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );

          // Verificar espaço a ser alocado para a adição do novo aluno
          if (newStudent != null) {
            // Adicionar o novo aluno à lista
            students.add(newStudent);

            // Atualizar a tela
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
