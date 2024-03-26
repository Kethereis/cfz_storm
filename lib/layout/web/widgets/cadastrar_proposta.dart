import 'dart:convert';

import 'package:cfz_storm/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../components/inputText_widget.dart';
import '../../../data/responseData.dart';
import '../../../service/calcularVencimento.dart';
import '../../../service/cidadeService.dart';
import '../../../service/limiteService.dart';
import '../../../service/listarOfertaService.dart';
import '../../../service/p1Service.dart';
import '../../../service/simulaService.dart';
import '../home_screen_web.dart';


class CadastrarProposta extends StatefulWidget {
  final String token;
  final String cpf;

  CadastrarProposta({
    Key? key,
    required this.token,
    required this.cpf
  }) : super(key: key);
  @override
  _CadastrarPropostaState createState() => _CadastrarPropostaState();
}
class _CadastrarPropostaState extends State<CadastrarProposta> {

  late TextEditingController _nomeController = TextEditingController();
  late TextEditingController _cpfController = TextEditingController();
  late TextEditingController _nascimentoController = TextEditingController();
  late TextEditingController _cepController = TextEditingController();
  late TextEditingController _logradouroController = TextEditingController();
  late TextEditingController _bairroController = TextEditingController();
  late TextEditingController _telefoneController = TextEditingController();
  late TextEditingController _ocupacaoController = TextEditingController();
  late TextEditingController _cidadeController = TextEditingController();
  late TextEditingController _estadoController = TextEditingController();
  FocusNode textFocusNode = FocusNode();
  bool _validaProposta = false;
  
