import 'package:flutter/material.dart';

class MultiChoiceTags extends StatefulWidget {
  final List<dynamic> selectedTags;
  final List<dynamic> options;
  final ValueChanged<List<dynamic>> onChanged;
  MultiChoiceTags({Key key, this.options, this.selectedTags, this.onChanged})
      : super(key: key);
  @override
  _MultiChoiceTagsState createState() => _MultiChoiceTagsState();
}

class _MultiChoiceTagsState extends State<MultiChoiceTags> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.start,
          children: [
            ...widget.options.map((e) => _buildSpecialityItem(e)).toList()
          ],
        ));
  }

  _buildSpecialityItem(dynamic e) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.selectedTags.contains(e))
            widget.selectedTags.remove(e);
          else
            widget.selectedTags.add(e);
        });
        widget.onChanged(widget.selectedTags);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (widget.selectedTags.contains(e)
                ? Colors.blue[600]
                : Colors.white),
            border: Border.all(width: 1, color: Colors.blue[600])),
        child: Text(e.name,
            style: TextStyle(
              color: widget.selectedTags.contains(e)
                  ? Colors.white
                  : Colors.blue[600],
            )),
      ),
    );
  }

  clear() {
    setState(() {
      widget.selectedTags.clear();
    });
  }
}
