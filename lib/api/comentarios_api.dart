import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchComentarios() async {
  final url = Uri.parse("http://192.168.1.2/PHP-API-MYSQL_V2/controller/obtener_comentarios.php");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> comentarios = json.decode(response.body);
    return comentarios;
  } else {
    throw Exception("Error al cargar los comentarios");
  }
}
