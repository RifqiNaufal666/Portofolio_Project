class ParamsCreateFolder {
  ParamsCreateFolder({
    required this.id,
    required this.name,
    required this.dateTime,
    this.updateAt,
  });

  final String? id;
  final String name;
  final String dateTime;
  final String? updateAt;

  Map<String, String> toMap() => {
        'id': id ?? '',
        'name': name,
        'datetime': dateTime,
        'update_at': updateAt ?? '',
      };

  Map<String, String> toMapWith({
    String? id,
    String? name,
    String? dateTime,
    String? updateAt,
  }) =>
      {
        'id': id ?? this.id ?? '',
        'name': name ?? this.name,
        'datetime': dateTime ?? this.dateTime,
        'update_at': updateAt ?? this.updateAt ?? '',
      };
}
