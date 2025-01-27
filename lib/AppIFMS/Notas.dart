import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotasScreen extends StatelessWidget {
  final String username;

  const NotasScreen({Key? key, required this.username}) : super(key: key);

  String _getCurrentTime() {
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm');
    return formatter.format(now);
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas'),
        backgroundColor: Colors.green[600],
      ),
      body: Column(
        children: [
          // Cabeçalho com informações do usuário
          Container(
            color: Colors.green[100],
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Olá, aluno(a): $username',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Bem-vindo! Hoje é ${_getCurrentDate()}, ${_getCurrentTime()}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Matrícula: 2022 - 112233445-5',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Período Atual: 2024/1',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Período Atual Sugerido: 2024/2',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Conteúdo centralizado
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Aqui você poderá visualizar suas notas escolares.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Exemplo de conteúdo:\n- Matemática: 8.5\n- Português: 9.0\n- Ciências: 7.8',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
