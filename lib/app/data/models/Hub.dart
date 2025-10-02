class Hub {
  final int? id; // Primary Key
  final String manNumber;
  final String hubName;
  final String description;
  final String? did;
  final String hubType;

  Hub({
    this.id,
    required this.manNumber,
    required this.hubName,
    required this.description,
    this.did,
    required this.hubType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'manNumber': manNumber,
      'hubName': hubName,
      'description': description,
      'did': did,
      'hubType': hubType,
    };
  }

  factory Hub.fromMap(Map<String, dynamic> map) {
    return Hub(
      id: map['id'],
      manNumber: map['manNumber'],
      hubName: map['hubName'],
      description: map['description'],
      did: map['did'],
      hubType: map['hubType'],
    );
  }
}
