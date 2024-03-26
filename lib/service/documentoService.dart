import 'dart:convert';
import '../utils/enpoints.dart';
import 'package:http/http.dart' as http;


class DocumentoService{

  static Future<http.Response> documento(
      String imagem,
      int id,
      String authToken) async {
    var documentoUrl = Uri.parse(documentoRoute);
    var payload = jsonEncode({
      'documentoId': id,
      'conteudo': imagem,
    });

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',

    };

    try {
      var response = await http.put(
        documentoUrl,
        body: payload,
        headers: headers,
      );
      var responseData = jsonDecode(response.body);
      print(responseData);
      if (response.statusCode == 200) {
        print("Sucesso Enviar Documento");

        return response;
      } else {
        return response;
      }
    } catch (error) {
      print('Erro na solicitação: $error');
      return http.Response('Erro na formatação da apiKey: $error', 500);
    }
  }}
