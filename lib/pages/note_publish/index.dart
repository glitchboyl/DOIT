import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:doit/widgets/app_bar.dart';
import 'package:doit/widgets/svg_icon_button.dart';
import 'package:doit/widgets/input.dart';
import 'package:doit/widgets/images_viewer.dart';
import 'package:doit/widgets/parts.dart';
import 'image.dart';
import 'package:doit/providers/note.dart';
import 'package:doit/utils/toast.dart';
import 'package:doit/models/note.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class NotePublishPage extends StatefulWidget {
  const NotePublishPage({super.key});
  @override
  _NotePublishPageState createState() => _NotePublishPageState();
}

class _NotePublishPageState extends State<NotePublishPage> {
  String _title = '';
  String _body = '';
  List<Uint8List> _images = [];
  List<XFile> _temporaryImages = [];
  late final Note? _focusedNote;
  bool _publishActived = false;

  bool validate() => _title.trim() != '';

  NoteProvider getProvider(BuildContext context, {bool listen = true}) =>
      Provider.of<NoteProvider>(
        context,
        listen: listen,
      );

  int get restImagesCount =>
      (imagesMaxLimit - _images.length - _temporaryImages.length);

  @override
  void initState() {
    super.initState();
    _focusedNote = getProvider(this.context, listen: false).focusedNote;
    if (_focusedNote != null) {
      _title = _focusedNote!.title;
      _body = _focusedNote?.body ?? '';
      _images = [..._focusedNote!.images];
      _publishActived = true;
    }
  }

  List<Widget> buildImagesRow() {
    final List<Widget> _imagesRowWidgets = [SizedBox(width: 16)];
    int i = 0;
    for (i = 0; i < _images.length; i++) {
      final image = _images[i];
      _imagesRowWidgets.add(
        ImageItem(
          image,
          key: ValueKey(image),
          onDismissed: () => setState(
            () => _images.remove(image),
          ),
        ),
      );
    }
    for (i = 0; i < _temporaryImages.length; i++) {
      final image = _temporaryImages[i];
      _imagesRowWidgets.add(
        ImageItem(
          File(image.path),
          key: ValueKey(image.path),
          type: ImageType.Temporary,
          onDismissed: () => setState(
            () => _temporaryImages.remove(image),
          ),
        ),
      );
    }
    if (restImagesCount > 0) {
      _imagesRowWidgets.add(
        ImageUploader(
          onUploaded: (images) => setState(
            () => _temporaryImages.addAll(
              images.sublist(
                0,
                min(restImagesCount, images.length),
              ),
            ),
          ),
        ),
      );
    }
    _imagesRowWidgets.add(SizedBox(width: 6));
    return _imagesRowWidgets;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBarBuilder(
          leading: SVGIconButton(
            'assets/images/back.svg',
            onPressed: () => Navigator.pop(context),
          ),
          trailings: [
            SVGIconButton(
              'assets/images/publish${_publishActived ? '' : '_disabled'}.svg',
              onPressed: () async {
                if (_publishActived) {
                  final _provider = getProvider(this.context, listen: false);
                  final bool isPublished = _provider.focusedNote == null;
                  for (int i = 0; i < _temporaryImages.length; i++) {
                    final Uint8List image =
                        await _temporaryImages[i].readAsBytes();
                    _images.add(image);
                  }
                  if (_provider.focusedNote != null) {
                    _provider.focusedNote!.title = _title;
                    _provider.focusedNote!.body = _body;
                    _provider.focusedNote!.images = _images;
                    await _provider.update(_provider.focusedNote!);
                  } else {
                    await _provider.insert(
                      Note(
                        id: UniqueKey().hashCode,
                        title: _title,
                        body: _body,
                        images: _images,
                        publishTime: DateTime.now(),
                      ),
                    );
                  }
                  Toast.show(
                    context,
                    text: '${isPublished ? '发布' : '编辑'}成功',
                  );
                  Navigator.pop(context);
                  if (isPublished) Navigator.pushNamed(context, '/note');
                }
              },
            ),
          ],
        ),
        body: () {
          final _widgets = [
            SizedBox(height: 12),
            Container(
              height: MEAS.notePublishImageLength,
              child: () {
                final _imagesRow = buildImagesRow();
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => _imagesRow[index],
                  itemCount: _imagesRow.length,
                );
              }(),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 12,
                left: 16,
                right: 16,
                bottom: 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Input(
                    initialValue: _title,
                    height: MEAS.titleInputHeight,
                    fontSize: Styles.textSize,
                    lineHeight: Styles.textLineHeight,
                    fontWeight: FontWeight.bold,
                    hintText: '在这一刻，要写点什么呢~',
                    border: titleBorder,
                    maxLines: 1,
                    autofocus: true,
                    onChanged: (value) => setState(
                      () {
                        _title = value;
                        _publishActived = validate();
                      },
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 180,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Styles.BackgroundColor,
                          width: 1.2,
                        ),
                      ),
                    ),
                    child: Input(
                      initialValue: _body,
                      hintText: '记下这一刻…',
                      border: bodyBorder,
                      autofocus: true,
                      onChanged: (body) => _body = body,
                    ),
                  ),
                ],
              ),
            )
          ];
          return ListView.builder(
            itemBuilder: (context, index) => _widgets[index],
            itemCount: _widgets.length,
          );
        }(),
        backgroundColor: Styles.RegularBaseColor,
      );
}
