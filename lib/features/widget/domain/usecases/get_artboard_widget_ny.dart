import 'package:dartz/dartz.dart';
import 'package:solly_labs/core/error/failures.dart';
import 'package:solly_labs/core/usecases/usecase.dart';
import 'package:solly_labs/features/project/domain/entities/widget_ny.dart';
import 'package:solly_labs/features/project/domain/repositories/widget_repository_ny.dart';

class GetArtboardWidgetsNy implements UseCase<List<WidgetNy>, String> {
  final WidgetRepositoryNy repository;

  GetArtboardWidgetsNy(this.repository);

  @override
  Future<Either<Failure, List<WidgetNy>>> call(String artBoardId) async {
    return await repository.getWidgetsByArtBoardId(artBoardId);
  }
}
