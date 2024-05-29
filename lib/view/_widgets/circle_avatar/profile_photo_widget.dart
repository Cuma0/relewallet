import 'package:flutter/material.dart';

Widget profilePhotoWidget(BuildContext context, String? photoUrl) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(200),
    child: CircleAvatar(
      radius: 40,
      child: photoUrl.toString() != "null" &&
              photoUrl != null &&
              photoUrl.isNotEmpty
          ? Image.network(
              photoUrl,
              fit: BoxFit.cover,
            )
          : Image.asset(
              "assets/images/profilePhoto.png",
              fit: BoxFit.cover,
            ),
    ),
  );
}
