import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/network/internet_connection_status.dart';
import 'package:posts_app/features/posts/data/locale_datasource/posts_locale_datasource.dart';
import 'package:posts_app/features/posts/data/remote_datasource/posts_remote_data_source.dart';
import 'package:posts_app/features/posts/data/repository/posts_repository_impl.dart';
import 'package:posts_app/features/posts/domain/repository/posts_repository.dart';
import 'package:posts_app/features/posts/domain/usecase/add_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usecase/delete_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usecase/get_all_posts_usecase.dart';
import 'package:posts_app/features/posts/domain/usecase/update_posts_usecase.dart';
import 'package:posts_app/features/posts/presentation/bloc/post_options_bloc/post_options_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    /// Posts Feature
// Bloc

    sl.registerFactory(() => PostsBloc(getAllPostsUseCase: sl()));
    sl.registerFactory(
      () => PostOptionsBloc(
        addPostUseCase: sl(),
        updatePostsUseCase: sl(),
        deletePostUseCase: sl(),
      ),
    );

// UseCases

    sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
    sl.registerLazySingleton(() => AddPostUseCase(sl()));
    sl.registerLazySingleton(() => UpdatePostsUseCase(sl()));
    sl.registerLazySingleton(() => DeletePostUseCase(sl()));

// Repository
    sl.registerLazySingleton<PostsRepository>(
      () => PostsRepositoryImpl(
        basePostsLocleDataSource: sl(),
        basePostsRemoteDataSource: sl(),
        baseInternetConnectionStatus: sl(),
      ),
    );
// DataSources

    sl.registerLazySingleton<BasePostsRemoteDataSource>(
        () => PostsRemoteDataSource(clinet: sl()));
    sl.registerLazySingleton<BasePostsLocleDataSource>(
        () => PostsLocleDataSource(sharedPreferences: sl()));

    /// Core
    sl.registerLazySingleton<BaseInternetConnectionStatus>(
      () => InternetConnectionStat(
        connectionChecker: sl(),
      ),
    );

    /// External Packages
    final sharedPreferences = await SharedPreferences.getInstance();

    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => http.Client());
    sl.registerLazySingleton(() => InternetConnectionChecker());
  }
}
