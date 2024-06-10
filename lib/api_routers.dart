import 'dart:async' show Future, FutureOr;
import 'dart:developer';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

class ApiRouters {


  void api ()async{
    final service = apiAPi();
    final router = Router()
      ..get('/health', service.hello); // تعيين المعالج للمسار '/health'

    final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

    shelf_io.serve(handler, 'webdevapi.000webhostapp.com/', 80).then((server) {
      print('Serving at http://${server.address.host}:${server.port}');
    });
  }
}

class apiAPi{
  @Route.get('/hello')
  FutureOr<Response> hello(Request request) {
    return Response.ok('Hello, World!');
  }
}