import 'package:equatable/equatable.dart';

class ProjectNy extends Equatable {
  final String id;
  final DateTime createdAt;
  final String? createdBy; // Can be null if created_by is not set in the database
  final String projectName;
  final DateTime lastModifiedAt;
  final String? lastModifiedBy; // Can be null if last_modified_by is not set
  final String? collectionId; // Can be null if collection_id is not set
  final String? projectDescription;
  final int widthArtBoard;
  final int heightArtBoard;
  final int defaultSidebar;
  final int counter;

  const ProjectNy({
    required this.id,
    required this.createdAt,
    this.createdBy,
    required this.projectName,
    required this.lastModifiedAt,
    this.lastModifiedBy,
    this.collectionId,
    this.projectDescription,
    required this.widthArtBoard,
    required this.heightArtBoard,
    required this.defaultSidebar,
    required this.counter,
  });

  @override
  List<Object?> get props => [
        id,
        createdAt,
        createdBy,
        projectName,
        lastModifiedAt,
        lastModifiedBy,
        collectionId,
        projectDescription,
        widthArtBoard,
        heightArtBoard,
        defaultSidebar,
        counter,
      ];
}
