import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  ConversationsBloc() : super(ConversationsInitial()) {
    on<ConversationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
