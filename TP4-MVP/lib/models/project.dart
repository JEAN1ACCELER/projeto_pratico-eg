import 'package:flutter/material.dart';

class Project {
  final int? id;
  final int userId;
  final String title;
  final String description;
  final String status; // e.g., 'active', 'completed', 'archived'
  final DateTime createdAt;

  Project({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    this.status = 'active',
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'] as int,
      userId: map['userId'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}
