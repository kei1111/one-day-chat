import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himatubu_chat/app/auth/auth_provider.dart';
import 'package:himatubu_chat/app/profile/picker_page.dart';
import 'package:himatubu_chat/app/profile/picker_provider.dart';
import 'package:himatubu_chat/common_widgets/my_text_button.dart';
import 'package:himatubu_chat/common_widgets/validators.dart';
import 'package:himatubu_chat/config/app_styles.dart';

import '../../common_widgets/my_text_form_field.dart';

class SignInAccountPage extends StatefulWidget {
  const SignInAccountPage({Key? key}) : super(key: key);

  @override
  _SignInAccountPageState createState() => _SignInAccountPageState();
}

class _SignInAccountPageState extends State<SignInAccountPage> {
  final _loginKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _place = TextEditingController();
  final _birthdate = TextEditingController();
  var targetday = DateTime(2004, DateTime.now().month, DateTime.now().day);
  var now = DateTime.now();
  int age = 0;
  List<bool> isSelected = [true, false];
  String gender = "女性";
  List<String> itemStrings = [
    '',
    '北海道',
    '青森県',
    '岩手県',
    '宮城県',
    '秋田県',
    '山形県',
    '福島県',
    '茨城県',
    '栃木県',
    '群馬県',
    '埼玉県',
    '千葉県',
    '東京都',
    '神奈川県',
    '新潟県',
    '富山県',
    '石川県',
    '福井県',
    '山梨県',
    '長野県',
    '岐阜県',
    '静岡県',
    '愛知県',
    '三重県',
    '滋賀県',
    '京都府',
    '大阪府',
    '兵庫県',
    '奈良県',
    '和歌山県',
    '鳥取県',
    '島根県',
    '岡山県',
    '広島県',
    '山口県',
    '徳島県',
    '香川県',
    '愛媛県',
    '高知県',
    '福岡県',
    '佐賀県',
    '長崎県',
    '熊本県',
    '大分県',
    '宮崎県',
    '鹿児島県',
    '沖縄県'
  ];

  String selectedPrefecture = '';

  @override
  void initState() {
    super.initState();
  }

  final List<FocusNode> _loginFocusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  bool _isLoading = false;

  void loading() {
    _isLoading = !_isLoading;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
          bottom: 12,
          child: SizedBox(
            child: Image.asset('assets/images/auth/login_bg.png'),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            'チャットアプリ\n安全！24時間限定',
                            style: kTitle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Text(
                                    'アカウント作成',
                                    style: kBodyText3,
                                  ),
                                  Divider(
                                    height: 20,
                                    color: kPrimaryColor.withOpacity(0.5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Consumer(builder: (context, ref, _) {
                                      return Form(
                                        key: _loginKey,
                                        child: Column(
                                          children: [
                                            const PickerPage(),
                                            Container(
                                              padding: EdgeInsets.zero,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 230, 230, 230),
                                                border: Border.all(
                                                    color: Colors.grey.shade500,
                                                    width: 1.0),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(2.0)),
                                              ),
                                              child: ToggleButtons(
                                                borderColor:
                                                    Colors.grey.shade200,
                                                fillColor: Colors.white,
                                                borderWidth: 2,
                                                color: Colors.black,
                                                selectedBorderColor:
                                                    Colors.white,
                                                selectedColor: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                onPressed: (int index) {
                                                  setState(() {
                                                    for (int i = 0;
                                                        i < isSelected.length;
                                                        i++) {
                                                      isSelected[i] =
                                                          i == index;
                                                    }
                                                    if (isSelected[0] == true) {
                                                      gender = "女性";
                                                    } else {
                                                      gender = "男性";
                                                    }
                                                  });
                                                },
                                                isSelected: isSelected,
                                                children: const <Widget>[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      '女性',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      '男性',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            MyTextFormField(
                                              controller: _name,
                                              hint: "",
                                              labelText: "名前",
                                              fillColor: kScaffoldBackground,
                                              inputType:
                                                  TextInputType.emailAddress,
                                              inputAction: TextInputAction.next,
                                              focusNode: _loginFocusNodes[0],
                                              validator: nameValidator,
                                            ),
                                            SizedBox(
                                              height: 75,
                                              child: InputDecorator(
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor:
                                                      kScaffoldBackground,
                                                  border: kInputBorder,
                                                  enabledBorder: kInputBorder,
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0),
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          right: BorderSide(
                                                            width: 2,
                                                            color:
                                                                kScaffoldBackground,
                                                          ),
                                                        ),
                                                      ),
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 16,
                                                                vertical: 14),
                                                        child: Text("場所"),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                      fixedSize: Size(
                                                        size.width * 0.1,
                                                        10,
                                                      ),
                                                      alignment:
                                                          Alignment.topLeft),
                                                  onPressed: () {},
                                                  child: _buildDropDownButton(),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              height: 70,
                                              child: InputDecorator(
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor:
                                                      kScaffoldBackground,
                                                  border: kInputBorder,
                                                  enabledBorder: kInputBorder,
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0),
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          right: BorderSide(
                                                            width: 2,
                                                            color:
                                                                kScaffoldBackground,
                                                          ),
                                                        ),
                                                      ),
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 16,
                                                                vertical: 14),
                                                        child: Text("生年月日"),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                      fixedSize: Size(
                                                        size.width * 0.1,
                                                        10,
                                                      ),
                                                      alignment:
                                                          Alignment.topLeft),
                                                  onPressed: () {
                                                    DatePicker.showDatePicker(
                                                        context,
                                                        showTitleActions: true,
                                                        minTime: DateTime(
                                                            1960, 1, 1),
                                                        maxTime: DateTime(
                                                            DateTime.now()
                                                                    .year -
                                                                18,
                                                            12,
                                                            31),
                                                        onConfirm: (date) {
                                                      setState(() {
                                                        targetday = date;
                                                        final ageCaluc =
                                                            AgeCalculator.age(
                                                                date);
                                                        age = ageCaluc.years;
                                                      });
                                                    },
                                                        currentTime: targetday,
                                                        locale: LocaleType.jp);
                                                  },
                                                  child: Text(
                                                      "${targetday.year}-${targetday.month}-${targetday.day}"),
                                                ),
                                              ),
                                            ),
                                            MyTextButton(
                                              buttonName: '作成する',
                                              onPressed: () {
                                                _loginKey.currentState!
                                                    .validate();

                                                ref
                                                    .watch(
                                                        authProvider.notifier)
                                                    .registerAccount(
                                                        username: _name.text,
                                                        place:
                                                            selectedPrefecture,
                                                        age: age,
                                                        gender: gender,
                                                        profilePageFile: ref
                                                            .read(
                                                                pickerPageProvider)
                                                            .imageFile);
                                              },
                                              bgColor: kPrimaryColor,
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropDownButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: DropdownButton(
        value: selectedPrefecture,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 30,
        elevation: 16,
        underline: Container(
          height: 0,
        ),
        onChanged: (value) {
          setState(() {
            selectedPrefecture = value.toString();
          });
        },
        items: itemStrings.map((String itemString) {
          return DropdownMenuItem(
            value: itemString,
            child: Text(
              itemString,
            ),
          );
        }).toList(),
      ),
    );
  }
}
