import 'dart:async';
import 'dart:math';
import 'package:doit/widgets/images_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_bar.dart';
import 'package:doit/widgets/transition_route.dart';
import 'package:doit/providers/note.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/constants/styles.dart';

class NotePage extends StatelessWidget {
  Future<List<Widget>> buildWidgets(BuildContext context) async {
    final List<Widget> _widgets = [];
    final focusedNote =
        Provider.of<NoteProvider>(context, listen: false).focusedNote!;
    final colorScheme = Theme.of(context).colorScheme;
    if (focusedNote.images.length > 0) {
      final List<Widget> _images = [];
      final List<ImageView> _imageView = [];
      double imageBoxHeight = 0;
      for (int i = 0; i < focusedNote.images.length; i++) {
        final image = Image.memory(
          focusedNote.images[i],
          fit: BoxFit.contain,
        );
        int initialIndex = i;
        Completer<ImageInfo> completer = Completer();
        final _imageStream = image.image.resolve(ImageConfiguration.empty);
        final _imageStreamListener = ImageStreamListener(
          (info, synchronousCall) {
            final imageInfo = info.image;
            double ratio = MediaQuery.of(context).size.width / imageInfo.width;
            if (imageBoxHeight < imageInfo.height * ratio)
              imageBoxHeight = imageInfo.height * ratio;
            completer.complete(info);
          },
        );
        _imageStream.addListener(
          _imageStreamListener,
        );
        await completer.future;
        _imageStream.removeListener(
          _imageStreamListener,
        );
        _imageView.add(ImageView(focusedNote.images[i]));
        _images.add(
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              TransitionRouteBuilder(
                ImagesViewer(
                  images: _imageView,
                  initialIndex: initialIndex,
                  tag: focusedNote.images[i],
                ),
              ),
            ),
            child: Hero(
              tag: focusedNote.images[i],
              child: image,
            ),
          ),
        );
      }
      _widgets.add(
        Container(
          constraints: BoxConstraints(
            minHeight: 211,
            maxHeight: min(imageBoxHeight, 469),
          ),
          child: PageView.builder(
            itemBuilder: (context, i) => _images[i],
            itemCount: _images.length,
          ),
        ),
      );
    }
    _widgets.add(
      Container(
        padding: EdgeInsets.only(
          top: 16,
          left: 24,
          right: 24,
          bottom: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              focusedNote.title,
              style: TextStyles.largeTextStyle.copyWith(
                color: colorScheme.primaryTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${getDateTime(focusedNote.publishTime)} ${getClockTime(focusedNote.publishTime)}',
              style: TextStyles.smallTextStyle.copyWith(
                color: colorScheme.secondaryTextColor,
              ),
            ),
            SizedBox(height: 20),
            Text(
              focusedNote.body,
              style: TextStyles.largeTextStyle.copyWith(
                color: colorScheme.primaryTextColor,
                fontSize: TextStyles.RegularTextSize,
              ),
            ),
          ],
        ),
      ),
    );
    return _widgets;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: NotesPageAppBar(),
        body: Consumer<NoteProvider>(
          builder: (context, provider, _) => FutureBuilder<List<Widget>>(
            future: buildWidgets(context),
            builder: (context, snapshot) => ListView.builder(
              itemBuilder: (context, index) => snapshot.data![index],
              itemCount: snapshot.data!.length,
            ),
            initialData: [],
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.regularBaseColor,
      );
}
