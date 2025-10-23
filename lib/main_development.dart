import 'package:javerage_todos/app/app.dart';
import 'package:javerage_todos/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
