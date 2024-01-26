
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app_ui/data_source/remote/api_exception.dart';
import 'package:wallpaper_app_ui/data_source/remote/api_helper.dart';
import 'package:wallpaper_app_ui/data_source/remote/urls.dart';
import 'package:wallpaper_app_ui/models/wallpaper_model.dart';
import 'package:wallpaper_app_ui/screens/search/bloc/search_event.dart';
import 'package:wallpaper_app_ui/screens/search/bloc/search_state.dart';

class SearchWallpaperBloc extends Bloc<SearchWallpaperEvent,SearchWallpaperState>{

  ApiHelper apiHelper;
  SearchWallpaperBloc({required this.apiHelper}) : super(SearchWallpaperInitialState()){
    on<GetSearchWallpaper>((event, emit) async {
      emit(SearchWallpaperLoadingState());

      try{
        var rawData = await apiHelper.getAPI("${Urls.SEARCH_WALLPAPER_URL}?query=${event.query}&color=${event.colorCode}");
        ///loaded state
        var wallpaperDataModel = WallpaperDataModel.fromJson(rawData);
        emit(SearchWallpaperLoadedState(mData: wallpaperDataModel));
      } catch (e){
        ///error state
        emit(SearchWallpaperErrorState(errorMsg: (e as AppException).toErrorMsg()));
      }

    });
  }

}