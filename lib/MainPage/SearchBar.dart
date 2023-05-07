import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Controller/SearchController.dart';
import 'package:search_page/search_page.dart';

class SearchButton extends StatelessWidget {
  SearchButton({Key? key}) : super(key: key);
  final SearchListController searchController = Get.put(SearchListController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      margin: EdgeInsets.only(top: 10,right: 5),
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.black45)
                )
            )
        ),
        child: Container(
            padding: EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            child: Text('요리, 재료 검색',style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w700,fontSize: 15),)
        ),
        onPressed: (){
          showSearch(
            context: context,
            delegate: SearchPage(
              barTheme: ThemeData(
                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.orangeAccent,
                )
              ),
              onQueryUpdate: print,
              items: searchController.people,
              searchLabel: '요리 및 레시피 검색',
              suggestion: const Center(
                  child: Text(' ')
              ),
              failure: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('없는 레시피 입니다. GPT에게 물어보세요!'),
                    IconButton(onPressed: (){}, icon: Icon(Icons.ac_unit_outlined))
                  ],
                ),
              ),
              filter: (person) => [
                person.name,
                person.surname,
                person.age.toString(),
              ],
              sort: (a, b) => a.compareTo(b),
              builder: (person) => ListTile(
                title: Text(person.name),
                subtitle: Text(person.surname),
                trailing: Text('${person.age} yo'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class VoiceSearchButton extends StatelessWidget {
  const VoiceSearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      alignment: Alignment.center,
      child: IconButton(
          icon: Icon(Icons.keyboard_voice,color: Colors.black,size: 35),
          onPressed: () {
            // TODO 검색 기능 구현
            print('search button is clicked');
          }
      ),
    );
  }
}


//
// class PopularAgeGroup extends StatelessWidget {
//   const PopularAgeGroup({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: 25,right: 30),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   Text('검색어 추천',style: TextStyle(fontWeight: FontWeight.w600)),
//                   Text('20대 남성 기준',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey),)
//                 ],
//               ),
//               Icon(Icons.star_rate,size: 40,),
//             ],
//           ),
//           SizedBox(height: 20,),
//           Column(
//             children: List.generate(5, (index) {
//               return Row(
//                 children: [
//                   Text('${index + 1}\t초밥',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
//                   SizedBox(width: 100,),
//                   Text('${index + 6}\t초밥',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
//                 ],
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
