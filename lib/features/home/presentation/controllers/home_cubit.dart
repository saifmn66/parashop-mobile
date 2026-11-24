import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_home_feed_usecase.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.feed,
    this.deliveryLocation = 'Paris 8e • Express 2h',
  });

  final HomeFeedData feed;
  final String deliveryLocation;

  HomeState copyWith({
    HomeFeedData? feed,
    String? deliveryLocation,
  }) {
    return HomeState(
      feed: feed ?? this.feed,
      deliveryLocation: deliveryLocation ?? this.deliveryLocation,
    );
  }

  @override
  List<Object?> get props => [feed, deliveryLocation];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.getHomeFeed) : super(HomeState(feed: getHomeFeed()));

  final GetHomeFeedUseCase getHomeFeed;

  void refresh() {
    emit(state.copyWith(feed: getHomeFeed()));
  }
}
