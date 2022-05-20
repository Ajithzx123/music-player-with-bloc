part of 'favourite_bloc.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();
}

class FavDelete extends FavouriteState{
 final List<dynamic>? list;
  FavDelete({required this.list});
    @override
  List<Object?> get props => [list];
}
// class FavAdd  extends FavouriteState{
//   final List<dynamic>? list;

//   FavAdd({required this.list});
//   @override
//   List<Object?> get props => [list];
  
// }




class FavDeleteSecond extends FavouriteState{  
    @override
  List<Object?> get props => [];

}
