import 'package:flutter/material.dart';

class Task {
  final int? id;
  final int projectId;
  final String title;
  final String description;
  final String status; // e.g., 'pending', 'in_progress', 'completed'
  final DateTime? dueDate;
  final DateTime createdAt;

  Task({
    this.id,
    required this.projectId,
    required this.title,
    required this.description,
    this.status = 'pending',
    this.dueDate,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'projectId': projectId,
      'title': title,
      'description': description,
      'status': status,
      'dueDate': dueDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int,
      projectId: map['projectId'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate'] as String) : null,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}
