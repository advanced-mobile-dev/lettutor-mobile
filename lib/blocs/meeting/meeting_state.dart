part of 'meeting_bloc.dart';

enum MeetingRemoveStatus { initial, loading, success, failure }

class MeetingState extends Equatable {
  final Booking booking;
  final MeetingRemoveStatus removeStatus;

  MeetingState copyWith({Booking booking, MeetingRemoveStatus removeStatus}) {
    return MeetingState(
        booking: booking ?? this.booking,
        removeStatus: removeStatus ?? this.removeStatus);
  }

  MeetingState({this.booking, this.removeStatus = MeetingRemoveStatus.initial});

  @override
  List<Object> get props => [booking, removeStatus];
}

// class MeetingRemovedState extends MeetingState {
//   MeetingRemovedState(Booking booking) : super(booking);
// }

// class MeetingRemovingState extends MeetingState {
//   MeetingRemovingState(Booking booking) : super(booking);
// }

// class MeetingRemoveFailed extends MeetingState {
//   final String errorMessage;
//   MeetingRemoveFailed(Booking booking, {this.errorMessage = 'Failed'})
//       : super(booking);
// }
