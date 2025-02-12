import 'dart:convert';

import 'package:test/models/post_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = 'http://192.168.130.143:8000';

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

  //get single post
  Future<PostModel> getSingleBlog(String uuid) async {
    final response = await http.get(Uri.parse('$baseUrl/api/posts/$uuid/'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> post = jsonDecode(response.body);
      return PostModel.fromJson(post);
    } else {
      throw Exception('Failed to load blog');
    }
  }

  //update post
  Future<PostModel> updateBlog(PostModel post) async {
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
}
