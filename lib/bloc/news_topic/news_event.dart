import 'package:equatable/equatable.dart';

abstract class NewsTopicEvent extends Equatable {
  const NewsTopicEvent();
  @override
  List<Object> get props => [];
}

class GetNewsSport extends NewsTopicEvent {
  final String sports;
  const GetNewsSport({required this.sports});

  @override
  List<Object> get props => [sports];
}

class GetNewsTop extends NewsTopicEvent {
  final String top;
  const GetNewsTop({required this.top});

  @override
  List<Object> get props => [top];
}

class GetNewsWorld extends NewsTopicEvent {
  final String world;
  const GetNewsWorld({required this.world});

  @override
  List<Object> get props => [world];
}

class GetNewsEnvironment extends NewsTopicEvent {
  final String environment;
  const GetNewsEnvironment({required this.environment});
  @override
  List<Object> get props => [environment];
}

class GetNewsEntertainment extends NewsTopicEvent {
  final String entertainment;
  const GetNewsEntertainment({required this.entertainment});
  @override
  List<Object> get props => [entertainment];
}

class GetNewsBusiness extends NewsTopicEvent {
  final String business;
  const GetNewsBusiness({required this.business});
  @override
  List<Object> get props => [business];
}

class GetNewsFood extends NewsTopicEvent {
  final String food;
  const GetNewsFood({required this.food});
  @override
  List<Object> get props => [food];
}

class GetNewsHealth extends NewsTopicEvent {
  final String health;
  const GetNewsHealth({required this.health});
  @override
  List<Object> get props => [health];
}

class GetNewsPolitics extends NewsTopicEvent {
  final String politics;
  const GetNewsPolitics({required this.politics});
  @override
  List<Object> get props => [politics];
}

class GetNewsScience extends NewsTopicEvent {
  final String science;
  const GetNewsScience({required this.science});
  @override
  List<Object> get props => [science];
}

class GetNewsTechnology extends NewsTopicEvent {
  final String technology;
  const GetNewsTechnology({required this.technology});
  @override
  List<Object> get props => [technology];
}
