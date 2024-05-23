import 'package:pk_shared/dependencies/go_router.dart';

extension GoRouterStateExtension on GoRouterState {
  dynamic params(String key) {
    return pathParameters.containsKey(key) ? pathParameters[key]! : null;
  }
}
