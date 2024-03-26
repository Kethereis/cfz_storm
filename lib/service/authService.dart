import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/enpoints.dart';


class AuthService{

Future<http.Response> login(String login, String senha, String apiKey) async {
  var loginUrl = Uri.parse(loginRoute);
  var payload = jsonEncode({
    'login': login,
    'senha': senha,
    'apiKey': apiKey
  });

  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  try {
    var response = await http.post(
      loginUrl,
      body: payload,
      headers: headers,
    );
    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var data = responseData['data'];
      var nome = data['nome'];
      var login = data['login'];
      var token = data['token'];

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
