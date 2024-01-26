import 'package:wallpaper_app_ui/models/wallpaper_model.dart';

abstract class SearchWallpaperState {}

class SearchWallpaperInitialState extends SearchWallpaperState {}
class SearchWallpaperLoadingState extends SearchWallpaperState {}
class SearchWallpaperLoadedState extends SearchWallpaperState {
  WallpaperDataModel mData;
  SearchWallpaperLoadedState({required this.mData});
}
class SearchWallpaperErrorState extends SearchWallpaperState {
  String errorMsg;
  SearchWallpaperErrorState({required this.errorMsg});
}