import 'dart:convert';
import '../utils/enpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../data/responseData.dart';


class VencimentoService{

  static Future<http.Response> vencimento(String propostaId, int produtoId, int convenioId, int tabelaJuroId, String authToken) async {
    var vencimentoUrl = Uri.parse(vencimentoRoute);
    print(propostaId);
    print(convenioId);
    print(produtoId);
    print(tabelaJuroId);
    var payload = jsonEncode({
      "propostaId": propostaId,
      "convenioId": convenioId,
      "produtoId": produtoId,
      "tabelaJurosId": tabelaJuroId,
    });

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',

    };

    try {
      var response = await http.post(
        vencimentoUrl,
        body: payload,
        headers: headers,
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(response.body);
        var data = responseData['data'];
        print(data);
        var vencimento = data[0]['vencimento'];
        print(vencimento);
        vencimentoData = vencimento;


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
