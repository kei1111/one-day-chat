import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/app/home/models/userProfile.dart';
import 'package:himatubu_chat/app/top_level_providers.dart';
import 'package:himatubu_chat/routing/app_router.dart';
import 'package:himatubu_chat/services/firestore_database.dart';
import 'package:pedantic/pedantic.dart';

import '../../../common_widgets/show_alert_dialog.dart';
import '../../../common_widgets/show_exception_alert_dialog.dart';

class EditUserProfilePage extends ConsumerStatefulWidget {
  const EditUserProfilePage({Key? key, this.userProfile}) : super(key: key);
  final UserProfile? userProfile;

  static Future<void> show(BuildContext context,
      {UserProfile? userProfile}) async {
    await Navigator.of(context, rootNavigator: true).pushNamed(
      AppRoutes.editUserProfilePage,
      arguments: userProfile,
    );
  }

  @override
  _EditUserProfilePageState createState() => _EditUserProfilePageState();
}

class _EditUserProfilePageState extends ConsumerState<EditUserProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  int? _ratePerHour;

  @override
  void initState() {
    super.initState();
    if (widget.userProfile != null) {
      _name = widget.userProfile?.name;
      _ratePerHour = widget.userProfile?.ratePerHour;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final database = ref.read<FirestoreDatabase?>(databaseProvider)!;
        final userProfiles = await database.userProfileListStream().first;
        final allLowerCaseNames = userProfiles
            .map((userProfile) => userProfile.name.toLowerCase())
            .toList();
        if (widget.userProfile != null) {
          allLowerCaseNames.remove(widget.userProfile!.name.toLowerCase());
        }
        if (allLowerCaseNames.contains(_name?.toLowerCase())) {
          unawaited(showAlertDialog(
            context: context,
            title: 'Name already used',
            content: 'Please choose a different userProfile name',
            defaultActionText: 'OK',
          ));
        } else {
          final id = widget.userProfile?.id ?? documentIdFromCurrentDate();
          final userProfile = UserProfile(
              id: id, name: _name ?? '', ratePerHour: _ratePerHour ?? 0);
          await database.setUserProfile(userProfile);
          Navigator.of(context).pop();
        }
      } catch (e) {
        unawaited(showExceptionAlertDialog(
          context: context,
          title: 'Operation failed',
          exception: e,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.userProfile == null
            ? 'New UserProfile'
            : 'Edit UserProfile'),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () => _submit(),
          ),
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: const InputDecoration(labelText: 'UserProfile name'),
        keyboardAppearance: Brightness.light,
        initialValue: _name,
        validator: (value) =>
            (value ?? '').isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _name = value,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Rate per hour'),
        keyboardAppearance: Brightness.light,
        initialValue: _ratePerHour != null ? '$_ratePerHour' : null,
        keyboardType: const TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _ratePerHour = int.tryParse(value ?? '') ?? 0,
      ),
    ];
  }
}
