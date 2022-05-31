import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'dart:convert';

void main() async{
  var _server = ServerHandler();

final server = await shelf_io.serve(
  _server.handler, 'localhost', 54321);
print('Servidor Iniciado com sucesso! http://localhost:54321');
}
//home
//Primeira Rota
class ServerHandler {
  Handler get handler {
final router = Router();
router.get('/', (Request request){
return Response(200, body: '<h1>Primeira Rota HTML</h1>', headers: { 'Content-Type': 'text/html'});
});
//get
// http://localhost:8080/ola/mundo
// ola mundo
router.get('/ola/mundo/<usuario>', (Request req, String usuario){
  return Response.ok("Olá Mundo $usuario");
});
//get
// http://localhost:8080/query?nome=Will&idade=37
router.get('/user', (Request req){
  String? nome = req.url.queryParameters['nome'];
    String? idade = req.url.queryParameters['idade'];
  return Response.ok('User é: $nome de idade: $idade anos');
});
//post
// http://localhost:8080/login
/* {
    "login": "Will",
    "senha": "123"
}*/
router.post('/login', (Request req) async {
  var result = await req.readAsString();
  Map json = jsonDecode(result);
var login = json ['login'];
var senha = json['senha'];
    if (login == 'Will' && senha == '123') {
      Map result ={ 'token': 'token:0001=>2022', 'user_id': 1};
      var jsonResponse = jsonEncode(result);
      return Response.ok(
        jsonResponse,
        headers: {'Content-Type': 'application/json'});
    } else {
      return Response.forbidden('Acesso Negado - Dados de Autenticação Incorretos');
    }
});


return router;
  }  
}