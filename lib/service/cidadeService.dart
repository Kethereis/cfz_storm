import 'dart:convert';
import '../utils/enpoints.dart';
import 'package:http/http.dart' as http;


class CidadeService{

  static Future<http.Response> buscaCidade(String cidade, String estado, String authToken) async {
    var cidadeUrl = Uri.parse(cidadeRoute);
    var payload = jsonEncode({
      'nomeCidade': cidade,
      'uf': estado,
    });

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',

    };

    try {
      var response = await http.post(
        cidadeUrl,
        body: payload,
        headers: headers,
      );
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {

        return response;
      } else {
        return response;
      }
    } catch (error) {
      print('Erro na solicitação: $error');
      return http.Response('Erro na formatação da apiKey: $error', 500);
    }
  }}
