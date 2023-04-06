import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';
import 'package:doit/widgets/text.dart';
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
        onLongPress: () => {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => CupertinoActionSheet(
              actions: <CupertinoActionSheetAction>[
                CupertinoActionSheetAction(
                  isDefaultAction: true,
                  onPressed: () => {
                    print(controller.page),
                    Navigator.pop(context),
                    Toast.show(context, text: '保存成功'),
                    
                  },
                  child: TextBuilder(
                    '保存图片',
                    color: Styles.PrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Styles.largeTextSize,
                    lineHeight: Styles.largeTextLineHeight,
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: TextBuilder(
                    '取消',
                    color: Styles.PrimaryColor,
                    fontSize: Styles.largeTextSize,
                    lineHeight: Styles.largeTextLineHeight,
                  ),
                ),
              ],
            ),
          )
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
