import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:estuduff/core/error/failure.dart';
import 'package:estuduff/core/platform/generic_use_case.dart';
import 'package:estuduff/features/auth/domain/entity/user.dart';
import 'package:estuduff/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';

class SignUpseCase implements GenericUseCase<User, Params> {
  final AuthRepository repository;

  SignUpseCase(this.repository);

  Future<Either<Failure, User>> call(Params params) async {
    return await repository.signUp(
      email: params.email,
      password: params.password,
      name: params.name,
      programId: params.programId,
    );
  }
}

class Params extends Equatable {
  final String password;
  final String name;
  final String email;
  final int programId;

  Params({
    @required this.email,
    @required this.password,
    this.name,
    this.programId,
  });

  @override
  List<Object> get props => [email, password, name, programId];
}
