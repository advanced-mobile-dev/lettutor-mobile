import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:lettutor_app/models/course/topic.dart';
import 'package:lettutor_app/widgets/app_bar.dart';

class TopicScreen extends StatefulWidget {
  final Topic topic;
  TopicScreen(this.topic);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  String _pageInfo = '';
  @override
  Widget build(BuildContext context) {
    print(widget.topic.nameFile);
    return Scaffold(
        appBar: ApplicationAppBar(
          title: '${widget.topic.name}',
          actions: [
            Container(
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: Text('$_pageInfo'))
          ],
        ),
        body: PDF(
          autoSpacing: true,
          pageFling: true,
          onViewCreated: (controller) async {
            int pageCount = await controller.getPageCount();
            int currentPage = await controller.getCurrentPage();
            setState(() {
              _pageInfo = '${currentPage + 1}/$pageCount';
            });
          },
          onPageChanged: (page, total) {
            setState(() {
              _pageInfo = '${page + 1}/$total';
            });
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
        ).cachedFromUrl(
          '${widget.topic.nameFile.replaceAll(' ', '%20')}',
          placeholder: (progress) => Center(child: Text('$progress %')),
          errorWidget: (error) => Center(child: Text(error.toString())),
        ));
  }
}
