import 'package:equatable/equatable.dart';

class WidgetNy extends Equatable {
  final String id;
  final DateTime createdAt;
  final String widgetType;
  final String? parentId;
  final String widgetContent;
  final String artBoardId;
  final String widgetName;
  final String createdBy;
  final DateTime lastModifiedAt;
  final String lastModifiedBy;
  final String projectId;
  final bool showWidgetOptions;
  final bool showChildWidget;
  final String parentChildConnectionType;
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
    required this.artBoardId,
    required this.widgetName,
    required this.createdBy,
    required this.lastModifiedAt,
    required this.lastModifiedBy,
    required this.projectId,
    required this.showWidgetOptions,
    required this.showChildWidget,
    required this.parentChildConnectionType,
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
