import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/widgets/images_viewer.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class ImageItem extends StatelessWidget {
  const ImageItem(
    this.src, {
    super.key,
    this.type = ImageType.Permanent,
    required this.onDismissed,
  });

  final src;
  final ImageType type;
  final void Function() onDismissed;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(right: MEAS.notePublishImageMarginRight),
        decoration: BoxDecoration(
          color: Styles.BackgroundColor,
          borderRadius: BorderRadius.circular(MEAS.notePublishImageRadius),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            type == ImageType.Permanent
                ? Image.memory(
                    src,
                    width: MEAS.notePublishImageLength,
                    height: MEAS.notePublishImageLength,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    src,
                    width: MEAS.notePublishImageLength,
                    height: MEAS.notePublishImageLength,
                    fit: BoxFit.cover,
                  ),
            Positioned(
              top: MEAS.notePublishImageDismissIconGap,
              right: MEAS.notePublishImageDismissIconGap,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: SVGIcon(
                  'assets/images/cross.svg',
                  width: MEAS.notePublishImageDismissIconLength,
                  height: MEAS.notePublishImageDismissIconLength,
                ),
                onTap: onDismissed,
              ),
            )
          ],
        ),
      );
}

class ImageUploader extends StatelessWidget {
  ImageUploader({
    super.key,
    required this.onUploaded,
  });

  final void Function(List<XFile>) onUploaded;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          width: MEAS.notePublishImageLength,
          height: MEAS.notePublishImageLength,
          margin: EdgeInsets.only(right: MEAS.notePublishImageMarginRight),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(MEAS.notePublishImageRadius),
            border: Border.all(
              color: Styles.BackgroundColor,
              width: 2.w,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: SVGIcon(
            'assets/images/add.svg',
            width: MEAS.notePublishImageUploaderIconLength,
            height: MEAS.notePublishImageUploaderIconLength,
          ),
        ),
        onTap: () async {
          final images = await _imagePicker.pickMultiImage();
          if (images.length > 0) onUploaded(images);
        },
      );
}
