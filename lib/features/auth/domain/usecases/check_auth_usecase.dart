import 'package:auth_flow_demo/core/error/failures.dart';
import 'package:auth_flow_demo/core/usecases/usecase.dart';
import 'package:auth_flow_demo/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class CheckAuthUseCase implements Usecase<bool, NoParams> {
  final AuthRepository repository;

  CheckAuthUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isAuthenticated();
  }
}