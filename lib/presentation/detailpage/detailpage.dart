import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintrestcubit/presentation/detailpage/cubit/detailpage_cubit.dart';
import 'package:pintrestcubit/presentation/homepage/cubit/home_cubit.dart';

import 'component/detailpagenavigatetopage.dart';

class Detailpage extends StatelessWidget {
  const Detailpage({super.key, required this.url, required this.id, required this.cubit});
  final HomeCubit cubit;

  final String url;
final int id;
  @override
  Widget build(BuildContext context) {

          return Scaffold(
            backgroundColor: Colors.black54,
            body:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipRRect(
                            borderRadius: BorderRadius.circular(20), // 👈 Rounded corners
                                             child: SizedBox(
                                               width: double.infinity,
                            child: Image.network(
                              url,
                              fit: BoxFit.cover,
                            ),
                                                   ),
                                                   ),
                      SizedBox(height: 05,),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Column(
                          children: [
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.favorite_border, color: Colors.white, size: 24),
                                      SizedBox(width: 4),
                                      Text('4', style: TextStyle(color: Colors.white)),
                        
                                      SizedBox(width: 16),
                                      Icon(Icons.chat_bubble_outline, color: Colors.white, size: 24),
                        
                                      SizedBox(width: 16),
                                      Icon(Icons.share_outlined, color: Colors.white, size: 24),
                        
                                      SizedBox(width: 16),
                                      Icon(Icons.more_horiz, color: Colors.white, size: 24),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.downloadImage(imageUrl: url, context: context, id: id);

                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent, // Red save button
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              

                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 7,
                                  backgroundImage: NetworkImage(url),
                                ),
                                SizedBox(width: 6), // spacing between avatar and text
                                 Text(
                                  "Text",
                                  style: TextStyle(
                                    color: Colors.white, // or any color you prefer
                                    fontSize: 12,        // adjust size to match design
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 7 ,),
                            Row(
                              children: [
                                Text(
                                  "Conceptual art - BMW M3",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600, // Semi-bold
                                    fontSize: 20,                // Adjust size to match the image
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1,),
                            Row(
                              children: [
                                Text(
                                  "Conceptual art - BMW M3",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600, // Semi-bold
                                    fontSize: 16,                // Adjust size to match the image
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),

                            Container(
                              width: double.infinity, // Matches the button width in the image
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Color(0xFF7E7E76), // Gray color from the image
                                borderRadius: BorderRadius.circular(15), // Smooth round edges
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Visit site',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                'More to explore',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                            cubit.imagesData.isNotEmpty
                                ? Column(
                              children: [

                                SizedBox(
                                  height: 600, // Adjust based on your UI needs or use MediaQuery

                                  child: MasonryGridView.count(

                                    // controller: cubit.scrollController,
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
                                                builder: (context) => Detailpages(
                                                  id: cubit.imagesData[index]["id"],
                                                  url: cubit.imagesData[index]["portrait"], cubit: cubit,
                                                ),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.network(
                                              cubit.imagesData[index]["portrait"],
                                              fit: BoxFit.cover,
                                              height: height > 300 ? 300 : height,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                ),


                              ],
                            )
                                : ListView(
                              children: const [
                                SizedBox(height: 300),
                                Center(child: Text("No data")),
                              ],
                            ),                          ],
                        ),
                        
                      ),

                    ],
                  ),
                ),
              ),
          );


  }
}
