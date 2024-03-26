import 'dart:convert';
import '../utils/enpoints.dart';
import 'package:http/http.dart' as http;

import '../data/responseData.dart';


class LimiteService{

  static Future<http.Response> limite(
      String propostaId,
      int produtoId,
      int convenioId,
      int tabelaJuroId,
      String vencimento,
      double renda,
      String authToken) async {
    var limiteUrl = Uri.parse('$limiteRoute$propostaId');
    var payload = jsonEncode({
      "produtoId": produtoId,
      "convenioId": convenioId,
      "tabelaJurosId": tabelaJuroId,
      "vencimento": vencimento,
      "renda": renda,

    });

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',

    };

    try {
      var response = await http.post(
        limiteUrl,
        body: payload,
        headers: headers,
      );
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = responseData['data'];
        var valorLimite = data['valorLimiteSolicitado'];
        var valorParcela = data['valorLimiteParcela'];

        valorLimiteData = valorLimite;
        valorLimiteParcelaData = valorParcela;


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
