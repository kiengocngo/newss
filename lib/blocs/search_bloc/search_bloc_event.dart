part of 'search_bloc_bloc.dart';

abstract class SearchBlocEvent extends Equatable {
  const SearchBlocEvent();

  @override
  List<Object> get props => [];
}

abstract class SearchBlocSubmit extends SearchBlocEvent {
  String name;
  SearchBlocSubmit({
    required this.name,
  });
   @override
  List<Object> get props => [name];


}
