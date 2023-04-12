import 'dart:convert';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:web_socket_example/cubit/stock_state.dart';
import 'package:web_socket_example/repository/stock_repo.dart';

class StockCubit extends Cubit<StockState> {
  final StockRepository repository;

  StockCubit(this.repository) : super(LoadingState());

  void subscribeToStockPriceChanges() {
    emit(LoadingState());
    double initialVal = 0.0;
    repository.subscribeToStream()?.stream.listen((event) {
      Map data = jsonDecode(event);
      double price = double.parse(data['p']);
      if (initialVal != 0.0) {
        emit(PriceChangeState(price > initialVal, price));
      } else {
        initialVal = price;
        emit(PriceChangeState(true, price));
      }
    });
  }

  void disposeChannel() {
    repository.disposeWebSocketChannel();
    emit(PriceChangeState(true, 0.0));
  }
}
