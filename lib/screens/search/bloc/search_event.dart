abstract class SearchWallpaperEvent{}

class GetSearchWallpaper extends SearchWallpaperEvent{
  String query;
  String? colorCode;
  GetSearchWallpaper({required this.query,this.colorCode});
}