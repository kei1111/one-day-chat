import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:himatubu_chat/app/home/hotel_app_theme.dart';
import 'package:himatubu_chat/app/home/popular_filter_list.dart';
import 'package:himatubu_chat/app/home/range_slider_view.dart';
import 'package:himatubu_chat/config/app_styles.dart';

class FilterFilter extends StatefulWidget {
  const FilterFilter({super.key});

  @override
  _FilterFilterState createState() => _FilterFilterState();
}

class _FilterFilterState extends State<FilterFilter> {
  String filterText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Filter Screen")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(
                child: SingleChildScrollView(
                    child: Text(
              "Tap on Icon",
              maxLines: 20,
              style: TextStyle(fontSize: 20, color: Colors.red),
            ))),
          ),
          Center(
            child: MaterialButton(
              onPressed: () async {
                var result = await Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) {
                  return const FiltersScreen();
                }));

                setState(() {
                  filterText =
                      "Filter values selected in Previous Screen\n $result";
                });
                print(result);
              },
              child: const Icon(
                Icons.filter_tilt_shift,
                size: 40,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: SingleChildScrollView(
                      child: Text(
                " \n $filterText",
                maxLines: 20,
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ))),
            )),
          )
        ],
      ),
    );
  }
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<PopularFilterListData> popularFilterListData =
      PopularFilterListData.popularFList;
  List<PopularFilterListData> accomodationListData =
      PopularFilterListData.accomodationList;

  double distValue = 50.0;
  bool isPaid = false;
  bool isFree = false;
  bool isLatest = false;
  bool isOld = false;
  bool isFilter = false;
  String selectedPrefecture = '未設定';
  List<bool> isSelected = [true, false, false];
  String gender = "女性";
  List<String> itemStrings = [
    '未設定',
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
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      color: HotelAppTheme.buildLightTheme().colorScheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const RangeSliderView(),
                    const Divider(
                      height: 1,
                    ),
                    SizedBox(
                      height: 75,
                      child: InputDecorator(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: kInputBorder,
                          enabledBorder: kInputBorder,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                child: Text("場所"),
                              ),
                            ),
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              fixedSize: Size(
                                size.width * 0.1, //50%
                                10,
                              ),
                              alignment: Alignment.topLeft),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _buildDropDownButton(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Text('性別'),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 230, 230, 230),
                              border: Border.all(
                                  color: Colors.grey.shade200, width: 1.0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: ToggleButtons(
                              borderColor: Colors.grey.shade300,
                              fillColor: Colors.white,
                              borderWidth: 2,
                              color: Colors.black,
                              selectedBorderColor: Colors.white,
                              selectedColor: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                              onPressed: (int index) {
                                setState(() {
                                  for (int i = 0; i < isSelected.length; i++) {
                                    isSelected[i] = i == index;
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
                                  padding: EdgeInsets.all(2.0),
                                  child: Text(
                                    '男性',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text(
                                    '女性',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text(
                                    '未設定',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    allAccommodationUI()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropDownButton() {
    return DropdownButton(
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
    );
  }

  Widget allAccommodationUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getAccomodationListUI(),
          ),
        ),
      ],
    );
  }

  List<Widget> getAccomodationListUI() {
    final List<Widget> noList = <Widget>[];
    for (int i = 0; i < accomodationListData.length; i++) {
      final PopularFilterListData date = accomodationListData[i];
      noList.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {
              setState(() {
                checkAppPosition(i);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      date.titleTxt,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  CupertinoSwitch(
                    activeColor: date.isSelected
                        ? HotelAppTheme.buildLightTheme().primaryColor
                        : Colors.grey.withOpacity(0.6),
                    onChanged: (bool value) {
                      setState(() {
                        checkAppPosition(i);
                      });
                    },
                    value: date.isSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (i == 0) {
        noList.add(const Divider(
          height: 1,
        ));
      }
    }
    return noList;
  }

  void checkAppPosition(int index) {
    if (index == 0) {
      if (accomodationListData[0].isSelected) {
        for (var d in accomodationListData) {
          d.isSelected = false;
        }
      } else {
        for (var d in accomodationListData) {
          d.isSelected = true;
        }
      }
    } else {
      accomodationListData[index].isSelected =
          !accomodationListData[index].isSelected;

      int count = 0;
      for (int i = 0; i < accomodationListData.length; i++) {
        if (i != 0) {
          final PopularFilterListData data = accomodationListData[i];
          if (data.isSelected) {
            count += 1;
          }
        }
      }

      if (count == accomodationListData.length - 1) {
        accomodationListData[0].isSelected = true;
      } else {
        accomodationListData[0].isSelected = false;
      }
    }
  }

  List<Widget> getPList() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 2;
    for (int i = 0; i < popularFilterListData.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final PopularFilterListData date = popularFilterListData[count];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      setState(() {
                        date.isSelected = !date.isSelected;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            date.isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: date.isSelected
                                ? HotelAppTheme.buildLightTheme().primaryColor
                                : Colors.grey.withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            date.titleTxt,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
          if (count < popularFilterListData.length - 1) {
            count += 1;
          } else {
            break;
          }
        } catch (e) {
          // print(e);
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().colorScheme.background,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Filters',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    print(accomodationListData.length);
                    Map<String, dynamic> filters = {};
                    filters['isPaid'] =
                        (accomodationListData[0].isSelected) ? 1 : 0;
                    filters['isFree'] = (isFree) ? 1 : 0;
                    filters['Latest'] = (isLatest) ? 1 : 0;
                    filters['Old'] = (isOld) ? 1 : 0;
                    Navigator.pop(context, jsonEncode(filters));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
