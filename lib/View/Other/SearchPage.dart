

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:recipt/Server/SearchServer.dart';
import 'package:recipt/Widget/CustomCategoryList.dart';
import 'package:recipt/Widget/CustomSlider.dart';
import 'package:recipt/Widget/Custom_Text_Form_field.dart';
import 'package:recipt/Widget/Custom_button.dart';
import 'package:recipt/constans/colors.dart';
import 'package:recipt/main.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  static List previousSearchs = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                // Search Bar
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: mainText,
                            )),
                        Expanded(
                          child: CustomTextFormField(
                            hint: "검색",
                            prefixIcon: IconlyLight.search,
                            controller: searchController,
                            filled: true,
                            suffixIcon: searchController.text.isEmpty
                                ? null
                                : Icons.cancel_sharp,
                            onTapSuffixIcon: () {
                              searchController.clear();
                            },
                            onChanged: (pure) {
                              setState(() {});
                            },
                            onEditingComplete: () {
                              previousSearchs.add(searchController.text);
                              // TODO 검색어 입력하고 그 페이지 가는거
                              //Get.to(page);
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25),
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    context: context,
                                    builder: (context) =>
                                        _custombottomSheetFilter(context));
                              });
                            },
                            icon: const Icon(
                              IconlyBold.filter,
                              color: mainText,
                            )),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                // Previous Searches
                Container(
                  color: Colors.white,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: previousSearchs.length,
                      itemBuilder: (context, index) => previousSearchsItem(index)),
                ),
                const SizedBox(
                  height: 8,
                ),

                // Search Suggestions
            FutureBuilder<List<String>>(
                future: fetchSuggest(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "추천 검색어",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Wrap(
                            spacing: 8.0, // gap between adjacent chips
                            runSpacing: 4.0, // gap between lines
                            children: snapshot.data!
                                .map<Widget>((name) => searchSuggestionsTiem(name))
                                .toList(),
                          ),
                        ],
                      ),
                    );
                  }
                  else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }
            ),
              ],
            ),
          ),
        ));
  }

  previousSearchsItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {},
        child: Dismissible(
          key: GlobalKey(),
          onDismissed: (DismissDirection dir) {
            setState(() {});
            previousSearchs.removeAt(index);
          },
          child: Row(
            children: [
              const Icon(
                IconlyLight.time_circle,
                color: SecondaryText,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                previousSearchs[index],
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: mainText),
              ),
              const Spacer(),
              const Icon(
                Icons.call_made_outlined,
                color: SecondaryText,
              )
            ],
          ),
        ),
      ),
    );
  }

  searchSuggestionsTiem(String text) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration:
      BoxDecoration(color: form, borderRadius: BorderRadius.circular(30)),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: mainText),
      ),
    );
  }

  _custombottomSheetFilter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 300,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "필터",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          CustomCategoriesList(),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    text: "취소",
                    color: form,
                    textColor: mainText,
                  )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: CustomButton(
                    onTap: () {
                      Get.back();
                    },
                    color: Colors.black,
                    text: "완료",
                  ))
            ],
          )
        ],
      ),
    );
  }
}