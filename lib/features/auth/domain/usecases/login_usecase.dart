import 'package:auth_flow_demo/core/error/failures.dart';
import 'package:auth_flow_demo/core/usecases/usecase.dart';
import 'package:auth_flow_demo/features/auth/domain/entity/user_entity.dart';
import 'package:auth_flow_demo/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements UseCase<UserEntity,LoginParams>{
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    return await repository.login(email: params.email, password: params.password);
  }
}

class LoginParams{
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}