  String regexString(String valor){
    String cleanedString = valor.replaceAll(RegExp(r'[().-]'), '');
    return cleanedString;
  }
  void limpaCampos(){
    _nomeController.clear();
    _nascimentoController.clear();
    _cepController.clear();
    _logradouroController.clear();
    _bairroController.clear();
    _telefoneController.clear();
    _ocupacaoController.clear();
  }
  Future<void> buscaCidade() async {
    setState(() {
      cepData = regexString(_cepController.text);
      _validaProposta = true;
    });
    try {
      var response = await CidadeService.buscaCidade(_cidadeController.text, _estadoController.text, widget.token);
      var responseData = jsonDecode(response.body);
      var success = responseData['success'];
      var data = responseData['data'];

      if(success == true){
        var cidadeId = data[0]["cidadeId"];
        setState(() {
          _cidadeController.text = cidadeId.toString();
          cidadeIdData = cidadeId;
        });
        cadastrarProposta();

      }else{

        // QuickAlert.show(
        //   context: context,
        //   type: QuickAlertType.custom,
        //   barrierDismissible: false,
        //   confirmBtnText: 'Ok',
        //   confirmBtnColor: Colors.orange,
        //   customAsset: 'assets/warning.gif',
        //   widget: Container(),
        //   onConfirmBtnTap: () async {
        //     setState(() {
        //       _validaProposta = false;
        //     });
        //     Navigator.pop(context);
        //   },
        //   title: 'Falha ao processar dados!',
        //   text: 'Por favor, revise os seus dados.',
        // );
      }
    } catch (error) {
      print('Erro durante o login: $error');
      // QuickAlert.show(
      //   context: context,
      //   type: QuickAlertType.custom,
      //   barrierDismissible: false,
      //   confirmBtnText: 'Ok',
      //   confirmBtnColor: Colors.orange,
      //   customAsset: 'assets/warning.gif',
      //   widget: Container(),
      //   onConfirmBtnTap: () async {
      //     setState(() {
      //       _validaProposta = false;
      //     });
      //     Navigator.pop(context);
      //   },
      //   title: 'Falha ao processar dados!',
      //   text: 'Motivo: $error',
      // );
      // Trate o erro, se necessário
    }
  }
  String formatarData(String dataFormatada) {
    // Divide a data em dia, mês e ano
    List<String> partes = dataFormatada.split('/');
    int dia = int.parse(partes[0]);
    int mes = int.parse(partes[1]);
    int ano = int.parse(partes[2]);

    // Cria um objeto DateTime
    DateTime data = DateTime(ano, mes, dia);

    // Formata a data no formato desejado
    String dataFormatadaFinal = "${data.year}-${_formatarDoisDigitos(data.month)}-${_formatarDoisDigitos(data.day)}";

    return dataFormatadaFinal;
  }
  String _formatarDoisDigitos(int numero) {
    // Adiciona um zero à esquerda se o número for menor que 10
    return numero.toString().padLeft(2, '0');
  }
  int calcularIdade(String dataNascimento) {
    // Divide a data em dia, mês e ano
    List<String> partes = dataNascimento.split('/');
    int dia = int.parse(partes[0]);
    int mes = int.parse(partes[1]);
    int ano = int.parse(partes[2]);

    // Cria um objeto DateTime para a data de nascimento
    DateTime dataNasc = DateTime(ano, mes, dia);

    // Calcula a idade
    DateTime agora = DateTime.now();
    int idade = agora.year - dataNasc.year;

    // Verifica se já fez aniversário este ano
    if (agora.month < dataNasc.month || (agora.month == dataNasc.month && agora.day < dataNasc.day)) {
      idade--;
    }

    return idade;
  }
  Future<void> cadastrarProposta() async {
    setState(() {
      if(_ocupacaoController.text == 'Assalariado'){
        _ocupacaoController.text = '1';
      }else{
        _ocupacaoController.text = '3';
      }
    });
    var cidade = int.tryParse(_cidadeController.text);
    var ocupacao = int.tryParse(_ocupacaoController.text);
    var dataNascimento = formatarData(_nascimentoController.text);
    try {
      var response = await PropostaService.p1(
          regexString(_nomeController.text),
          regexString(_cpfController.text),
          dataNascimento.toString(),
          _logradouroController.text,
          _bairroController.text,
          cidade!,
          ocupacao!,
          regexString(_cepController.text),
          regexString(_telefoneController.text),
          widget.token
      );
      print(response.body);

      var responseData = jsonDecode(response.body);

      var success = responseData['success'];
      var data = responseData['data'];
      var errors = responseData['errors'];
      var aprovado = data['aprovado'];

      if(success == true){
        var propostaId = data["propostaId"];
        setState(() {
          propostaIdData = propostaId.toString();
        });
        if(aprovado == true) {
          var request = await ListarOfertaService.listarOferta(
              propostaId.toString(),
              widget.token
          );
          print("LISTOU OFERTA");
          var calculaVencimento = await VencimentoService.vencimento(
              propostaId.toString(),
              produtoIdData,
              convenioIdData,
              tabelaJurosIdData,
              widget.token
          );
          print("CALCULOU VENCIMENTO");
          var calcularLimite = await LimiteService.limite(
              propostaId.toString(),
              produtoIdData,
              convenioIdData,
              tabelaJurosIdData,
              vencimentoData,
              valorRendaPresumidaData,
              widget.token
          );
          print("CALCULOU LIMITE");
          var simulaOferta = await SimulaService.simula(
              propostaId.toString(),
              produtoIdData,
              convenioIdData,
              tabelaJurosIdData,
              vencimentoData,
              valorRendaPresumidaData,
              valorLimiteData,
              widget.token
          );
          print("SIMULOU PROPOSTA");

          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => HomeScreenWeb(step: 2),
              transitionDuration: const Duration(milliseconds: 1),
              transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
            ),
          );

          // QuickAlert.show(
          //   context: context,
          //   type: QuickAlertType.custom,
          //   barrierDismissible: false,
          //   confirmBtnText: 'Ok',
          //   confirmBtnColor: Colors.green,
          //   customAsset: 'assets/success.gif',
          //   widget: Container(),
          //   onConfirmBtnTap: () async {
          //     setState(() {
          //       _validaProposta = false;
          //     });
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => HomeScreen(token: widget.token, step: 1,)
          //       ),
          //     );
          //   },
          //   title: 'Sucesso!',
          //   text: 'Número da Proposta: $propostaId',
          // );
        }else{
          // QuickAlert.show(
          //   context: context,
          //   type: QuickAlertType.custom,
          //   barrierDismissible: false,
          //   confirmBtnText: 'Ok',
          //   confirmBtnColor: Colors.red,
          //   customAsset: 'assets/error.gif',
          //   widget: Container(),
          //   onConfirmBtnTap: () async {
          //     setState(() {
          //       _validaProposta = false;
          //     });
          //     Navigator.pop(context);
          //     limpaCampos();
          //   },
          //   title: 'Proposta Negada!',
          //   text: 'Infelizmente sua proposta foi negada.\n Número da Proposta: $propostaId',
          // );
        }
      }else{
        var listaErro = errors[0];
        // QuickAlert.show(
        //   context: context,
        //   type: QuickAlertType.custom,
        //   barrierDismissible: false,
        //   confirmBtnText: 'Ok',
        //   confirmBtnColor: Colors.orange,
        //   customAsset: 'assets/warning.gif',
        //   widget: Container(),
        //   onConfirmBtnTap: () async {
        //     setState(() {
        //       _validaProposta = false;
        //     });
        //     Navigator.pop(context);
        //   },
        //   title: 'Falha ao processar dados!',
        //   text: 'Motivo: $listaErro',
        // );

        print("Falha!!");

      }

    } catch (error) {
      print('Erro durante o login: $error');

      // QuickAlert.show(
      //   context: context,
      //   type: QuickAlertType.custom,
      //   barrierDismissible: false,
      //   confirmBtnText: 'Ok',
      //   confirmBtnColor: Colors.orange,
      //   customAsset: 'assets/warning.gif',
      //   widget: Container(),
      //   onConfirmBtnTap: () async {
      //     setState(() {
      //       _validaProposta = false;
      //     });
      //     Navigator.pop(context);
      //   },
      //   title: 'Falha ao processar dados!',
      //   text: 'Motivo: $error',
      // );
      // Trate o erro, se necessário
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => HomeScreenWeb(step: 2),
          transitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    print(cpfData);
    _cpfController.text = cpfData;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.01),
      child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.34,
      height: MediaQuery.of(context).size.height * 0.75,
      child: Card(
        elevation: 10,
        surfaceTintColor: Colors.white,
        child: Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Text("Dados Pessoais",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                ),),
              SizedBox(height: MediaQuery.of(context).size.width * 0.02,),
              Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.7 ,
                  color: Colors.grey.withOpacity(0.3)
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.01,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextField(
                      inputEnabled: false,
                      labelText: 'CPF',
                      controller: _cpfController,
                      onChanged: (value) async {
                        if (value.length == 11) {
                          String cpf = _cpfController.text;
                          String cpfClean = cpf.replaceAll(RegExp(r'[^\d]'), '');
                          print(cpfClean);
                          var urlReceita = Uri.parse('https://ws.hubdodesenvolvedor.com.br/v2/nome_cpf/?cpf=$cpfClean&token=141679065mQRNtZVhEX255797256');
                          var responseReceita = await http.get(urlReceita);
                          print(responseReceita);
                          if (responseReceita.statusCode == 200) {
                            Map<String, dynamic> parsedJson = jsonDecode(responseReceita.body);
                            if (parsedJson['status'] == true && parsedJson['return'] == 'OK') {
                              Map<String, dynamic> result = parsedJson['result'];
                              String nome = result['nome'];
                              String dataNascimento = result['data_de_nascimento'];
                              //String lastUpdate = result['last_update'];
                              _nomeController.text = nome;
                              _nascimentoController.text = dataNascimento;
                              var idade = calcularIdade(_nascimentoController.text);
                              print(idade);
                              setState(() {
                                _ocupacaoController.text = (idade > 60) ? "Aposentado" : "Assalariado";
                              });
                            } else {
                              print('Erro na resposta da API');
                            }
                          } else {
                            print('Erro na solicitação: ${responseReceita.statusCode}');
                          }
                        }
                      },
                    ),
                    CustomTextField(labelText: 'Nome Completo', controller: _nomeController,),
                  ]),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextField(labelText: 'Data de Nascimento', controller: _nascimentoController,
                      mask: MaskTextInputFormatter(
                        mask: '##/##/####',
                        filter: {
                        "#": RegExp(r'[0-9]')
                        }),
                      onChanged: (value) async {
                        if (value.length == 10) {
                          var idade = calcularIdade(_nascimentoController.text);
                          print(idade);
                          setState(() {
                            _ocupacaoController.text = (idade > 60) ? "Aposentado" : "Assalariado";
                          });
                        }
                      },),
                    CustomTextField(labelText: 'Telefone', controller: _telefoneController,
                      mask: MaskTextInputFormatter(
                          mask: '(##)#####-####',
                          filter: {
                            "#": RegExp(r'[0-9]')
                          }),
                    ),
                  ]),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextField(labelText: 'CEP',
                        mask: MaskTextInputFormatter(
                            mask: '#####-###',
                            filter: {
                              "#": RegExp(r'[0-9]')
                            }),
                        controller: _cepController,
                        onChanged: (value) async {
                          if (value.length == 9) {
                            String cep = regexString(_cepController.text);
                            print(cep);
                            var urlCep = Uri.parse('https://viacep.com.br/ws/$cep/json/');
                            print(urlCep);
                            textFocusNode.unfocus();
                            var response = await http.get(urlCep);
                            if (response.statusCode == 200) {
                              var jsonResponse = json.decode(response.body);
                              print(jsonResponse);
                              String cidade = jsonResponse['localidade'];
                              String rua = jsonResponse['logradouro'];
                              String estado = jsonResponse['uf'];
                              String bairro = jsonResponse['bairro'];
                              String ibge = jsonResponse['ibge'];
                              setState(() {
                                _logradouroController.text = rua;
                                _cidadeController.text = cidade;
                                _estadoController.text = estado.toUpperCase();
                                _bairroController.text = bairro;
                                print('${rua}, ${bairro} - ${cidade}/${estado.toUpperCase()}');

                              });}}}

                    ),

                    CustomTextField(labelText: 'Bairro', controller: _bairroController,),
                  ]),

              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    CustomTextField(labelText: 'Logradouro', controller: _logradouroController,),
                    //CustomTextField(labelText: 'Ocupação', controller: _ocupacaoController,
                   // ),
                  ]),

              SizedBox(height: MediaQuery.of(context).size.width * 0.01,),
              Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.7 ,
                  color: Colors.grey.withOpacity(0.3)
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.01,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: limpaCampos,
                    child: const Text("Limpar Campos",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),),),
                  _validaProposta ? Column(mainAxisAlignment: MainAxisAlignment.center ,children:[
                    CircularProgressIndicator(color: primaryColor, strokeWidth: 3,)],):
                  InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => HomeScreenWeb(step: 2),
                            transitionDuration: const Duration(milliseconds: 1),
                            transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                          ),
                        );
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check, color: Colors.white,),
                               SizedBox(width: 5,),
                               Text("Confirmar",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),)
                            ])
                      ))
                ],)

            ],
          )
      ),
      )
      ));


  }}