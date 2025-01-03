import 'package:equatable/equatable.dart';

class ArtBoardNy extends Equatable {
  final String id;
  final String name;
  final String projectId;
  // Add other properties as needed, e.g., description, layout, etc.

  const ArtBoardNy({required this.id, required this.name, required this.projectId});

  @override
  List<Object?> get props => [id, name, projectId];
}
