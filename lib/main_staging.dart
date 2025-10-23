import 'package:javerage_todos/core/app/app.dart';
import 'package:javerage_todos/core/bootstrap.dart';

Future<void> main() async {
  await bootstrap((todosRepository) => App(todosRepository: todosRepository));
}
