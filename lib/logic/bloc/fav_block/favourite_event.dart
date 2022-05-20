part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();


}

class FavouriteDeleteEvent extends FavouriteEvent{
  final int index;
  FavouriteDeleteEvent({required this.index});
  @override
  List<Object> get props => [index];
}

// class FAvouriteAddEvent extends FavouriteEvent{
//   final Audio blocaudio;
//   const FAvouriteAddEvent({ required this.blocaudio});
//   @override
//   List<Object?> get props => [blocaudio];
// }