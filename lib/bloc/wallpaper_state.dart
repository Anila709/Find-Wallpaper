import 'package:wallpaper_app_ui/models/wallpaper_model.dart';

abstract class TrendingWallpaperState {}

class TrendingWallpaperInitialState extends TrendingWallpaperState {}
class TrendingWallpaperLoadingState extends TrendingWallpaperState {}
class TrendingWallpaperLoadedState extends TrendingWallpaperState {
  WallpaperDataModel mData;
  TrendingWallpaperLoadedState({required this.mData});
}
class TrendingWallpaperErrorState extends TrendingWallpaperState {
  String errorMsg;
  TrendingWallpaperErrorState({required this.errorMsg});
}