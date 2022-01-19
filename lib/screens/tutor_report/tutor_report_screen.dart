import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/tutor_report/tutor_report_bloc.dart';
import 'package:lettutor_app/constants/colors.dart';
import 'package:lettutor_app/routes.dart';
import 'package:lettutor_app/utils/dialog_utils.dart';

import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/loading_overlay.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorReportScreen extends StatelessWidget {
  final LoadingOverlay _loadingOverlay = new LoadingOverlay();
  final TextEditingController _noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
              DialogUtils.showCustomDialog(context,
                  title: '${AppLocalizations.of(context).success}',
                  content: null,
                  barrierDismissible: false,
                  dialogType: DialogType.success,
                  okBtnText: 'Ok', onOkPressed: () {
                Navigator.pop(
                  context,
                );
                Navigator.pop(
                  context,
                );
              });
            }
            if (state is ReportFailedState) {
              DialogUtils.showCustomDialog(context,
                  title: '${AppLocalizations.of(context).failed}',
                  content: null,
                  barrierDismissible: true,
                  dialogType: DialogType.error,
                  okBtnText: 'Ok', onOkPressed: () {
                Navigator.pop(
                  context,
                );
              });
            }
          },
          builder: (context, state) {
            final tutorBasicInfo =
                context.read<TutorReportBloc>().tutor.tutorBasicInfo;
            return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(15),
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
                          backgroundColor: Colors.red[700],
                          text: 'Submit Report',
                          function: () {
                            context
                                .read<TutorReportBloc>()
                                .add(ReportEvent(_noteController.text));
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SubmitButton(
                          text: 'Cancel',
                          function: () {
                            Navigator.pop(context);
                          },
                          backgroundColor: AppColors.customGrey,
                        ),
                      ])),
            );
          },
        ));
  }
}
