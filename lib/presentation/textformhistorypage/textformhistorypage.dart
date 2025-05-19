import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintrestcubit/presentation/homepage/cubit/home_cubit.dart';

import '../MAINPAGE.dart';
import '../homepage/homepage.dart';

class Textformhistorypage extends StatelessWidget {
  const Textformhistorypage({super.key, });



  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();

    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFF202124),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            "https://images.sftcdn.net/images/t_app-icon-m/p/a9c71c20-9160-11e6-85fe-00163ec9f5fa/2009682588/pinterest-logo.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          controller: homeCubit.textEditingController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                          onFieldSubmitted: (value) {

                            // homeCubit.getaction();
                            homeCubit.serchname = homeCubit.textEditingController.text.trim();
                            homeCubit.getserch(
                                query: homeCubit.textEditingController.text.trim());
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white24,
                ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: homeCubit.actionlist.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: InkWell(
                            onTap: () {
                              homeCubit.textEditingController.text =
                              homeCubit.actionlist[index];
                            },
                            child: ListTile(
                              leading: Icon(
                                CupertinoIcons.time,
                                color: Colors.white54,
                              ),
                              title: Text(
                                homeCubit.actionlist[index],
                                maxLines: 10,
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

              ],
            ),
          )

          //   Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Column(
          //     children: [
          //       TextField(
          //         controller: cubit.textEditingController,
          //         decoration: InputDecoration(
          //           labelText: 'Enter text',
          //           border: OutlineInputBorder(),
          //           suffixIcon: IconButton(
          //             icon: Icon(Icons.search),
          //             onPressed: () {
          //               cubit.getserch(query: cubit.textEditingController.text);
          //               FocusScope.of(context).unfocus();
          //               Navigator.pop(context);
          //
          //             },
          //           ),
          //         ),
          //         onSubmitted: (value) {
          //
          //           cubit.getserch(query: cubit.textEditingController.text);
          //           FocusScope.of(context).unfocus();
          //           Navigator.pop(context);
          //
          //         },
          //       ),
          //
          //       const SizedBox(height: 16),
          //       Expanded(
          //         child: ListView.builder(
          //           itemCount: cubit.actionlist.length,
          //           itemBuilder: (context, index) {
          //             return Container(
          //               margin: const EdgeInsets.symmetric(vertical: 4),
          //               padding: const EdgeInsets.all(12),
          //               decoration: BoxDecoration(
          //                 color: Colors.black,
          //                 borderRadius: BorderRadius.circular(15),
          //                 border: Border.all(color: Colors.white),
          //               ),
          //               child: Text(
          //                 cubit.actionlist[index],
          //                 style: const TextStyle(color: Colors.white),
          //               ),
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // );

          ),
    );
  }
}
