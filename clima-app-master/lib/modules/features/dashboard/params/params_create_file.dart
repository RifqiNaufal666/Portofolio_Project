class ParamsCreateFile {
  ParamsCreateFile({
    required this.id,
    required this.name,
    required this.dateTime,
    required this.linkUrl,
    this.updateAt,
  });

  final String? id;
  final String name;
  final String dateTime;
  final String? updateAt;
  final String linkUrl;

  Map<String, String> toMap() => {
        'id': id ?? '',
        'name': name,
        'datetime': dateTime,
        'update_at': updateAt ?? '',
        'link_url': linkUrl,
      };

  Map<String, String> toMapWith({
    String? id,
    String? name,
    String? dateTime,
    String? linkUrl,
    String? updateAt,
  }) =>
      {
        'id': id ?? this.id ?? '',
        'name': name ?? this.name,
        'datetime': dateTime ?? this.dateTime,
        'link_url': linkUrl ?? this.linkUrl,
        'update_at': updateAt ?? this.updateAt ?? '',
      };
}
