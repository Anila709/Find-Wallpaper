import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app_ui/bloc/wallpaper_event.dart';
import 'package:wallpaper_app_ui/bloc/wallpaper_state.dart';
import 'package:wallpaper_app_ui/data_source/remote/api_exception.dart';
import 'package:wallpaper_app_ui/data_source/remote/api_helper.dart';
import 'package:wallpaper_app_ui/data_source/remote/urls.dart';
import 'package:wallpaper_app_ui/models/wallpaper_model.dart';

class TrendingWallpaperBloc extends Bloc<TrendingWallpaperEvent, TrendingWallpaperState> {
  ApiHelper apiHelper;
  TrendingWallpaperBloc({required this.apiHelper}) : super(TrendingWallpaperInitialState()) {
    on<GetTrendingWallpaper>((event, emit) async {
      emit(TrendingWallpaperLoadingState());

      try{
        var rawData = await apiHelper.getAPI(Urls.TRENDING_WALLPAPER_URL);
        ///loaded state
        var wallpaperDataModel = WallpaperDataModel.fromJson(rawData);
        emit(TrendingWallpaperLoadedState(mData: wallpaperDataModel));
      } catch (e){
        ///error state
        emit(TrendingWallpaperErrorState(errorMsg: (e as AppException).toErrorMsg()));
      }

    });
     
  }
}