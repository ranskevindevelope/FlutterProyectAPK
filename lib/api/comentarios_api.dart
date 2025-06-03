import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchComentarios() async {
  final url = Uri.parse("http://192.168.1.2/PHP-API-MYSQL_V2/controller/obtener_comentarios.php");

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success'] == true && data['comentarios'] != null) {
        return List<Map<String, dynamic>>.from(data['comentarios']);
      }
    }
    return [];
  } catch (e) {
    print("Error al obtener comentarios: $e");
    return [];
  }
}
