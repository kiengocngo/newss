import 'package:equatable/equatable.dart';

class NewsTopicsEvent extends Equatable {
  const NewsTopicsEvent();
  @override
  List<Object> get props => [];
}

class NewsForYou extends NewsTopicsEvent {
  final String listCategories;
  const NewsForYou({required this.listCategories});
  @override
  List<Object> get props => [listCategories];
}
