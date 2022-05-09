part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable{

}

class EnterInputEvent extends SearchEvent{
  final String searchInput;
  EnterInputEvent({required this.searchInput});

  @override
  List<Object?> get props => [searchInput];
  
}

// class ClearInputEvent extends SearchEvent{
//   @override
//   List<Object?> get props => [];

// }