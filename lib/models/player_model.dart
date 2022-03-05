class SinglePlayer {
  int? id;
  String? firstName;
  String? lastName;
  String? description;
  int? points;
  String? dateOfBirth;
  int? isProfessional;
  String? profileImageUrl;

  SinglePlayer(
      {this.id,
        this.firstName,
        this.lastName,
        this.description,
        this.points,
        this.dateOfBirth,
        this.isProfessional,
        this.profileImageUrl});

  SinglePlayer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    description = json['description'];
    points = json['points'];
    dateOfBirth = json['dateOfBirth'];
    isProfessional = json['isProfessional'];
    profileImageUrl = json['profileImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['description'] = description;
    data['points'] = points;
    data['dateOfBirth'] = dateOfBirth;
    data['isProfessional'] = isProfessional;
    data['profileImageUrl'] = profileImageUrl;
    return data;
  }
}