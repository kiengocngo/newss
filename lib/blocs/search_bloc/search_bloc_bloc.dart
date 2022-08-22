import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_bloc_event.dart';
part 'search_bloc_state.dart';

class SearchBlocBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  SearchBlocBloc() : super(SearchBlocInitial()) {
    on<SearchBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
