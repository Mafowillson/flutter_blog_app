import 'package:flutter/material.dart';
import 'package:test/models/post_model.dart';
import 'package:test/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PostModel>> posts;

  @override
  void initState() {
    super.initState();
    posts = ApiServices().getAllBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final PostModel post = snapshot.data![index];
                return ListTile(
                  onTap: () {},
                  title: Text(
                    post.title,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: Text(
                    post.content,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
