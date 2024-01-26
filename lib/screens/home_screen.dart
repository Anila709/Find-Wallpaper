import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wallpaper_app_ui/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app_ui/bloc/wallpaper_event.dart';
import 'package:wallpaper_app_ui/bloc/wallpaper_state.dart';
import 'package:wallpaper_app_ui/models/category_model.dart';
import 'package:wallpaper_app_ui/models/color_model.dart';
import 'package:wallpaper_app_ui/screens/searched_wallpaper_screen.dart';
import 'package:wallpaper_app_ui/screens/wallpaper_details.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CatergoryModel> listdata = [
    CatergoryModel(
        name: "Nature", image: Image.asset("assets/images/img1.jpg")),
    CatergoryModel(
        name: "Abstract", image: Image.asset("assets/images/img2.jpg")),
    CatergoryModel(name: "Water", image: Image.asset("assets/images/img3.jpg")),
    CatergoryModel(name: "Ocean", image: Image.asset("assets/images/img4.jpg")),
    CatergoryModel(
        name: "Forest", image: Image.asset("assets/images/img5.jpg")),
    CatergoryModel(
        name: "Heaven", image: Image.asset("assets/images/img6.jpg")),
    CatergoryModel(
        name: "Coconut Tree", image: Image.asset("assets/images/img7.jpg")),
    CatergoryModel(
        name: "Flower", image: Image.asset("assets/images/img8.jpg")),
  ];
  // final List<Map<String, dynamic>> listdata = [
  //   {
  //     "name": "Nature",
  //     "image": AssetImage("assets/images/img1.jpg"),
  //   },
  //   {
  //     "name": "Abstract",
  //     "image": AssetImage("assets/images/img2.jpg"),
  //   },
  //   {
  //     "name": "Water",
  //     "image": AssetImage("assets/images/img3.jpg"),
  //   },
  //   {
  //     "name": "Ocean",
  //     "image": AssetImage("assets/images/img4.jpg"),
  //   },
  //   {
  //     "name": "Forest",
  //     "image": AssetImage("assets/images/img5.jpg"),
  //   },
  //   {
  //     "name": "Heaven",
  //     "image": AssetImage("assets/images/img6.jpg"),
  //   },
  //   {
  //     "name": "Coconut Tree",
  //     "image": AssetImage("assets/images/img7.jpg"),
  //   },
  //   {
  //     "name": "Flower",
  //     "image": AssetImage("assets/images/img8.jpg"),
  //   }
  // ];
  var mController = TextEditingController();

  List<ColorModel> mColorList = [
    ColorModel(colorValue: Colors.white, colorCode: "ffffff"),
    ColorModel(colorValue: Colors.black, colorCode: "000000"),
    ColorModel(colorValue: Colors.blue, colorCode: "0000ff"),
    ColorModel(colorValue: Colors.green, colorCode: "00ff00"),
    ColorModel(colorValue: Colors.red, colorCode: "ff0000"),
    ColorModel(colorValue: Colors.purple, colorCode: "9C27B0"),
    ColorModel(colorValue: Colors.orange, colorCode: "FF9800"),
    ColorModel(colorValue: Colors.cyan, colorCode: "00BCD4"),
  ];

  //Future<WallpaperDataModel?>? mData;
  //Future<WallpaperDataModel?>? mTrendingData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TrendingWallpaperBloc>(context).add(GetTrendingWallpaper());
    //mTrendingData = getTrendingWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
                    child: searchUI(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      "Best of the month",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Poppins'),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: SizedBox(
                      height: 200,
                      child: BlocBuilder<TrendingWallpaperBloc,
                          TrendingWallpaperState>(builder: (context, state) {
                        if (state is TrendingWallpaperLoadingState) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is TrendingWallpaperErrorState) {
                          return Center(
                            child: Text('Error :${state.errorMsg}'),
                          );
                        } else if (state is TrendingWallpaperLoadedState) {
                          var data = state.mData;
                          return SizedBox(
                            height: 200,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.photos!.length,
                                itemBuilder: (_, index) {
                                  var eachPhoto =
                                      data.photos![index].src!.portrait!;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        navigateToDetailpage(eachPhoto);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(11),
                                        child: Image.network(
                                          eachPhoto,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        }
                        return Container();
                        // return SizedBox(
                        //     height: 200,
                        //     child: FutureBuilder<WallpaperDataModel?>(
                        //         future: mTrendingData,
                        //         builder: (_, snapshot) {
                        //           if (snapshot.connectionState ==
                        //               ConnectionState.waiting) {
                        //             return Center(
                        //               child: CircularProgressIndicator(),
                        //             );
                        //           } else if (snapshot.hasError) {
                        //             return Center(
                        //               child: Text("${snapshot.error.toString()}"),
                        //             );
                        //           } else if (snapshot.hasData) {
                        //             var data = snapshot.data!;
                        //             return snapshot.data != null &&
                        //                     snapshot.data!.photos!.isNotEmpty
                        //                 ? ListView.builder(
                        //                     scrollDirection: Axis.horizontal,
                        //                     itemCount: data.photos!.length,
                        //                     itemBuilder: (_, index) {
                        //                       var eachPhoto = data
                        //                           .photos![index].src!.portrait!;
                        //                       return Padding(
                        //                         padding: const EdgeInsets.all(8.0),
                        //                         child: InkWell(
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
                        //                         ),
                        //                       );
                        //                     })
                        //                 : Container(
                        //                     child: Center(
                        //                       child: Text('No Wallpaper!!'),
                        //                     ),
                        //                   );
                        //           }
                        //           return Container();
                        //         }));
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      "The color tone",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'Poppins'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 72,
                      child: ListView.builder( 
                          scrollDirection: Axis.horizontal,
                          itemCount: mColorList.length,
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: () {
                                if (mController.text.isNotEmpty)
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchedWallpaperScreen(
                                                searchQuery: mController.text
                                                    .toLowerCase(),
                                                colorCode: mColorList[index]
                                                    .colorCode!,
                                              )));
                                setState(() {});
                                // mData = getWallpaper(
                                //     query: mController.text.toString(),
                                //     colorCode: mColorList[index].colorCode!);
                                // setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.all(11),
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                    color: mColorList[index].colorValue),
                              ),
                            );
                          }),
                    ),
                  ),
                  
                  Text(
                    "Categories",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'Poppins'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 600,
                      width: double.infinity,
                      child: GridView.builder(
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          childAspectRatio:
                              2, // Aspect ratio (width / height) of each grid item
                          mainAxisSpacing:
                              8, // Vertical spacing between grid items
                          crossAxisSpacing:
                              8, // Horizontal spacing between grid items
                          // Set the height of each grid item

                          mainAxisExtent: 90,
                        ),
                        itemCount: listdata.length, // Number of items
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchedWallpaperScreen(
                                              searchQuery:
                                                  listdata[index].name!)));
                            },
                            child: Container(
                                //margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: listdata[index].image!.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Center(
                                        child: Text(
                                      listdata[index].name!,
                                      style: TextStyle(
                                          //fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                          fontSize: 20,
                                          //fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w200,
                                          letterSpacing: 3),
                                    )))),
                          );
                        },
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  void navigateToDetailpage(String url) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WallpaperDetailsPage(wallUrl: url)));
  }

  //search text field ui..
  Widget searchUI() {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 219, 217, 217),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextField(
              controller: mController,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                hintText: 'Find Wallpaper',
                hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins'),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.white,
            onPressed: () {
              if (mController.text.isNotEmpty) {
                var searchQuery = mController.text.toString();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchedWallpaperScreen(
                              searchQuery: searchQuery,
                            )));
                setState(() {});
              }
            },
            icon: Icon(Ionicons.search,color: Colors.grey,)
          ),
        ],
      ),
    );
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

  // Future<WallpaperDataModel?> getTrendingWallpaper() async {
  //   var myApiKey = "lLGZiqQUy25YBe9qTDs7DSbHpO7X72BPg6FkAd9IG0VxSRWbhXg5EirB";
  //   var uri = Uri.parse("https://api.pexels.com/v1/curated");
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
}
