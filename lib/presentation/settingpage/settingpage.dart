import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintrestcubit/presentation/homepage/cubit/home_cubit.dart';

class Settingpage extends StatelessWidget {
  const Settingpage({super.key, required this.cubit});
final HomeCubit cubit;
  @override
  Widget build(BuildContext context) {
    return
         SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Switch(
                  value: cubit.settingdarklight,
                  onChanged: (bool newValue) {
                    cubit.toggleTheme(newValue);
                  },
                ),
              ],
            ),
          ),
        );

  }
}
