import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String title;
  final String createdAt;
  final void Function()? onTap;
  const PostCard({
    super.key,
    required this.title,
    required this.createdAt,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        decoration: BoxDecoration(),
        child: Image.asset('assets/images/post_img.jpg', width: 40, height: 40),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        createdAt,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
