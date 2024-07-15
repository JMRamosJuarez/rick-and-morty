import 'package:either_dart/either.dart';
import 'package:rick_and_morty/domain/entities/app_error.dart';

abstract class UseCase<Request, Response> {
  Future<Either<AppError, Response>> call(Request request);
}
