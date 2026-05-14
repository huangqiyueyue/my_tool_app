import 'package:equatable/equatable.dart';

class ItemModel extends Equatable {
  final String id;
  final String title;
  final String? content;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const ItemModel({
    required this.id,
    required this.title,
    this.content,
    required this.createdAt,
    required this.updatedAt,
  });
  
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
  
  ItemModel copyWith({
    String? title,
    String? content,
    DateTime? updatedAt,
  }) {
    return ItemModel(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
  
  @override
  List<Object?> get props => [id, title, content, createdAt, updatedAt];
}
