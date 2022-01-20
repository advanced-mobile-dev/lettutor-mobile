import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:lettutor_app/models/booking/booking.dart';
import 'package:lettutor_app/models/booking/meeting_room.dart';
import 'package:lettutor_app/repositories/user_repository.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final UserRepository _userRepository;
  MeetingBloc({UserRepository userRepository, Booking booking})
      : _userRepository = userRepository,
        super(MeetingState(booking: booking)) {
    on<StartMeetingEvent>(_onStartMeeting);
    on<CancelMeetingEvent>(_onCancelMeeting);

    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  Future _onCancelMeeting(CancelMeetingEvent event, emit) async {
    try {
      emit(state.copyWith(removeStatus: MeetingRemoveStatus.loading));
      final bool result =
          await _userRepository.cancelMeeting(state.booking.scheduleDetail.id);
      if (result) {
        emit(state.copyWith(removeStatus: MeetingRemoveStatus.success));
      } else {
        emit(state.copyWith(removeStatus: MeetingRemoveStatus.failure));
      }
    } catch (err) {
      emit(state.copyWith(removeStatus: MeetingRemoveStatus.failure));
    }
  }

  Future _onStartMeeting(StartMeetingEvent event, emit) async {
    await _joinMeeting(state.booking.bookingInfo.meetingRoom);
  }

  Future<void> _joinMeeting(MeetingRoom meetingRoom) async {
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: true,
    };
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
        featureFlags[FeatureFlagEnum.IOS_RECORDING_ENABLED] = false;
      }
    }
    featureFlags[FeatureFlagEnum.ADD_PEOPLE_ENABLED] = false;
    featureFlags[FeatureFlagEnum.LIVE_STREAMING_ENABLED] = false;
    featureFlags[FeatureFlagEnum.MEETING_PASSWORD_ENABLED] = false;
    featureFlags[FeatureFlagEnum.CALENDAR_ENABLED] = false;
    featureFlags[FeatureFlagEnum.INVITE_ENABLED] = false;

    String serverUrl = 'https://meet.lettutor.com';
    var options = JitsiMeetingOptions(room: '${meetingRoom.room}')
      ..serverURL = serverUrl
      ..token = '${meetingRoom.token}'
      ..subject = meetingRoom.roomName
      ..userDisplayName = meetingRoom.userCall.name
      ..userAvatarURL = meetingRoom.userCall.avatar
      ..userEmail = meetingRoom.userCall.email
      ..audioOnly = false
      ..audioMuted = true
      ..videoMuted = true
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": meetingRoom.roomName,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": meetingRoom.userCall.name}
      };

    await JitsiMeet.joinMeeting(options,
        listener: JitsiMeetingListener(onConferenceWillJoin: (message) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: (message) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: (message) {
          debugPrint("${options.room} terminated with message: $message");
        }, onPictureInPictureWillEnter: (message) {
          debugPrint("${options.room} entered PIP mode with message: $message");
        }, onPictureInPictureTerminated: (message) {
          debugPrint("${options.room} exited PIP mode with message: $message");
        }));
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted with message: $error");
  }

  @override
  Future<void> close() async {
    JitsiMeet.removeAllListeners();
    super.close();
  }
}
