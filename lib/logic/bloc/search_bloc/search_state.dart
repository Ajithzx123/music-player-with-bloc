part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable{}

class SearchResult extends SearchState {
  final List<Audio> audios;
  SearchResult({required this.audios});

  @override
  List<Audio> get props => audios;
}
