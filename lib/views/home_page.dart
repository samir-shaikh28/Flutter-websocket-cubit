import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_example/cubit/stock_cubit.dart';
import 'package:web_socket_example/cubit/stock_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<StockCubit>().subscribeToStockPriceChanges();
    });
    super.initState();
  }

  @override
  void dispose() {
    print("##### dispose called");
    context.read<StockCubit>().disposeChannel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: BlocBuilder<StockCubit, StockState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          } else if (state is PriceChangeState) {
            final Color color;
            if (state.isPriceYp) {
              color = Colors.green;
            } else {
              color = Colors.red;
            }
            return Column(
              children: [
                Text(
                  state.price.toString(),
                  style: TextStyle(color: color),
                ),
                TextButton(
                    onPressed: () {
                      context.read<StockCubit>().disposeChannel();
                    },
                    child: Text("close stream"))
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
