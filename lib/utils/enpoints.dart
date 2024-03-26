
import '../data/responseData.dart';

const homologacao = 'https://app-crefaz-api-external-stag.azurewebsites.net/api/';
const producao = 'https://api-externo.crefazon.com.br/api/';
const initialUrl = homologacao;

/// ROTAS
 const loginRoute = "${initialUrl}Usuario/login";
 const cadastrarRoute = "${initialUrl}Proposta";
const cidadeRoute = "${initialUrl}Endereco/Cidade";
String listarOfertaRoute = "${initialUrl}Proposta/oferta-produto/";
String vencimentoRoute = "${initialUrl}Proposta/calculo-vencimento";
String limiteRoute = "${initialUrl}Proposta/consulta-valor-limite/";
String simulaRoute = "${initialUrl}Proposta/simulacao-valor/";
String selecionarRoute = "${initialUrl}Proposta/oferta-produto/";
String documentoRoute = "${initialUrl}Proposta/$propostaIdData/imagem";
String analiseRoute = "${initialUrl}Proposta/";