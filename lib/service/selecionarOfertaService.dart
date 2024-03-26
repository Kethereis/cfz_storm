import 'dart:convert';
import '../data/responseData.dart';
import '../utils/enpoints.dart';
import 'package:http/http.dart' as http;


class SelecionarOfertaService{

  static Future<http.Response> selecionarOferta(
      String propostaId,
      int plano,
      double prestacao,
      List<Map<String, dynamic>> adicionais,
      String token) async {
    var selecionarUrl = Uri.parse('$selecionarRoute$propostaId');
    var payload = jsonEncode(
        {
          "id": int.parse(propostaId),
          "convenioId": convenioIdData,
          "tabelaJurosId": tabelaJurosIdData,
          "produtoId": produtoIdData,
          "plano": plano,
          "prestacao": prestacao,
          "renda": valorRendaPresumidaData,
          "diaRecebimento": 5,
          "tipoRenda": 0,
          "vencimento": vencimentoData,
          "valor": valorLimiteData,
          "tipoCalculo": 0,
          "adicionais": adicionais,
          "contratosRefin": []
        }
    );

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',

    };
    print(payload);

    try {
      var response = await http.put(
        selecionarUrl,
        body: payload,
        headers: headers,
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(responseData);

        return response;
      } else {
        var erro = responseData['errors'][0];
        return response;
      }
    } catch (error) {
      print('Erro na solicitação: $error');
      return http.Response('Erro na formatação da apiKey: $error', 500);
    }
  }}
