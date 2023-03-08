import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

enum ImageType {
  Permanent,
  Temporary,
}

class ImageView {
  const ImageView(
    this.src, {
    this.type = ImageType.Permanent,
  });
  final src;
  final ImageType type;
}

class ImagesViewer extends StatelessWidget {
  ImagesViewer({
    super.key,
    required this.images,
    required this.tag,
    this.initialIndex = 0,
  });

  final List<ImageView> images;
  final tag;
  final int initialIndex;
  late final PageController controller =
      PageController(initialPage: initialIndex);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => {
          Navigator.pop(context),
        },
        child: Container(
          color: Colors.black,
          child: Hero(
            tag: tag,
            child: PageView(
              controller: controller,
              children: images
                  .map<Widget>(
                    (image) => PhotoView(
                      imageProvider: image.type == ImageType.Permanent
                          ? MemoryImage(image.src)
                          : FileImage(image.src) as ImageProvider,
                      initialScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 4,
                      minScale: PhotoViewComputedScale.contained,
                      backgroundDecoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
}
