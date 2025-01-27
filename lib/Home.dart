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
      title: 'Home App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F4C5C), // Cor de fundo
      appBar: AppBar(
        title: const Text(
          'HOME',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0F4C5C),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              context,
              icon: Icons.search,
              label: 'BUSCAR USUÁRIO',
            ),
            const SizedBox(height: 16),
            _buildButton(
              context,
              icon: Icons.person_add,
              label: 'CADASTRAR USUÁRIO',
            ),
            const SizedBox(height: 16),
            _buildButton(
              context,
              icon: Icons.update,
              label: 'ATUALIZAR DADOS',
            ),
            const SizedBox(height: 16),
            _buildButton(
              context,
              icon: Icons.delete,
              label: 'DELETAR USUÁRIO',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required IconData icon, required String label}) {
    return GestureDetector(
      onTap: () {
        // Navegar para a tela simples com o título do botão
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageScreen(title: label),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.teal, size: 24),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageScreen extends StatelessWidget {
  final String title;

  const MessageScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          'Você clicou no botão $title',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
