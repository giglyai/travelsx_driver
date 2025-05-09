part of 'document_cubit.dart';

@immutable
abstract class DocumentState {}

class DocumentInitial extends DocumentState {}

class DocumentLoading extends DocumentState {}

class DocumentSuccess extends DocumentState {
  final String message;

  DocumentSuccess({required this.message});
}

class DocumentFailure extends DocumentState {
  final String message;

  DocumentFailure({required this.message});
}

class DocumentStatusLoading extends DocumentState {}

class DocumentStatusSuccess extends DocumentState {
  final DocumentStatus documentStatus;

  DocumentStatusSuccess({required this.documentStatus});
}

class DocumentStatusFailure extends DocumentState {
  final String message;

  DocumentStatusFailure({required this.message});
}
