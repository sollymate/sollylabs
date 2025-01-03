import 'package:equatable/equatable.dart';

class ArtBoardNy extends Equatable {
  final String id;
  final DateTime createdAt;
  final String? createdBy;
  final String artBoardName;
  final DateTime lastModifiedAt;
  final String? lastModifiedBy;
  final String? projectId; // Now nullable
  final String? artBoardDescription;
  final int sequenceNumber;
  final bool showControls;
  final String? code; // Now nullable
  final int counter;

  const ArtBoardNy({
    required this.id,
    required this.createdAt,
    this.createdBy,
    required this.artBoardName,
    required this.lastModifiedAt,
    this.lastModifiedBy,
    this.projectId, // Now nullable
    this.artBoardDescription,
    required this.sequenceNumber,
    required this.showControls,
    this.code, // Now nullable
    required this.counter,
  });

  @override
  List<Object?> get props => [
        id,
        createdAt,
        createdBy,
        artBoardName,
        lastModifiedAt,
        lastModifiedBy,
        projectId,
        artBoardDescription,
        sequenceNumber,
        showControls,
        code,
        counter,
      ];
}
