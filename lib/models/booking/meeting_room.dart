import '../user/user.dart';

class MeetingRoom {
  String token;
  Context context;
  String room;
  String roomName;
  User userCall;
  User userBeCalled;
  bool isTutor;
  int timeInRoom;
  String bookingId;
  int iat;
  int exp;
  String aud;
  String iss;
  String sub;

  MeetingRoom(
      {this.token,
      this.context,
      this.room,
      this.roomName,
      this.userCall,
      this.userBeCalled,
      this.isTutor,
      this.timeInRoom,
      this.bookingId,
      this.iat,
      this.exp,
      this.aud,
      this.iss,
      this.sub});

  MeetingRoom.fromJson(Map<String, dynamic> json) {
    context =
        json['context'] != null ? new Context.fromJson(json['context']) : null;
    room = json['room'];
    roomName = json['roomName'];
    userCall =
        json['userCall'] != null ? new User.fromJson(json['userCall']) : null;
    userBeCalled = json['userBeCalled'] != null
        ? new User.fromJson(json['userBeCalled'])
        : null;
    isTutor = json['isTutor'];
    timeInRoom = json['timeInRoom'];
    bookingId = json['bookingId'];
    iat = json['iat'];
    exp = json['exp'];
    aud = json['aud'];
    iss = json['iss'];
    sub = json['sub'];
  }
}

class Context {
  User user;

  Context({this.user});

  Context.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}
