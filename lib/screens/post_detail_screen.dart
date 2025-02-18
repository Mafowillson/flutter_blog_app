import 'package:flutter/material.dart';
import 'package:test/models/post_model.dart';
import 'package:test/services/api_services.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    //get the post model from the arguments
    final PostModel post =
        ModalRoute.of(context)!.settings.arguments as PostModel;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/post.jpg',
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                post.content,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(post.created),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
              //add a delete button
              MaterialButton(
                onPressed: () {
                  //alert dialog to confirm deletion
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Delete Post'),
                        content: const Text('Are you sure you want to delete?'),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              //delete the post
                              await ApiServices().deletePost(post.uuid);
                              Navigator.pop(context);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Delete'),
              ),
              //add an update button
              MaterialButton(
                onPressed: () {
                  //update the post
                  //create a dialog to update the post title and content
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Update Post'),
                        content: Column(
                          children: [
                            TextField(
                              controller:
                                  TextEditingController(text: post.title),
                              decoration: const InputDecoration(
                                labelText: 'Title',
                              ),
                              onChanged: (value) {
                                //update the post title using the copyWith method
                                post.copyWith(title: value);
                              },
                            ),
                            TextField(
                              controller:
                                  TextEditingController(text: post.content),
                              decoration: const InputDecoration(
                                labelText: 'Content',
                              ),
                              onChanged: (value) {
                                //update the post content using the copyWith method
                                post.copyWith(content: value);
                              },
                            ),
                          ],
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              //update the post
                              await ApiServices().updatePost(post);
                              Navigator.pop(context);
                            },
                            child: const Text('Update'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
