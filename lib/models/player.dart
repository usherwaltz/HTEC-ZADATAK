class Player {
  final id;
  final String firstName;
  final String lastName;
  final String description;
  final int points;
  final String dateOfBirth;
  final int isProfessional;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final tournamentId;

  const Player({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.description,
    required this.points,
    required this.dateOfBirth,
    required this.isProfessional,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.tournamentId
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      description: json['description'] ?? '',
      points: json['points'] ?? 0,
      dateOfBirth: json['dateOfBirth'] ?? '',
      isProfessional: json['isProfessional'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'] ?? '',
      tournamentId: json['tournament_id']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['description'] = description;
    data['points'] = points;
    data['dateOfBirth'] = dateOfBirth;
    data['isProfessional'] = isProfessional;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['tournament_id'] = tournamentId;
    return data;
  }
}