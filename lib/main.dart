import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pintrestcubit/presentation/MAINPAGE.dart';
import 'package:pintrestcubit/presentation/homepage/cubit/home_cubit.dart';

void main() async{
  await dotenv.load(fileName: ".env");

  runApp(BlocProvider(
      create:(context) => HomeCubit(),

      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData.light(),
            home: Navicater()
        );
      },
    );
  }
}

