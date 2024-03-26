import 'dart:convert';
import '../data/responseData.dart';
import '../utils/enpoints.dart';
import 'package:http/http.dart' as http;


class EnviaAnaliseService{

  static Future<http.Response> enviaAnalise() async {
    var analiseUrl = Uri.parse('$analiseRoute$propostaIdData');
    var payload = jsonEncode(
        {
          "id": int.parse(propostaIdData),
          "cliente": {
            "nome": "Usuario Teste",
            "rg": "1234569",
            "rgEmissor": "SSP",
            "rgUfId": "25",
            "rgEmissao": "2018-08-28",
            "sexo": 1,
            "estadoCivil": 0,
            "nacionalidadeId": 1,
            "naturalidadeUfId": 1,
            "naturalidadeCidadeId": 25,
            "grauInstrucaoId": 5,
            "nomeMae": "Teste Cfz",
            "nomeConjuge": "Teste CfZ",
            "pep": false
          },
          "contatos": {
            "contato": {
              "email": "kether.freitas@crefaz.com.br",
              "telefone": "44988175773",
              "telefoneExtra": []
            },
            "referencia": [
              {
                "nome": "Kether",
                "telefone": "44988175773",
                "grau": 1
              },
              {
                "nome": "Kether Reis",
                "telefone": "44988175773",
                "grau": 1
              }
            ]
          },
          "endereco": {
            "cep": cepData,
            "logradouro": "Rua Teste",
            "numero": 286,
            "bairro": "Centro",
            "complemento": "Nenhum",
            "cidadeId": cidadeIdData
          },
          "bancario": {
            "bancoId": "001",
            "agencia": "0123",
            "digito": "4",
            "numero": "012345",
            "conta": 1,
            "tipoConta": 0,
            "tempoConta": 1
          },
          "profissional": {
            "empresa": "Crefaz",
            "profissaoId": 3,
            "tempoEmpregoAtual": 3,
            "telefoneRH": null,
            "pisPasep": null,
            "renda": valorRendaPresumidaData,
            "tipoRenda": 0,
            "outrasRendas": null,
            "tipoOutrasRendas": null
          },
          "unidade": {
            "nomeVendedor": "Kether",
            "cpfVendedor": "48012829894",
            "celularVendedor": "44988175573"
          },
          "operacao": {
            "produtoId": produtoIdData,
            "diaRecebimento": 5,
            "tipoModalidade": 2,
            "convenioId": convenioIdData,
            "vencimento": vencimentoData,
            "tabelaJurosId": tabelaJurosIdData,
            "valorContratado": valorLimiteData,
            "prazo": planoSelecionadoData,
            "prestacao": prestacaoSelecionadoData,
            "renda": valorRendaPresumidaData,
            "tipoRenda": 0,
            "tipoCalculo": 0
          }
        }
    );

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenAuthData',

    };
    print(payload);
    print(analiseUrl);

    try {
      var response = await http.put(
        analiseUrl,
        body: payload,
        headers: headers,
      );
      var responseData = jsonDecode(response.body);
      print(responseData);


      if (response.statusCode == 200) {

        return response;
      } else {
        var erro = responseData['errors'];
        print('Erro: $erro');

        return response;
      }
    } catch (error) {
      print('Erro na solicitação: $error');
      return http.Response('Erro na formatação da apiKey: $error', 500);
    }
  }}
