import 'package:equatable/equatable.dart';

class DataFile extends Equatable {
  final DateTime? dateTime;
  final DateTime? updateAt;
  final String? linkUrl;
  final String? name;
  final String? id;

  const DataFile({this.name, this.id, this.dateTime, this.linkUrl, this.updateAt});

  factory DataFile.fromJson(Map<String, dynamic> json) => DataFile(
        dateTime: (json['datetime']?.toString().isNotEmpty ?? false)
            ? DateTime.parse(json['datetime'].toString())
            : null,
        updateAt: (json['update_at']?.toString().isNotEmpty ?? false)
            ? DateTime.parse(json['update_at'].toString())
            : null,
        linkUrl: json['link_url']?.toString(),
        name: json['name']?.toString(),
        id: json['id']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        if (updateAt != null) 'update_at': updateAt,
        if (dateTime != null) 'datetime': dateTime,
        if (linkUrl != null) 'link_url': linkUrl,
        if (name != null) 'name': name,
        if (id != null) 'id': id,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, id, dateTime, linkUrl, updateAt];
}
