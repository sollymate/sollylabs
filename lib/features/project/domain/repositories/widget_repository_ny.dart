import 'package:dartz/dartz.dart';
import 'package:solly_labs/core/error/failures.dart';
import 'package:solly_labs/features/project/domain/entities/widget_ny.dart';

abstract class WidgetRepositoryNy {
  Future<Either<Failure, List<WidgetNy>>> getWidgetsByArtBoardId(String artBoardId);
}
