import 'package:auth_flow_demo/core/error/exceptions.dart';
import 'package:auth_flow_demo/core/error/failures.dart';
import 'package:auth_flow_demo/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:auth_flow_demo/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:auth_flow_demo/features/auth/domain/entity/user_entity.dart';
import 'package:auth_flow_demo/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await authLocalDataSource.getCachedUser();
      return Right(user);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = await authLocalDataSource.getCachedToken();
      return Right(token != null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDataSource.login(email, password);
      await authLocalDataSource.cacheToken('mock_token_${user.id}');
      await authLocalDataSource.cacheUser(user);
      return Right(user);
    } on InvalidCredentialsException {
      return Left(InvalidCredentialsFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authRemoteDataSource.logout();
      await authLocalDataSource.clearToken();
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}