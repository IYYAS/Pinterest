import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pintrestcubit/presentation/detailpage/detailpage.dart';
import 'package:pintrestcubit/presentation/homepage/cubit/home_cubit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../textformhistorypage/textformhistorypage.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

          // Attach scroll listener once
          if (!cubit.isPaginationListenerAttached) {
            cubit.scrollController.addListener(() {
              if (cubit.scrollController.position.pixels >=
                  cubit.scrollController.position.maxScrollExtent - 300) {
                cubit.counter++;
                cubit.getpage(
                  page: cubit.counter,
                  query: cubit.textEditingController.text.trim(),
                );
              }
            });
            cubit.isPaginationListenerAttached = true;
          }

          return SafeArea(
            child: Scaffold(

              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: cubit,
                              child: Textformhistorypage(),
                            ),
                          ),
                        );

                      },
                      child: Container(
                        width: 400,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff000000)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                cubit.serchname != null
                                    ? cubit.serchname!
                                    : "SEARCH",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xff000000))),
                            SizedBox(),
                            SizedBox(),
                            SizedBox(),
                            Icon(Icons.search_rounded),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    /// Refreshable, scrollable grid
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          cubit.counter++;
                          await cubit.getpage(
                            page: cubit.counter,
                            query: cubit.textEditingController.text,
                          );
                        },
                        child: cubit.imagesData.isNotEmpty
                            ? Column(
                                children: [
                                  Expanded(
                                    child: MasonryGridView.count(
                                      controller: cubit.scrollController,
                                      padding: const EdgeInsets.all(12),
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      itemCount: cubit.imagesData.length,
                                      itemBuilder: (context, index) {

                                        double height = (index % 10 + 1) * 100;

                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Detailpage(
                                                  id: cubit.imagesData[index]
                                                      ["id"],
                                                  url: cubit.imagesData[index]
                                                      ["portrait"],
                                                  cubit: cubit,
                                                ),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              cubit.imagesData[index]
                                                  ["portrait"],
                                              fit: BoxFit.cover,
                                              height:
                                                  height > 300 ? 300 : height,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () async {
                                            cubit.counter++;
                                            await cubit.getpage(
                                              page: cubit.counter,
                                              query: cubit
                                                  .textEditingController.text
                                                  .trim(),
                                            );
                                          },
                                          child: SpinKitFadingCircle(
                                            color: Colors.grey,
                                            size: 50.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              )

                            : MasonryGridView.count(
                                padding: const EdgeInsets.all(12),
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                itemCount: 10,
                                // show 10 shimmer placeholders
                                itemBuilder: (context, index) {
                                  double height = (index % 10 + 1) * 100;
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: height > 300 ? 300 : height,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  );
                                },
                              ),


                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
