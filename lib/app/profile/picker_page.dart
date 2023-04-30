import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/app/profile/picker_provider.dart';
import 'package:image_picker/image_picker.dart';

class PickerPage extends ConsumerWidget {
  const PickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageFile = ref.watch(pickerPageProvider.select((s) => s.imageFile));
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.black12,
                child: CircleAvatar(
                  radius: 58,
                  backgroundImage: imageFile != null
                      ? Image.file(imageFile, fit: BoxFit.cover).image
                      : const AssetImage('assets/images/core/icon.jpeg'),
                ),
              ),
              RawMaterialButton(
                onPressed: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  await ref.read(pickerPageProvider.notifier).pickImage(image);
                },
                shape: const CircleBorder(),
                elevation: 0,
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            'タップして画像を選択しよう',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
