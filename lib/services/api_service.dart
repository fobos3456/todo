import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // 10.0.2.2 es el host localhost desde el emulador de Android.
  // Para pruebas en celular físico por USB o Wi-Fi, reemplaza por la IP local de tu PC (ej. http://192.168.1.50:8000)
  static const String baseUrl = 'http://10.0.2.2:8000';

  Future<String?> consultarServidorPython(String pregunta, String idioma) async {
    try {
      final url = Uri.parse('$baseUrl/api/chat');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'pregunta': pregunta,
          'idioma': idioma,
        }),
      ).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['respuesta'] as String?;
      }
    } catch (e) {
      debugPrint("Info Servidor Python: No se pudo conectar al servidor local ($e)");
    }
    return null;
  }
}
