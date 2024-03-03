import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'textfield_event.dart';

class TextfieldBloc extends Bloc<TextfieldEvent, String> {
  TextfieldBloc() : super('') {
    on<TextfieldIsEmptyEvent>(
      (event, emit) {
        emit(event.text);
      },
    );
  }
}
