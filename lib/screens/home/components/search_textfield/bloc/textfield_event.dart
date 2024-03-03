part of 'textfield_bloc.dart';

sealed class TextfieldEvent extends Equatable {
  const TextfieldEvent();

  @override
  List<Object> get props => [];
}

class TextfieldIsEmptyEvent extends TextfieldEvent {
  final String text;

  const TextfieldIsEmptyEvent(this.text);

  @override
  List<Object> get props => [text];
}
