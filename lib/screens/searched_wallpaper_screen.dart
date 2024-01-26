import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallpaper_app_ui/models/wallpaper_model.dart';
import 'package:wallpaper_app_ui/screens/search/bloc/search_bloc.dart';
import 'package:wallpaper_app_ui/screens/search/bloc/search_event.dart';
import 'package:wallpaper_app_ui/screens/search/bloc/search_state.dart';
import 'package:wallpaper_app_ui/screens/wallpaper_details.dart';

class SearchedWallpaperScreen extends StatefulWidget {
  SearchedWallpaperScreen({super.key, required this.searchQuery, this.colorCode=""});

  String? searchQuery;
  String colorCode;

  @override
  State<SearchedWallpaperScreen> createState() =>
      _SearchedWallpaperScreenState();
}

class _SearchedWallpaperScreenState extends State<SearchedWallpaperScreen> {
  Future<WallpaperDataModel?>? mData;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SearchWallpaperBloc>(context).add(GetSearchWallpaper(query: widget.searchQuery!,colorCode: widget.colorCode));
    //mData = getWallpaper(query: widget.searchQuery,colorCode: widget.colorCode);
  }

  // Future<WallpaperDataModel?> getWallpaper(
  //     {String? query, String? colorCode = ""}) async {
  //   var myApiKey = "lLGZiqQUy25YBe9qTDs7DSbHpO7X72BPg6FkAd9IG0VxSRWbhXg5EirB";
  //   var uri = Uri.parse(
  //       "https://api.pexels.com/v1/search?query=$query&color=$colorCode");
  //   var response = await http.get(uri, headers: {
  //     "Authorization": myApiKey,
  //   });
  //   if (response.statusCode == 200) {
  //     var rawData = jsonDecode(response.body);
  //     var data = WallpaperDataModel.fromJson(rawData);

  //     return data;
  //   } else {
  //     return null;
  //   }
  // }

  void navigateToDetailpage(String url){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>WallpaperDetailsPage(wallUrl: url)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.color,
            gradient: LinearGradient(
                colors: List.of([
                  Colors.grey,
                  Colors.greenAccent,
                  Colors.lime,
                  Colors.greenAccent,
                  Colors.cyan,
                  Colors.blueAccent,
                  Colors.teal
                ]),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:32.0, left: 16,right: 16),
            child: BlocBuilder<SearchWallpaperBloc,
                          SearchWallpaperState>(
                          builder: (context, state) {
                        if (state is SearchWallpaperLoadingState) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is SearchWallpaperErrorState) {
                          return Center(
                            child: Text('Error :${state.errorMsg}'),
                          );
                        } else if (state is SearchWallpaperLoadedState) {
                          var data = state.mData;
                          return 
                        data.photos!.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.searchQuery}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 20),
                              ),
                              // Check if wallpaperData is not null before accessing properties
                              data.per_page!=null
                                  ? Text(
                                      '${data.per_page} wallpapers available',
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontFamily: 'Poppins',
                                          fontSize: 16))
                                  : Text(''),
                              SizedBox(
                                height: 8,
                              ),
            
                              Expanded(
                                child: GridView.builder(
                                  itemCount: data.photos!.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8,
                                          childAspectRatio: 9 / 16),
                                  itemBuilder: (_, index) {
                                    var eachPhoto = 
                                        data.photos![index].src!.portrait!;
                                    return InkWell(
                                      onTap: () {
                                        navigateToDetailpage(eachPhoto);
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(11),
                                        child: Image.network(
                                          eachPhoto,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        : Container(
                            child: Center(
                              child: Text('No Wallpaper!!', style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontFamily: 'Poppins',
                                          fontSize: 16)),
                            ),
                          );
                        }
                        return Container();
                          }
            //child: FutureBuilder<WallpaperDataModel?>(
            //     future: mData,
            //     builder: (_, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       } else if (snapshot.hasError) {
            //         return Center(
            //           child: Text("${snapshot.error}"),
            //         );
            //       } else if (snapshot.hasData) {
            //         var wallpaperData = snapshot.data;
            //         return snapshot.data != null &&
            //                 snapshot.data!.photos!.isNotEmpty
            //             ? Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     '${widget.searchQuery}',
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         color: Colors.black,
            //                         fontSize: 20),
            //                   ),
            //                   SizedBox(
            //                     height: 8,
            //                   ),
            //                   //if (wallpaperData != null) // Check if wallpaperData is not null before accessing properties
            //                   wallpaperData != null
            //                       ? Text(
            //                           '${wallpaperData.per_page} wallpapers available',
            //                           style: TextStyle(
            //                               color: Colors.grey.shade700,
            //                               fontSize: 16))
            //                       : Text(''),
            //                   SizedBox(
            //                     height: 8,
            //                   ),
            
            //                   Expanded(
            //                     child: GridView.builder(
            //                       itemCount: snapshot.data!.photos!.length,
            //                       gridDelegate:
            //                           SliverGridDelegateWithFixedCrossAxisCount(
            //                               crossAxisCount: 2,
            //                               mainAxisSpacing: 8,
            //                               crossAxisSpacing: 8,
            //                               childAspectRatio: 9 / 16),
            //                       itemBuilder: (_, index) {
            //                         var eachPhoto = snapshot
            //                             .data!.photos![index].src!.portrait!;
            //                         return InkWell(
            //                           onTap: () {
            //                             navigateToDetailpage(eachPhoto);
            //                           },
            //                           child: ClipRRect(
            //                             borderRadius:
            //                                 BorderRadius.circular(11),
            //                             child: Image.network(
            //                               eachPhoto,
            //                               fit: BoxFit.fill,
            //                             ),
            //                           ),
            //                         );
            //                       },
            //                     ),
            //                   ),
            //                 ],
            //               )
            //             : Container(
            //                 child: Center(
            //                   child: Text('No Wallpaper!!'),
            //                 ),
            //               );
            //       }
            //       return Container();
            //     }),
          ),
        ),
      ),
    ),);
  }
}
