import 'package:bookly_app/core/utils/Api/api_services.dart';
import 'package:bookly_app/features/home/data/datasources/home_local_data_source.dart';
import 'package:bookly_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:bookly_app/features/home/data/repositories/home_repo_impl.dart';
import 'package:bookly_app/features/search/data/data_source/search_remote_data_source.dart';
import 'package:bookly_app/features/search/data/repo/search_repo_impl.dart';
import 'package:bookly_app/features/search/domain/repo/search_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getit = GetIt.instance;
void setUpServiceLocator() {
  getit.registerSingleton<ApiService>(ApiService(Dio()));
  getit.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      homeLocalDataSource: HomeLocalDataSourceImpl(),
      homeRemoteDataSource: HomeRemoteDataSourceImpl(
        apiService: getit.get<ApiService>(),
      ),
    ),
  );
  getit.registerSingleton<SearchRepo>(
    SearchRepoImpl(
      remoteDataSource: SearchRemoteDataSourceImpl(
        apiService: getit.get<ApiService>(),
      ),
    ),
  );
}
