import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComentarioWidget extends StatefulWidget {
  @override
  _ComentarioWidgetState createState() => _ComentarioWidgetState();
}

class _ComentarioWidgetState extends State<ComentarioWidget> {
  final TextEditingController _controller = TextEditingController();

  Future<void> enviarComentario() async {
    final comentario = _controller.text.trim();

    if (comentario.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, escribe un comentario")),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final url = Uri.parse("http://192.168.1.2/PHP-API-MYSQL_V2/controller/insertar_comentario.php");
      final response = await http.post(url, body: {'comentario': comentario});

      Navigator.of(context).pop(); // Cierra el loading

      if (response.statusCode == 200) {
        final respuesta = response.body;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Respuesta del servidor: $respuesta")),
        );
        _controller.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error del servidor: ${response.statusCode}")),
        );
      }
    } catch (e) {
      Navigator.of(context).pop(); // Cierra el loading si hay error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al conectar: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(labelText: "Escribe tu comentario"),
        ),
        ElevatedButton(
          onPressed: enviarComentario,
          child: const Text("Enviar comentario"),
        ),
      ],
    );
  }
}
