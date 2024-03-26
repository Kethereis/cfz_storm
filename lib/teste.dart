import 'package:cfz_storm/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'layout/mobile/home_screen_mobile.dart';
import 'layout/web/home_screen_web.dart';

void main() {
  runApp(TesteApp());
}

class TesteApp extends StatefulWidget {
  TesteApp({
    Key? key,
  }) : super(key: key);

   @override
   _TesteAppState createState() => _TesteAppState();
}
class _TesteAppState extends State<TesteApp> {

  String valorDinamico = '20x R\$ 189,23';
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crefaz Storm',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width * 0.26,
          height: MediaQuery.of(context).size.height * 0.57,
    child: Card(
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
        ),
      )
    );
  }
}