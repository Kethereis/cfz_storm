import 'dart:convert';
import '../utils/enpoints.dart';
import 'package:http/http.dart' as http;


class PropostaService{

  static Future<http.Response> p1(
      String nome,
      String cpf,
      String dataNascimento,
      String logradouro,
      String bairro,
      int cidadeId,
      int ocupacao,
      String cep,
      String telefone,
      String authToken,) async {
    print(nome);
    print(cpf);
    print(dataNascimento);
    print(logradouro);
    print(bairro);
    print(cidadeId);
    print(ocupacao);
    print(cep);
    print(telefone);

    var cadastroUrl = Uri.parse(cadastrarRoute);
    var payload = jsonEncode({
      "nome": nome,
      "cpf": cpf,
      "nascimento": dataNascimento,
      "telefone": telefone,
      "ocupacaoId": ocupacao,
      "cep": cep,
      "cidadeId": cidadeId,
      "bairro": bairro,
      "logradouro": logradouro,
      "urlNotificacaoParceiro": "localhost"
    });
    print(payload);

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',

    };
    print(payload);

    try {
      var response = await http.post(
        cadastroUrl,
        body: payload,
        headers: headers,
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (error) {
      print('Erro na solicitação: $error');
      return http.Response('Erro na solicitação: $error', 500);
    }
  }}
