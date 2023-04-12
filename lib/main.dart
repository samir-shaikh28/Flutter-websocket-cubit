import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_example/cubit/stock_cubit.dart';
import 'package:web_socket_example/repository/stock_repo.dart';
import 'package:web_socket_example/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StockCubit(StockRepository()),
      child: const MaterialApp(home: HomePage()),
    );
  }
}
