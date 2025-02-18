import 'package:flutter/material.dart';
import 'package:test/models/post_model.dart';
import 'package:test/services/api_services.dart';
import 'package:test/widgets/search_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PostModel>> posts;
  List<String> items = ['Featured', 'Latest', 'Trending'];

  late final TextEditingController titleController = TextEditingController();
  late final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    posts = ApiServices().getAllBlogs();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.sort,
                    size: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset('assets/images/profile.webp',
                        width: 40, height: 40),
                  ),
                ],
              ),
            ),
            SearchTextField(),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      items[index],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 10,
              child: FutureBuilder<List<PostModel>>(
                future: posts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No posts found'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final PostModel post = snapshot.data![index];
                        return ListTile(
                          leading: Image.asset(
                            'assets/images/post.jpg',
                            width: 100,
                            height: 100,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/post-detail',
                              arguments: post,
                            );
                          },
                          title: Text(post.title),
                          subtitle: Text(post.created),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //show dialog to create post
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Create Post'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    TextField(
                      controller: contentController,
                      decoration: const InputDecoration(
                        labelText: 'Content',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      //create post
                      ApiServices().createPost(
                        titleController.text,
                        contentController.text,
                      );
                      //on success, refresh the posts
                      await ApiServices().getAllBlogs();
                      setState(() {
                        posts = ApiServices().getAllBlogs();
                      });
                      //close dialog
                      //empy the textfields controllers
                      titleController.clear();
                      contentController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Create'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
