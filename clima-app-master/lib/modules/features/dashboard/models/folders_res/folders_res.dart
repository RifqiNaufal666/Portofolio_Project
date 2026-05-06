import 'package:equatable/equatable.dart';

class DataFolder extends Equatable {
  final String? datetime;
  final String? updateAt;
  final String? name;
  final String? id;

  const DataFolder({this.datetime, this.name, this.id, this.updateAt});

  factory DataFolder.fromJson(Map<String, dynamic> json) => DataFolder(
        updateAt: json['update_at']?.toString(),
        datetime: json['datetime']?.toString(),
        name: json['name']?.toString(),
        id: json['id']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        if (updateAt != null) 'update_at': updateAt,
        if (datetime != null) 'datetime': datetime,
        if (name != null) 'name': name,
        if (id != null) 'id': id,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [datetime, name, id, updateAt];
}
