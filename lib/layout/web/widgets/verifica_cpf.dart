import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cfz_storm/layout/web/home_screen_web.dart';
import 'package:cfz_storm/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../data/responseData.dart';
import '../../../service/authService.dart';

class VerificaCpfWidgetWeb extends StatefulWidget {
  VerificaCpfWidgetWeb({super.key});
  @override
  State<VerificaCpfWidgetWeb> createState() => _VerificaCpfWebState();
}

class _VerificaCpfWebState extends State<VerificaCpfWidgetWeb> {
  final TextEditingController _cpfController = TextEditingController();
  bool _consultaCpf = true;
  final List _cpfExample = ['480.128.298-94', '487.904.498-94'];
  AuthService authService = AuthService();


  Future<void> login() async {
    try {
      var response = await authService.login('KETHERFREITAS', '123456', '63b34932-d4de-4022-8085-f308911a6496');
      var responseData = jsonDecode(response.body);
      var success = responseData['success'];
      var data = responseData['data'];
      var errors = responseData['errors'];
      if(success == true){
        var token = data["token"];
        tokenAuthData = token;
        print("Sucesso ao Logar!!");
        print(tokenAuthData);
        cpfData = _cpfController.text;
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => HomeScreenWeb(step: 1),
            transitionDuration: const Duration(milliseconds: 1),
            transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
          ),
        );
      }else{
        var listaErro = errors[0];
        print("Falha!! Erro: $listaErro");
      }
    } catch (error) {
      print('Erro durante o login: $error');
      // Trate o erro, se necessário
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          // Adicione a imagem de fundo aqui
          // Image.asset(
          //   'assets/teste.jpg',
          //   fit: BoxFit.cover,
          //   width: double.infinity,
          //   height: double.infinity,
          // ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * 0.28),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.32,
                            child: Card(
                              elevation: 10,
                              surfaceTintColor: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Para começar, digite o seu CPF: ",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SizedBox(
                                        width:
                                        MediaQuery.of(context).size.width * 1,
                                        child: TextFormField(
                                          enabled: _consultaCpf,
                                          controller: _cpfController,
                                          keyboardType:
                                          TextInputType.emailAddress,
                                          inputFormatters: [
                                            MaskTextInputFormatter(
                                                mask: '###.###.###-##',
                                                filter: {
                                                  "#": RegExp(r'[0-9]')
                                                }
                                                ),
                                          ],
                                          decoration: InputDecoration(
                                            filled: true,
                                            labelText: 'CPF',
                                            hintText: '',
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(0.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.0),
                                            ),
                                            enabledBorder:
                                            const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(0.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.black12,
                                                  width: 1.0),
                                            ),
                                            focusedBorder:
                                            const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(0.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.black12,
                                                  width: 1.0),
                                            ),
                                            contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                            fillColor: Colors.white
                                                .withOpacity(0.4),
                                          ),
                                          onChanged: (value) async {
                                            if (value.length == 14) {
                                              print("Cpf digitado: $value");
                                              setState(() {
                                                _consultaCpf = false;
                                              });
                                              Future.delayed(const Duration(seconds: 7), () {
                                                if(_cpfExample.contains(value)){
                                                  print("CPF CONSTA NA BASE");
                                                  login();
                                                }else{
                                                  print("CLIENTE NOVO");
                                                  login();
                                                }
                                                setState(() {
                                                  _consultaCpf = true;
                                                }
                                                );
                                              }
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    _consultaCpf
                                        ? Container()
                                        : Column(
                                      children: [
                                        LinearProgressIndicator(
                                          color: primaryColor,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.025,
                                          child: DefaultTextStyle(
                                            style: const TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black),
                                            child: AnimatedTextKit(
                                              totalRepeatCount: 1,
                                              animatedTexts: [
                                                RotateAnimatedText('Verificando CPF...', duration: const Duration(milliseconds: 1000)),
                                                RotateAnimatedText('Consultado se há propostas em andamento...', duration: const Duration(milliseconds: 1000)),
                                                RotateAnimatedText('Concluindo consulta, você está sendo redirecionado.', duration: const Duration(milliseconds: 3000)),
                                              ],
                                              onTap: () {
                                                print("Tap Event");
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
    );
  }
}
