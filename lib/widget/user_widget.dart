import 'package:flutter/material.dart';
import 'package:riverpod_one/modifiers/user_helper.dart';

class UserWidget extends StatelessWidget {
  final Users user;
  const UserWidget({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black12,
            backgroundImage: NetworkImage(user.urlAvatar),
            radius: 80,
          ),
          const SizedBox(height: 24),
          buildHeader('Name:', user.username),
          const SizedBox(height: 8),
          buildHeader('Email:', user.email),
        ],
      );

  Widget buildHeader(String header, String value) => Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Container(
              width: 120,
              child: Text(
                header,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 120,
              child: Text(
                value,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const Spacer(),
          ],
        ),
      );
}
