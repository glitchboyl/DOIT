import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doit/utils/time.dart';
import 'package:doit/models/note.dart';
import 'package:doit/providers/note.dart';
import 'package:doit/widgets/svg_icon.dart';
import 'package:doit/constants/icons.dart';
import 'package:doit/constants/styles.dart';
import 'package:doit/constants/meas.dart';

class NoteItemWidget extends StatelessWidget {
  const NoteItemWidget(this.note);
  final Note note;

  List<Widget> buildWidgets(ColorScheme colorScheme) {
    final List<Widget> _widgets = [
      Text(
        note.title,
        style: TextStyles.regularTextStyle.copyWith(
          color: colorScheme.primaryTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 2),
      Text(
        getNoteTime(note.publishTime),
        style: TextStyles.smallTextStyle.copyWith(
          color: colorScheme.secondaryTextColor,
        ),
      ),
    ];
    if (note.images.length > 0 || note.body.trim() != '') {
      _widgets.add(
        SizedBox(height: 12),
      );
      _widgets.add(
        SVGIcon(
          Ico.OpeningQuotes,
          width: MEAS.noteItemQuotesLength,
          height: MEAS.noteItemQuotesLength,
        ),
      );
      if (note.images.length > 0) {
        _widgets.add(
          Container(
            margin: EdgeInsets.only(top: 10),
            constraints: BoxConstraints(
              minWidth: 319,
              minHeight: 180,
              maxHeight: 399,
            ),
            decoration: BoxDecoration(
              color: colorScheme.backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.memory(
              note.images[0],
              fit: BoxFit.cover,
            ),
          ),
        );
      }
      _widgets.add(
        SizedBox(height: 10),
      );
      if (note.body.trim() != '') {
        _widgets.add(
          Text(
            note.body,
            style: TextStyles.smallTextStyle.copyWith(
              color: colorScheme.primaryTextColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );
        _widgets.add(
          SizedBox(height: 10),
        );
      }
      _widgets.add(
        Align(
          alignment: Alignment.centerRight,
          child: SVGIcon(
            Ico.ClosingQuotes,
            width: MEAS.noteItemQuotesLength,
            height: MEAS.noteItemQuotesLength,
          ),
        ),
      );
    }

    return _widgets;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        key: ValueKey(note.id),
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.regularBaseColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildWidgets(colorScheme),
        ),
      ),
      onTap: () => {
        Provider.of<NoteProvider>(context, listen: false).focus(note),
        Navigator.pushNamed(context, '/note'),
      },
    );
  }
}
