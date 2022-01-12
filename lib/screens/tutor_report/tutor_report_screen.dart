import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/tutor_report/tutor_report_bloc.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/loading_overlay.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class TutorReportScreen extends StatelessWidget {
  final LoadingOverlay _loadingOverlay = new LoadingOverlay();
  final TextEditingController _noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: ApplicationAppBar(
          title: 'Report',
        ),
        body: BlocConsumer<TutorReportBloc, TutorReportState>(
          listener: (context, state) {
            if (state is TutorReportLoadingState) {
              _loadingOverlay.show(context);
            } else {
              _loadingOverlay.hide();
            }

            if (state is ReportSuccessState) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                        title: Row(
                          children: [
                            Icon(
                              Icons.check_box_rounded,
                              size: 36,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Report successfully")
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                              Navigator.pop(
                                context,
                              );
                            },
                          ),
                        ],
                      ));
            }
            if (state is ReportFailedState) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Row(
                          children: [
                            Icon(
                              Icons.cancel,
                              size: 36,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Failed")
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text('Go back'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ));
            }
          },
          builder: (context, state) {
            final tutorBasicInfo =
                context.read<TutorReportBloc>().tutor.tutorBasicInfo;
            return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(AppSizes.pagePadding),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              'Tutor: ${tutorBasicInfo.name}',
                              style: Theme.of(context).textTheme.headline6,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Help us understand what\'s happening',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: _noteController,
                          maxLines: 4,
                          iconData: null,
                          title: '',
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SubmitButton(
                          backgroundColor: Colors.red[900],
                          icon: Icon(Icons.warning),
                          text: 'Submit Report',
                          function: () {
                            context
                                .read<TutorReportBloc>()
                                .add(ReportEvent(_noteController.text));
                          },
                        ),
                        SizedBox(
                          height: AppSizes.verticalItemSpacing,
                        ),
                        SubmitButton(
                          text: 'Cancel',
                          function: () {
                            Navigator.pop(context);
                          },
                          backgroundColor: Colors.white,
                          textColor: Theme.of(context).primaryColor,
                        ),
                      ])),
            );
          },
        ));
  }
}
