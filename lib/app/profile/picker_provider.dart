import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'picker_provider.freezed.dart';

@freezed
class PickerPageState with _$PickerPageState {
  const factory PickerPageState({
    File? imageFile,
  }) = _PickerPageState;
}

final pickerPageProvider =
    StateNotifierProvider.autoDispose<PickerPageController, PickerPageState>(
        (ref) {
  return PickerPageController();
});

class PickerPageController extends StateNotifier<PickerPageState> {
  PickerPageController() : super(const PickerPageState());

  Future<void> pickImage(XFile? image) async {
    if (image == null) return;
    state = state.copyWith(imageFile: File(image.path));
  }
}
