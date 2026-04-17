import 'package:auth_flow_demo/core/error/failures.dart';
import 'package:auth_flow_demo/core/usecases/usecase.dart';
import 'package:auth_flow_demo/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase implements UseCase<void,NoParams>{
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout();
  }
}