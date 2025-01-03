import 'package:equatable/equatable.dart';
import 'package:solly_labs/features/widget/domain/entities/parent_child_connection_type_ny.dart';
import 'package:solly_labs/features/widget/domain/entities/widget_type_ny.dart';

class WidgetNy extends Equatable {
  final String id;
  final DateTime createdAt;
  final WidgetTypeNy widgetType;
  final String? parentId;
  final String widgetContent;
  final String? artBoardId;
  final String? widgetName;
  final String? createdBy;
  final DateTime lastModifiedAt;
  final String? lastModifiedBy;
  final String? projectId;
  final bool showWidgetOptions;
  final bool showChildWidget;
  final ParentChildConnectionTypeNy? parentChildConnectionType;
  final String levels;
  final int updateCount;
  final int? levelDepth;
  final int? levelIndex;

  const WidgetNy({
    required this.id,
    required this.createdAt,
    required this.widgetType,
    this.parentId,
    required this.widgetContent,
    this.artBoardId,
    this.widgetName,
    this.createdBy,
    required this.lastModifiedAt,
    this.lastModifiedBy,
    this.projectId,
    required this.showWidgetOptions,
    required this.showChildWidget,
    this.parentChildConnectionType,
    required this.levels,
    required this.updateCount,
    this.levelDepth,
    this.levelIndex,
  });

  @override
  List<Object?> get props => [
        id,
        createdAt,
        widgetType,
        parentId,
        widgetContent,
        artBoardId,
        widgetName,
        createdBy,
        lastModifiedAt,
        lastModifiedBy,
        projectId,
        showWidgetOptions,
        showChildWidget,
        parentChildConnectionType,
        levels,
        updateCount,
        levelDepth,
        levelIndex,
      ];
}
