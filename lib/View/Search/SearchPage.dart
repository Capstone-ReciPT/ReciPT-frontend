

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:recipt/Server/search/SearchSuggestServer.dart';
import 'package:recipt/View/Search/SearchResult.dart';
import 'package:recipt/Widget/CustomSlider.dart';
import 'package:recipt/Widget/Custom_Text_Form_field.dart';
import 'package:recipt/Widget/Custom_button.dart';
import 'package:recipt/constans/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  static List previousSearchs = [];
  var suggestFoodList;
  var _userInput;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    suggestFoodList = fetchSuggest();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
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
                                setState(() {
                                  _userInput = pure;
                                });
                              },
                              onEditingComplete: () {
                                if (!previousSearchs.contains(searchController.text)){
                                  previousSearchs.add(searchController.text);
                                }
                                // TODO 검색어 입력하고 그 페이지 가는거
                                Get.to(SearchResult(userInput: searchController.text,));
                              },
                            ),
                          ),
                          // IconButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         showModalBottomSheet(
                          //             shape: const RoundedRectangleBorder(
                          //               borderRadius: BorderRadius.vertical(
                          //                 top: Radius.circular(25),
                          //               ),
                          //             ),
                          //             clipBehavior: Clip.antiAliasWithSaveLayer,
                          //             context: context,
                          //             builder: (context) =>
                          //                 _custombottomSheetFilter(context));
                          //       });
                          //     },
                          //     icon: const Icon(
                          //       IconlyBold.filter,
                          //       color: mainText,
                          //     )),
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
                  FutureBuilder<List<SuggestFood>>(
                      future: suggestFoodList,
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
                                  children: [
                                    for (SuggestFood food in snapshot.data!)
                                      searchSuggestionsTiem(food),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return Container(
                            width: 150,
                            height: 80,
                            child: CircleAvatar(
                              backgroundImage: AssetImage("assets/icons/voice2.gif"),
                              radius: 40.0,
                            )
                        );
                      }
                  ),
                  SizedBox(height: 20,),
                  // Search Suggestions
                ],
              ),
            )
          ),
        ));
  }

  previousSearchsItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              InkWell(
                onTap: (){
                  searchController.text = previousSearchs[index];
                },
                child: Text(
                  previousSearchs[index],
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: mainText),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.call_made_outlined,
                color: SecondaryText,
              )
            ],
          ),
      ),
    );
  }

  searchSuggestionsTiem(SuggestFood suggestFood) {
    return InkWell(
      onTap: () {
        setState(() {
          searchController.text = suggestFood.foodName;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 8,bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration:
        BoxDecoration(color: form, borderRadius: BorderRadius.circular(30)),
        child: Text(
          suggestFood.foodName, // 여기를 모르겠어,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: mainText),
        ),
      ),
    );
  }

  _custombottomSheetFilter(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        height: 450,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "필터",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            CustomSlider(DurationName: '조회수',),
            CustomSlider(DurationName: '좋아요 수',),
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
      ),
    );
  }
}