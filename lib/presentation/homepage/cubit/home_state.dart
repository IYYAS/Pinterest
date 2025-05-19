part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class Homeloaded extends HomeState {}
class HomeLoading extends HomeState {}
