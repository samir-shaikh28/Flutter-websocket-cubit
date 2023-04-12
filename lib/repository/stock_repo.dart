import 'package:web_socket_channel/web_socket_channel.dart';

class StockRepository {
  WebSocketChannel? channel;

  WebSocketChannel? subscribeToStream() {
    channel ??= WebSocketChannel.connect(
        Uri.parse("wss://stream.binance.com:9443/ws/btcusdt@trade"));
    return channel;
  }

  void disposeWebSocketChannel() {
    if (channel != null) {
      channel?.sink.close();
    }
  }
}
