import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ComentariosListWidget extends StatefulWidget {
  const ComentariosListWidget({super.key});

  @override
  ComentariosListWidgetState createState() => ComentariosListWidgetState();
}

class ComentariosListWidgetState extends State<ComentariosListWidget> {
  List<Map<String, dynamic>> _comentarios = [];
  bool _cargando = false;

  @override
  void initState() {
    super.initState();
    cargarComentarios();
  }

  Future<void> cargarComentarios() async {
    setState(() => _cargando = true);

    final url = Uri.parse("http://192.168.1.2/PHP-API-MYSQL_V2/controller/obtener_comentarios.php");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            _comentarios = List<Map<String, dynamic>>.from(data['comentarios']);
          });
        } else {
          setState(() {
            _comentarios = [];
          });
        }
      } else {
        setState(() {
          _comentarios = [];
        });
      }
    } catch (e) {
      setState(() {
        _comentarios = [];
      });
    }

    setState(() => _cargando = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_cargando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_comentarios.isEmpty) {
      return const Text("No hay comentarios aún.");
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _comentarios.length,
      itemBuilder: (context, index) {
        final comentario = _comentarios[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            title: Text(comentario['contenido']),
            subtitle: Text("📅 ${comentario['fecha']}"),
          ),
        );
      },
    );
  }
}
