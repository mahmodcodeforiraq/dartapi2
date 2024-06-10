import 'dart:async' show Future, FutureOr;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';


class Service {
  // يتم تعليق المعالج باستخدام @Route.<verb>('<route>')
  @Route.get('/hello')
  FutureOr<Response> hello(Request request) {
    return Response.ok('Hello, World!');
  }

// يمكنك إضافة المزيد من المعالجين هنا
}

void main() {
  final service = Service();
  final router = Router()
    ..get('/health', service.hello); // تعيين المعالج للمسار '/health'

  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  shelf_io.serve(handler, 'assorted-smoggy-impala.glitch.me', 443).then((server) {
    print('Serving at https://${server.address.host}:${server.port}');
  });

}
