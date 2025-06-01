import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/frase_widget.dart';
import '../models/frase.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final List<Frase> _frases = [
    Frase(contenido: "🌟 Cree en ti mismo y todo será posible."),
    Frase(contenido: "💪 Cada día es una nueva oportunidad para mejorar."),
    Frase(contenido: "🔥 Nunca te rindas, los grandes logros toman tiempo."),
    Frase(contenido: "🚀 Apunta a la luna. Si fallas, aterrizarás entre las estrellas."),
    Frase(contenido: "🌈 El éxito no es la clave de la felicidad, la felicidad es la clave del éxito."),
    Frase(contenido: "🌱 Hoy es un buen día para comenzar algo nuevo."),
    Frase(contenido: "💡 Sé el cambio que quieres ver en el mundo."),
    Frase(contenido: "🏆 La única forma de lograrlo es intentándolo."),
  ];

  late Frase _fraseActual;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _fraseActual = Frase(contenido: "Presiona el botón para recibir una frase motivadora");

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _generarFrase() {
    final random = Random();
    setState(() {
      _fraseActual = _frases[random.nextInt(_frases.length)];
    });
  }

  void _compartirFrase() {
    final mensaje = "${_fraseActual.contenido}\n\n💬 Compartido desde mi app de frases motivadoras";
    Share.share(mensaje);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 250, 240),
      appBar: AppBar(
        title: const Text('Frases Motivadoras SENA V.1 BETA'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FraseWidget(frase: _fraseActual.contenido),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _generarFrase,
                child: const Text('Nueva frase'),
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      iconSize: 30,
                      tooltip: 'Compartir en WhatsApp',
                      onPressed: _compartirFrase,
                    ),
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
