import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintrestcubit/presentation/serchdemo/serch.dart';
import 'package:pintrestcubit/presentation/settingpage/settingpage.dart';

import 'deomo3/demo3.dart';
import 'deomo4/demo4.dart';
import 'homepage/cubit/home_cubit.dart';
import 'homepage/homepage.dart';

class Navicater extends StatelessWidget {
  const Navicater({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();
            return WillPopScope(
              onWillPop:() =>  cubit.onWillPop(context),
              child: Stack(
                children: [
                  cubit.naviterbottom == 1
                      ? HomePage()
                      : cubit.naviterbottom == 5
                          ? Settingpage(
                              cubit: cubit,
                            )
                          : cubit.naviterbottom == 2
                           ?Serch()
                             : cubit.naviterbottom == 3
                             ? Serchs()
                             : cubit.naviterbottom == 4
                           ?Serchsss()
                             :SizedBox(),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                      ),
                      child: Container(
                        color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: () {
                                  cubit.set(1);
                                },
                                child:
                                    _buildNavItem(Icons.home_outlined, "Home")),
                            InkWell(
                                onTap: () {
                                  cubit.set(2);
                                },
                                child:
                                    _buildNavItem(Icons.search_sharp, "Search")),
                            InkWell(
                                onTap: () {
                                  cubit.set(3);
                                },
                                child: _buildNavItem(Icons.add, "Create")),
                            InkWell(
                                onTap: () {
                                  cubit.set(4);
                                },
                                child: _buildNavItem(
                                    Icons.message_outlined, "Inbox")),
                            InkWell(
                                onTap: () {
                                  cubit.set(5);
                                },
                                child: _buildNavItem(Icons.person, "Setting")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
