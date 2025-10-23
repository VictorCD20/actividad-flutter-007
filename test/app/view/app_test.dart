import 'package:flutter_test/flutter_test.dart';
import 'package:javerage_todos/core/app/app.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos_repository/todos_repository.dart';

class MockTodosRepository extends Mock implements TodosRepository {}

void main() {
  group('App', () {
    late TodosRepository todosRepository;

    setUp(() {
      todosRepository = MockTodosRepository();
    });

    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(todosRepository: todosRepository),
      );
      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
