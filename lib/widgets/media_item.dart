import 'package:flutter/cupertino.dart';
import 'package:inprize/models/ig_media.dart';

class MediaItem extends StatelessWidget {
  final IgMedia media;

  const MediaItem({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Image.network(
        media.mediaUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
