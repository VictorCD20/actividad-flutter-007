import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:javerage_todos/features/edit_todo/view/edit_todo_page.dart';
import 'package:javerage_todos/features/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:javerage_todos/features/todos_overview/models/models.dart';

import 'package:javerage_todos/features/todos_overview/widgets/todo_list_tile.dart';
import 'package:javerage_todos/l10n/l10n.dart';

class TodosOverviewPage extends StatelessWidget {
  const TodosOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosOverviewBloc(
        todosRepository: context.read(),
      )..add(const TodosOverviewSubscriptionRequested()),
      child: const TodosOverviewView(),
    );
  }
}

class TodosOverviewView extends StatelessWidget {
  const TodosOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.todosOverviewAppBarTitle),
        actions: [
          PopupMenuButton<TodosViewFilter>(
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            tooltip: l10n.todosOverviewFilterTooltip,
            onSelected: (filter) {
              context
                  .read<TodosOverviewBloc>()
                  .add(TodosOverviewFilterChanged(filter));
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: TodosViewFilter.all,
                  child: Text(l10n.todosOverviewFilterAll),
                ),
                PopupMenuItem(
                  value: TodosViewFilter.activeOnly,
                  child: Text(l10n.todosOverviewFilterActiveOnly),
                ),
                PopupMenuItem(
                  value: TodosViewFilter.completedOnly,
                  child: Text(l10n.todosOverviewFilterCompletedOnly),
                ),
              ];
            },
            icon: const Icon(Icons.filter_list_rounded),
          ),
          PopupMenuButton<void>(
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            tooltip: l10n.todosOverviewOptionsTooltip,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text(l10n.todosOverviewOptionsMarkAllComplete),
                  onTap: () => context
                      .read<TodosOverviewBloc>()
                      .add(const TodosOverviewToggleAllRequested()),
                ),
                PopupMenuItem(
                  child: Text(l10n.todosOverviewOptionsClearCompleted),
                  onTap: () => context
                      .read<TodosOverviewBloc>()
                      .add(const TodosOverviewClearCompletedRequested()),
                ),
              ];
            },
          ),
        ],
      ),
      body: BlocConsumer<TodosOverviewBloc, TodosOverviewState>(
        listenWhen: (previous, current) =>
            previous.status != current.status ||
            previous.lastDeletedTodo != current.lastDeletedTodo,
        listener: (context, state) {
          if (state.status == TodosOverviewStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(l10n.todosOverviewErrorSnackbarText),
                ),
              );
          } else if (state.lastDeletedTodo != null) {
            final messenger = ScaffoldMessenger.of(context);
            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    l10n.todosOverviewTodoDeletedSnackbarText(
                      state.lastDeletedTodo!.title,
                    ),
                  ),
                  action: SnackBarAction(
                    label: l10n.todosOverviewUndoDeletionButtonText,
                    onPressed: () {
                      messenger.hideCurrentSnackBar();
                      context
                          .read<TodosOverviewBloc>()
                          .add(const TodosOverviewUndoDeletionRequested());
                    },
                  ),
                ),
              );
          }
        },
        builder: (context, state) {
          if (state.todos.isEmpty) {
            if (state.status == TodosOverviewStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status != TodosOverviewStatus.success) {
              return const SizedBox();
            } else {
              return Center(
                child: Text(
                  l10n.todosOverviewEmptyText,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            }
          }

          return ListView(
            children: [
              for (final todo in state.filteredTodos)
                TodoListTile(
                  todo: todo,
                  onToggleCompleted: (isCompleted) {
                    context.read<TodosOverviewBloc>().add(
                          TodosOverviewTodoCompletionToggled(
                            todo: todo,
                            isCompleted: isCompleted,
                          ),
                        );
                  },
                  onDismissed: (_) {
                    context
                        .read<TodosOverviewBloc>()
                        .add(TodosOverviewTodoDeleted(todo));
                  },
                  onTap: () {
                    Navigator.of(context).push(
                      EditTodoPage.route(initialTodo: todo),
                    );
                  },
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('homeView_addTodo_floatingActionButton'),
        onPressed: () => Navigator.of(context).push(EditTodoPage.route()),
        child: const Icon(Icons.add),
      ),
    );
  }
}