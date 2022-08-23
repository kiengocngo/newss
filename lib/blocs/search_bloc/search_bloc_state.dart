part of 'search_bloc_bloc.dart';

abstract class SearchBlocState extends Equatable {
  const SearchBlocState();

  @override
  List<Object> get props => [];
}

class SearchBlocInitial extends SearchBlocState {}
