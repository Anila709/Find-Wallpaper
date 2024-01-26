import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app_ui/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app_ui/data_source/remote/api_helper.dart';
import 'package:wallpaper_app_ui/screens/search/bloc/search_bloc.dart';

import 'screens/home_screen.dart';

void main()
{
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: ((context) => TrendingWallpaperBloc(apiHelper: ApiHelper())),
  ),
     BlocProvider(create: ((context) => SearchWallpaperBloc(apiHelper: ApiHelper())),
  )
  ], child: const MyApp())
   );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'wallpaper app ui',
      home: HomeScreen(),
    );
  }
}