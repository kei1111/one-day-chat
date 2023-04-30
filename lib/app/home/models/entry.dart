import 'package:equatable/equatable.dart';

class Entry extends Equatable {
  const Entry({
    required this.id,
    required this.userProfile,
    required this.start,
    required this.end,
    required this.comment,
  });

  final String id;
  final String userProfile;
  final DateTime start;
  final DateTime end;
  final String comment;

  @override
  List<Object> get props => [id, userProfile, start, end, comment];

  @override
  bool get stringify => true;

  double get durationInHours =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  factory Entry.fromMap(Map<dynamic, dynamic>? value, String id) {
    if (value == null) {
      throw StateError('missing data for entryId: $id');
    }
    final startMilliseconds = value['start'] as int;
    final endMilliseconds = value['end'] as int;
    return Entry(
      id: id,
      userProfile: value['userProfile'] as String,
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
      comment: value['comment'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userProfile': userProfile,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'comment': comment,
    };
  }
}
