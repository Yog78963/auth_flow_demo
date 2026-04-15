import 'package:auth_flow_demo/core/error/failures.dart';
import 'package:auth_flow_demo/features/auth/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email, 
    required String password
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserEntity?>> getCurrentUser();

  Future<Either<Failure, bool>> isAuthenticated();
}