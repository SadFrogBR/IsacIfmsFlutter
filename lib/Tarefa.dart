import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IFMS App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MainTasksScreen(),
    );
  }
}

class MainTasksScreen extends StatelessWidget {
  const MainTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {'title': 'Estudar para a prova', 'status': 'Em andamento'},
      {'title': 'Entregar projeto', 'status': 'Feito'},
      {'title': 'Revisar matéria', 'status': 'Pendente'},
      {'title': 'Participar do evento', 'status': 'Em andamento'},
      {'title': 'Preparar apresentação', 'status': 'Feito'},
      {'title': 'Organizar os materiais', 'status': 'Pendente'},
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Task(
            title: task['title']!,
            status: task['status']!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailScreen(
                    title: task['title']!,
                    status: task['status']!,
                  ),
                ),
              );
            },
          );
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
    Key? key,
    required this.title,
    required this.status,
    required this.onTap,
  }) : super(key: key);

  Color CorDoStatus(String status) {
    switch (status) {
      case 'Feito':
        return Colors.green;
      case 'Em andamento':
        return Colors.orange;
      case 'Pendente':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: CorDoStatus(status).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: CorDoStatus(status),
                ),
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
  final String status;

  const TaskDetailScreen({
    Key? key,
    required this.title,
    required this.status,
  }) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tarefa: $title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Status: $status',
              style: const TextStyle(fontSize: 20, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Text(
              'Descrição:\nEsta é uma descrição da tarefa "$title". ',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
