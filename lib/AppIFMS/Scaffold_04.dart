import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Enroliment.dart';
import 'Login.dart';
import 'DiariosENotas.dart';
import 'Cracha.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IFMS App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LoginScreen(),
    );
  }
}

class MainTasksScreen extends StatelessWidget {
  final String username;

  const MainTasksScreen({super.key, required this.username});

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
    final tasks = [
      {'title': 'Matrícula', 'status': 'Disponível'},
      {'title': 'Rematrícula', 'status': 'Em breve'},
      {'title': 'Crachá de estudante', 'status': 'Em andamento'},
      {'title': 'Diários e notas', 'status': 'Em breve'},
      {'title': 'Notificação', 'status': 'Disponível'},
      {'title': 'Autoavaliação', 'status': 'Em breve'},
      {'title': 'Bolsa', 'status': 'Em análise'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/imagens/logo.png', height: 40, width: 40),
            const SizedBox(width: 10),
            const Text(
              'IFMS App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notificação clicada')),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Task(
                  title: task['title']!,
                  status: task['status']!,
                  onTap: () {
                    if (task['title'] == 'Matrícula') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EnrollmentForm()),
                      );
                    }else if(task['title'] == 'Diários e notas'){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DiariosENotas(username: username)),
                      );
                    }else if(task['title'] == 'Crachá de estudante') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CrachaScreen(username: username)),
                      );
                    }else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailScreen(
                            title: task['title']!,
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_rounded),
            label: "Solicitação do Cerel",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: "Sair",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        },
      ),
    );
  }
}

class Task extends StatelessWidget {
  final String title;
  final String status;
  final VoidCallback onTap;

  const Task({
    super.key,
    required this.title,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              status,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskDetailScreen extends StatelessWidget {
  final String title;

  const TaskDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[600],
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text(
          'Detalhes sobre: $title',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
