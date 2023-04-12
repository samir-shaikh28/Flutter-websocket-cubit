abstract class StockState {
  StockState();
}

class LoadingState extends StockState {}

class PriceChangeState extends StockState {
  final bool isPriceYp;
  final double price;

  PriceChangeState(this.isPriceYp, this.price);
}
