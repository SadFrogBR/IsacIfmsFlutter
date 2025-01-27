import 'package:flutter/material.dart';
import 'scaffold_04.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isEmailLogin = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainTasksScreen(username: _usernameController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/imagens/logo.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'IFMS App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Usuário',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o usuário';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    if (!_isEmailLogin)
                      TextFormField(
                        controller: _cpfController,
                        decoration: const InputDecoration(
                          labelText: 'CPF',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o CPF';
                          }
                          // Adicionar validação para CPF se necessário
                          return null;
                        },
                      ),
                    if (!_isEmailLogin)
                      const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a senha';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: _isEmailLogin,
                          onChanged: (bool? value) {
                            setState(() {
                              _isEmailLogin = value ?? false;
                            });
                          },
                        ),
                        const Text('Entrar com @estudante.ifms.edu.br'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Entrar',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green[600],
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'IFMS Campus Corumbá',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LoginScreen(),
  ));
}
