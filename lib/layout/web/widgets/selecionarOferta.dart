import 'dart:convert';
import 'package:cfz_storm/layout/web/home_screen_web.dart';
import 'package:cfz_storm/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../components/card_widget.dart';
import '../../../components/inputText_widget.dart';
import '../../../data/responseData.dart';
import '../../../service/selecionarOfertaService.dart';

class SelecionarOferta extends StatefulWidget {
  final String token;
  SelecionarOferta({
    Key? key,
    required this.token,
  }) : super(key: key);
  @override
  _SelecionarOfertaState createState() => _SelecionarOfertaState();
}
class _SelecionarOfertaState extends State<SelecionarOferta> {

  List<TextEditingController> controllersList = [];
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> adicionais = [];
  int? selectedCardIndex;
  bool _validaProposta = false;
  FocusNode textFocusNode = FocusNode();
  String valorDinamico = '20x R\$ 189,23';
  int _selectedItem = 0;

  void limpaCampos(){
    _controller.clear();
  }
  Future<void> selecionarOferta() async {
    for (int i = 0; i < controllersList.length; i++) {
      String valor = controllersList[i].text;
      int convenioDadosId = convenioDadosData[i]["convenioDadosId"];

      Map<String, dynamic> adicional = {
        "convenioDadosId": convenioDadosId,
        "valor": valor,
        "convenioId": convenioIdData,
      };

      adicionais.add(adicional);
    }


    setState(() {
      _validaProposta = true;
    });
    try {
      var response = await SelecionarOfertaService.selecionarOferta(
          propostaIdData,
          planoSelecionadoData,
          prestacaoSelecionadoData,
          adicionais,
          widget.token);
      var responseData = jsonDecode(response.body);
      var success = responseData['success'];
      var data = responseData['data'];

      if(success == true){
        setState(() {
          _validaProposta = false;
        });
        print(data);
        // Navigator.pop(context);
        // Navigator.push(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (_, __, ___) => HomeScreenWeb(step: 3),
        //     transitionDuration: const Duration(milliseconds: 1),
        //     transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
        //   ),
        // );

        print("Sucesso!!");

      }else{
        print("Falha!!");

      }

    } catch (error) {
      print('Erro durante o login: $error');

    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.26,
      height: MediaQuery.of(context).size.height * 0.57,
    child:  Card(
          elevation: 10,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.03,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Escolha a quantidade de parcelas:"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: (){
                          print("20 parcelas!!");
                          setState(() {
                            valorDinamico = '20x R\$ 189,23';
                            _selectedItem = 0;
                          });
                        },
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.07,
                            height: MediaQuery.of(context).size.height * 0.07,
                            child:  Card(
                                elevation: 5,
                                color: _selectedItem == 0 ?Colors.green : Colors.white,
                                surfaceTintColor: Colors.white,
                                child:
                                Center(
                                  child:Text('20x', style: TextStyle(color: _selectedItem == 0 ?Colors.white : Colors.black),),
                                )
                            )
                        )
                    ),
                    InkWell(
                        onTap: (){
                          print("18 parcelas!!");
                          setState(() {
                            valorDinamico = '18x R\$ 209,23';
                            _selectedItem = 1;
                          });
                        },
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.07,
                            height: MediaQuery.of(context).size.height * 0.07,
                            child:  Card(
                                elevation: 5,
                                color: _selectedItem == 1 ?Colors.green : Colors.white,
                                surfaceTintColor: Colors.white,
                                child:
                                Center(
                                  child:Text('18x', style: TextStyle(color: _selectedItem == 1 ?Colors.white : Colors.black),),
                                )
                            )
                        )
                    ),
                    InkWell(
                        onTap: (){
                          setState(() {
                            valorDinamico = '16x R\$ 229,23';
                            _selectedItem = 2;
                          });
                          print("16 parcelas!!");
                        },
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.07,
                            height: MediaQuery.of(context).size.height * 0.07,
                            child:  Card(
                                elevation: 5,
                                surfaceTintColor: Colors.white,
                                color: _selectedItem == 2 ?Colors.green : Colors.white,
                                child:
                                Center(
                                  child:Text('16x', style: TextStyle(color: _selectedItem == 2 ?Colors.white : Colors.black)),
                                )
                            )
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 40,),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                    Column(children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2 ,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Limite:", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(
                                "R\$ 1.300,00",
                                style: TextStyle(
                                    fontSize: 36,
                                    color: Colors.green
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                    ),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                    Column(children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2 ,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Text("Parcelas:", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(
                                valorDinamico,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.25,
                  color: Colors.grey.withOpacity(0.3),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: CircleAvatar(
                              backgroundColor: Colors.green.withOpacity(0.2),
                              radius: 15,
                              child: Image.asset(
                                'assets/money.png',
                                width: 15,
                                height: 15,
                              )
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                        const Text("Disponível em até 24h",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: CircleAvatar(
                              backgroundColor: Colors.red.withOpacity(0.2),
                              radius: 15,
                              child: const Icon(
                                Icons.warning,
                                color: Colors.red,
                                size: 15,
                              )
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                        const Text("Não requer valor antecipado",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.025,),

                Center(
                    child: InkWell(
                      onTap: (){
                        print("Oferta Selecionada");
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.055,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child:const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // const Icon(Icons.tap, color: Colors.white, size: 20,),
                              // SizedBox(width: MediaQuery.of(context).size.width * 0.015,),
                              Text("Selecionar Oferta",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),)

                            ],)),)),



              ],
            ),
          )
      ),
    );
  }
}