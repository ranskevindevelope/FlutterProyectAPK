import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComentarioWidget extends StatefulWidget {
  final VoidCallback onComentarioEnviado;

  const ComentarioWidget({super.key, required this.onComentarioEnviado});

  @override
  State<ComentarioWidget> createState() => _ComentarioWidgetState();
}

class _ComentarioWidgetState extends State<ComentarioWidget> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _enviarComentario() async {
    final comentario = _controller.text.trim();
    if (comentario.isEmpty) return;

    final url = Uri.parse("http://192.168.1.2/PHP-API-MYSQL_V2/controller/guardar_comentario.php");

    final response = await http.post(url, body: {
      "contenido": comentario,
    });

    if (response.statusCode == 200) {
      _controller.clear();
      widget.onComentarioEnviado();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Comentario enviado")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al enviar el comentario")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: "Escribe un comentario",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _enviarComentario,
          child: const Text("Enviar comentario"),
        ),
      ],
    );
  }
}
