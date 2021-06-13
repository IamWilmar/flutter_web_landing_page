import 'package:fluro/fluro.dart';
import 'package:vertical_landing_page/router/router_handlers.dart';

class Flurorouter {
  static FluroRouter router = new FluroRouter();

  //Routes
  static void configureRoutes() {
    //home route
    router.define('/:page', handler: homeHandler);
    //404
    router.notFoundHandler = homeHandler;
  }
}
