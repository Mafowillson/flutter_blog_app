class PostModel {
  final String uuid;
  final String title;
  final String content;
  final String created;
  final String updated;

  PostModel({
    required this.uuid,
    required this.title,
    required this.content,
    required this.created,
    required this.updated,
  });

  //create a copyWith method to update the model
  PostModel copyWith({
    String? uuid,
    String? title,
    String? content,
    String? created,
    String? updated,
  }) {
    return PostModel(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      content: content ?? this.content,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  // Add a factory constructor to deserialize the model
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      uuid: json['uuid'],
      title: json['title'],
      content: json['content'],
      created: json['created'],
      updated: json['updated'],
    );
  }
  // Add a toJson method to serialize the model
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'title': title,
      'content': content,
      'created': created,
      'updated': updated,
    };
  }
}
