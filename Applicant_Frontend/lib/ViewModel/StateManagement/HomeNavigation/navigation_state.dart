part of 'navigation_cubit.dart';

@immutable
abstract class NavigationState {}

class NavigationInitial extends NavigationState {}

class NavigationChangePage extends NavigationState {}

class BackgroundChanged extends NavigationState {}

class TriggerBackground extends NavigationState {}
