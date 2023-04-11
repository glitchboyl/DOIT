import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:doit/utils/toast.dart';
import 'package:doit/constants/styles.dart';

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
        onLongPress: () {
          final colorScheme = Theme.of(context).colorScheme;
          showCupertinoModalPopup<void>(
            context: context,
            builder: (ctx) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(ctx);
                    Toast.show(
                      context,
                      text: '保存中...',
                      loading: true,
                    );
                    final result = await ImageGallerySaver.saveImage(
                      images[int.parse(controller.page!.toStringAsFixed(0))]
                          .src,
                    );
                    Toast.close();
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () => Toast.show(
                        context,
                        text: '保存${result['isSuccess'] ? '成功' : '失败'}',
                      ),
                    );
                  },
                  child: Text(
                    '保存图片',
                    style: TextStyles.largeTextStyle.copyWith(
                      color: colorScheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '取消',
                    style: TextStyles.largeTextStyle.copyWith(
                      color: colorScheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: Container(
          color: Color(0xFF000000),
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
                        color: Color(0x00000000),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
}
