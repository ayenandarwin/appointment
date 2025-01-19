import 'package:dio/dio.dart';

class DatabaseService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000'));

  // Fetch all posts
  Future<List<Map<String, dynamic>>> getAppointments() async {
    try {
      final response = await _dio.get('/appointments');
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }

  // Fetch a single post by ID
  Future<Map<String, dynamic>> getPost(int id) async {
    try {
      final response = await _dio.get('/posts/$id');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch post: $e');
    }
  }

  // Create a new post
  Future<Map<String, dynamic>> createPost(Map<String, dynamic> post) async {
    try {
      final response = await _dio.post('/posts', data: post);
      return response.data;
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  // Update an existing post
  Future<Map<String, dynamic>> updatePost(int id, Map<String, dynamic> post) async {
    try {
      final response = await _dio.put('/posts/$id', data: post);
      return response.data;
    } catch (e) {
      throw Exception('Failed to update post: $e');
    }
  }

  // Delete a post by ID
  Future<void> deletePost(int id) async {
    try {
      await _dio.delete('/posts/$id');
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }
}
