import 'package:auth_flow_demo/core/error/failures.dart';
import 'package:auth_flow_demo/core/usecases/usecase.dart';
import 'package:auth_flow_demo/features/auth/domain/entity/user_entity.dart';
import 'package:auth_flow_demo/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentUserUseCase implements Usecase<UserEntity?, NoParams> {
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}