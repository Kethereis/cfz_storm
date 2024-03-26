import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cfz_storm/data/responseData.dart';
import 'package:cfz_storm/layout/web/widgets/cadastrar_proposta.dart';
import 'package:cfz_storm/layout/web/widgets/selecionarOferta.dart';
import 'package:cfz_storm/layout/web/widgets/verifica_cpf.dart';
import 'package:cfz_storm/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class HomeScreenWeb extends StatefulWidget {
  int step;
  HomeScreenWeb({super.key, required this.step});
  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}
class _HomeScreenWebState extends State<HomeScreenWeb> {

  TextEditingController _cpfController = TextEditingController();
  bool _consultaCpf = true;
  late int _index = widget.step ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,

      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          SizedBox(
          child: Card(
          child: getPageWidget(),
          ),
          )

      ],)
    );
  }
  Widget getPageWidget() {
    switch (_index) {
      case 0:
        return VerificaCpfWidgetWeb();
      case 1:
        return CadastrarProposta(token: tokenAuthData, cpf: cpfData,);
      case 2:
        return SelecionarOferta(token: tokenAuthData);
      default:
        return VerificaCpfWidgetWeb();
    }
  }

}