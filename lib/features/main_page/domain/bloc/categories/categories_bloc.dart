import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_event.dart';
part 'categories_state.dart';
part 'categories_bloc.freezed.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(const _Loading()) {
    on<CategoriesEvent>(
      (event, emit) async {
        await event.when(
          fetch: () async {
            String jsonString = await rootBundle.loadString('assets/strings/categories.json');

            final data = json.decode(jsonString);
            List<String> categories = List<String>.from(data['categories']);

            emit(_Loaded(categories: categories));
          },
        );
      },
    );
  }
}
