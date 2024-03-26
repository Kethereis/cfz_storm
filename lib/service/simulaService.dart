import 'dart:convert';
import '../utils/enpoints.dart';
import 'package:http/http.dart' as http;

import '../data/responseData.dart';


class SimulaService{

  static Future<http.Response> simula(
      String propostaId,
      int produtoId,
      int convenioId,
      int tabelaJuroId,
      String vencimento,
      double renda,
      double valor,
      String authToken) async {
    var simulaUrl = Uri.parse('$simulaRoute$propostaId');
    var payload = jsonEncode({
      "produtoId": produtoId,
       "convenioId": convenioId,
      "tabelaJurosId": tabelaJuroId,
      "valor": valor,
      "tipoCalculo": 0,
      "vencimento": vencimento,
      "renda": renda,
      "recalculo": null,
      "contrato": null

    });

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };

    try {
      var response = await http.post(
        simulaUrl,
        body: payload,
        headers: headers,
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = responseData['data'];
        var listaSimulado = data['prazoValor'];
        print(listaSimulado);
        simulacaoData = listaSimulado;

        print("SimulacaoData: $simulacaoData");


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
