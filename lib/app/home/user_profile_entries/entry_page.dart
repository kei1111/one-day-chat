import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/app/home/models/userProfile.dart';
import 'package:himatubu_chat/app/top_level_providers.dart';
import 'package:himatubu_chat/common_widgets/date_time_picker.dart';
import 'package:himatubu_chat/app/home/models/entry.dart';
import 'package:himatubu_chat/routing/app_router.dart';
import 'package:himatubu_chat/services/firestore_database.dart';
import 'package:pedantic/pedantic.dart';

import '../../../common_widgets/show_exception_alert_dialog.dart';
import 'format.dart';

class EntryPage extends ConsumerStatefulWidget {
  const EntryPage({super.key, required this.userProfile, this.entry});
  final UserProfile userProfile;
  final Entry? entry;

  static Future<void> show(
      {required BuildContext context,
      required UserProfile userProfile,
      Entry? entry}) async {
    await Navigator.of(context, rootNavigator: true).pushNamed(
      AppRoutes.entryPage,
      arguments: {
        'userProfile': userProfile,
        'entry': entry,
      },
    );
  }

  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends ConsumerState<EntryPage> {
  late DateTime _startDate;
  late TimeOfDay _startTime;
  late DateTime _endDate;
  late TimeOfDay _endTime;
  late String _comment;

  @override
  void initState() {
    super.initState();
    final start = widget.entry?.start ?? DateTime.now();
    _startDate = DateTime(start.year, start.month, start.day);
    _startTime = TimeOfDay.fromDateTime(start);

    final end = widget.entry?.end ?? DateTime.now();
    _endDate = DateTime(end.year, end.month, end.day);
    _endTime = TimeOfDay.fromDateTime(end);

    _comment = widget.entry?.comment ?? '';
  }

  Entry _entryFromState() {
    final start = DateTime(_startDate.year, _startDate.month, _startDate.day,
        _startTime.hour, _startTime.minute);
    final end = DateTime(_endDate.year, _endDate.month, _endDate.day,
        _endTime.hour, _endTime.minute);
    final id = widget.entry?.id ?? documentIdFromCurrentDate();
    return Entry(
      id: id,
      userProfile: widget.userProfile.id,
      start: start,
      end: end,
      comment: _comment,
    );
  }

  Future<void> _setEntryAndDismiss() async {
    try {
      final database = ref.read<FirestoreDatabase?>(databaseProvider)!;
      final entry = _entryFromState();
      await database.setEntry(entry);
      Navigator.of(context).pop();
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: 'Operation failed',
        exception: e,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.userProfile.name),
        actions: <Widget>[
          TextButton(
            child: Text(
              widget.entry != null ? 'Update' : 'Create',
              style: const TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: () => _setEntryAndDismiss(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildStartDate(),
              _buildEndDate(),
              const SizedBox(height: 8.0),
              _buildDuration(),
              const SizedBox(height: 8.0),
              _buildComment(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStartDate() {
    return DateTimePicker(
      labelText: 'Start',
      selectedDate: _startDate,
      selectedTime: _startTime,
      onSelectedDate: (date) => setState(() => _startDate = date),
      onSelectedTime: (time) => setState(() => _startTime = time),
    );
  }

  Widget _buildEndDate() {
    return DateTimePicker(
      labelText: 'End',
      selectedDate: _endDate,
      selectedTime: _endTime,
      onSelectedDate: (date) => setState(() => _endDate = date),
      onSelectedTime: (time) => setState(() => _endTime = time),
    );
  }

  Widget _buildDuration() {
    final currentEntry = _entryFromState();
    final durationFormatted = Format.hours(currentEntry.durationInHours);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Duration: $durationFormatted',
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildComment() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 50,
      controller: TextEditingController(text: _comment),
      decoration: const InputDecoration(
        labelText: 'Comment',
        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      keyboardAppearance: Brightness.light,
      style: const TextStyle(fontSize: 20.0, color: Colors.black),
      maxLines: null,
      onChanged: (comment) => _comment = comment,
    );
  }
}
