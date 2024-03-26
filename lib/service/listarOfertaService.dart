import 'dart:convert';
import '../data/responseData.dart';
import '../utils/enpoints.dart';
import 'package:http/http.dart' as http;


class ListarOfertaService{

  static Future<http.Response> listarOferta(String propostaId, String token) async {
    var listarOfertaUrl = Uri.parse('$listarOfertaRoute$propostaId');
    print(listarOfertaUrl);

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var response = await http.get(
        listarOfertaUrl,
        headers: headers,
      );
      var responseData = jsonDecode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        var data = responseData['data'];
        listarOfertaData = data;
        print(listarOfertaData['produtos'][0]['convenio'][0]['convenioDados']);



        return response;
      } else {
        var erro = responseData['errors'][0];
        print(erro);
        return response;
      }
    } catch (error) {
      print('Erro na solicitação: $error');
      return http.Response('Erro na formatação da apiKey: $error', 500);
    }
  }}
