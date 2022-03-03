class Players {
  final int id;
  final String firstName;
  final String lastName;
  final int points;
  final int isProfessional;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final bool tournamentId;
  // final List trainers;

  const Players({
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.points,
      required this.isProfessional,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.tournamentId,
      // required this.trainers
    });

  factory Players.fromJson(Map<String, dynamic> json) {
    return Players(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      points: json['points'] ?? 0,
      isProfessional: json['isProfessional'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      deletedAt: json['deletedAt'] ?? '',
      tournamentId: json['tournamentId'] ?? false
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['firstName'] = firstName;
  //   data['lastName'] = lastName;
  //   data['points'] = points;
  //   data['isProfessional'] = isProfessional;
  //   data['created_at'] = createdAt;
  //   data['updated_at'] = updatedAt;
  //   data['deleted_at'] = deletedAt;
  //   data['tournament_id'] = tournamentId;
  //   return data;
  // }
}