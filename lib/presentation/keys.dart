// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';

class ReaderKeys {
  // Home Screens
  static final homeScreen = const Key('__homeScreen__');
  static final addTodoFab = const Key('__addTodoFab__');
  static final snackbar = const Key('__snackbar__');
  static Key snackbarAction(String id) => new Key('__snackbar_action_${id}__');

  // Feed Entries
  static final feedEntriesList = const Key('__feedEntriesList__');
  static final feedEntriesLoading = const Key('__feedEntriesLoading__');
  static final feedEntryItem = (String id) => new Key('feedEntryItem__$id');
  static final feedEntryItemTitle =
      (String id) => new Key('FeedEntryItem__${id}__Title');
  static final feedEntryStar =
      (String id) => new Key('FeedEntryItem__${id}__Star');

  // Feed Infos
  static final feedInfosList = const Key('__feedInfosList__');
  static final feedInfosLoading = const Key('__feedInfosLoading__');
  static final feedInfoItem = (String id) => new Key('FeedInfoItem__$id');
  static final feedInfoItemTitle =
      (String id) => new Key('FeedInfoItem__${id}__Title');
  static final feedInfoItemUnreadCount =
      (String id) => new Key('FeedInfoItem__${id}__Count');

  // Todos
  static final todoList = const Key('__todoList__');
  static final todosLoading = const Key('__todosLoading__');
  static final todoItem = (String id) => new Key('TodoItem__$id');
  static final todoItemCheckbox =
      (String id) => new Key('TodoItem__${id}__Checkbox');
  static final todoItemTask = (String id) => new Key('TodoItem__${id}__Task');
  static final todoItemNote = (String id) => new Key('TodoItem__${id}__Note');

  // Tabs
  static final tabs = const Key('__tabs__');
  static final todoTab = const Key('__todoTab__');
  static final statsTab = const Key('__statsTab__');

  // Extra Actions
  static final extraActionsButton = const Key('__extraActionsButton__');
  static final toggleAll = const Key('__markAllDone__');
  static final clearCompleted = const Key('__clearCompleted__');

  // Filters
  static final filterButton = const Key('__filterButton__');
  static final allFilter = const Key('__allFilter__');
  static final activeFilter = const Key('__activeFilter__');
  static final completedFilter = const Key('__completedFilter__');

  // Stats
  static final statsCounter = const Key('__statsCounter__');
  static final statsLoading = const Key('__statsLoading__');
  static final statsNumActive = const Key('__statsActiveItems__');
  static final statsNumCompleted = const Key('__statsCompletedItems__');

  // Details Screen
  static final editTodoFab = const Key('__editTodoFab__');
  static final deleteTodoButton = const Key('__deleteTodoFab__');
  static final todoDetailsScreen = const Key('__todoDetailsScreen__');
  static final detailsTodoItemCheckbox = new Key('DetailsTodo__Checkbox');
  static final detailsTodoItemTask = new Key('DetailsTodo__Task');
  static final detailsTodoItemNote = new Key('DetailsTodo__Note');

  // Add Screen
  static final addTodoScreen = const Key('__addTodoScreen__');
  static final saveNewTodo = const Key('__saveNewTodo__');

  // Edit Screen
  static final editTodoScreen = const Key('__editTodoScreen__');
  static final saveTodoFab = const Key('__saveTodoFab__');
}
