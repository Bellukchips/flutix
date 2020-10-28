import 'package:flutter/material.dart' show Locale, immutable;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  // Passing an initial value (state) with a default 'Locale' to the super class.
  LocaleCubit() : super(SelectedLocale(Locale('en')));
  //emmited state holds the 'id' locale
  void toIndonesia() => emit(SelectedLocale(Locale('id')));
  // same as the previous method, but with the 'en' locale
  void toEnglish() => emit(SelectedLocale(Locale('en')));
}
