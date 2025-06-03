import 'package:flutter/material.dart';
import '../api/comentarios_api.dart';

class ComentariosListWidget extends StatefulWidget {
  @override
  _ComentariosListWidgetState createState() => _ComentariosListWidgetState();
}

class _ComentariosListWidgetState extends State<ComentariosListWidget> {
  late Future<List<dynamic>> futureComentarios;

  @override
  void initState() {
    super.initState();
    futureComentarios = fetchComentarios();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: futureComentarios,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No hay comentarios"));
        } else {
          final comentarios = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "🗨️ Comentarios recientes:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: comentarios.length,
                  itemBuilder: (context, index) {
                    final comentario = comentarios[index];
                    return Card(
                      child: ListTile(
                        title: Text(comentario['contenido']),
                        subtitle: Text(comentario['fech'] ?? ''),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

