import 'dart:convert';

import 'package:test/models/post_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = "http://10.0.2.2:8000";

  //get all blogs
  Future<List<PostModel>> getAllBlogs() async {
    final response = await http.get(Uri.parse('$baseUrl/api/posts/'));
    if (response.statusCode == 200) {
      final List<dynamic> posts = jsonDecode(response.body);
      return posts.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  //create post method to create a new post with title and content as parameters since the other atrributes are auto generated in the backend
  Future<PostModel> createPost(String title, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/posts/create/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'content': content,
      }),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> post = jsonDecode(response.body);
      return PostModel.fromJson(post);
    } else {
      throw Exception('Failed to create blog');
    }
  }

  //update post
  Future<PostModel> updatePost(PostModel post) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/posts/${post.uuid}/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> post = jsonDecode(response.body);
      return PostModel.fromJson(post);
    } else {
      throw Exception('Failed to update blog');
    }
  }

  //delete post
  Future<void> deletePost(String uuid) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/api/posts/delete/$uuid/'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete blog');
    }
  }
}
