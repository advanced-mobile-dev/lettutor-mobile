import 'package:flutter/material.dart';

class TutorsTab extends StatelessWidget {
  final titleStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 36);
  final textStyle = TextStyle(color: Colors.black, fontSize: 12);
  final specialities = [
    'All',
    'English for kids',
    'English for business',
    'Conversational',
    'STATERS',
    'MOVERS',
    'FLYERS',
    'KET',
    'PET',
    'TOEFT',
    'TOEIC'
  ];
  final countries = ['All', 'Viet nam', 'Singapore'];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text('Tutors', style: titleStyle),
          ),
          Container(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'Search by name...',
                      hintStyle: TextStyle(fontSize: 14)),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Specialities', style: textStyle),
                            DropdownButton<String>(
                                items: ['one', 'two', 'three']
                                    .map((e) => DropdownMenuItem<String>(
                                        child: Text(e)))
                                    .toList())
                          ]),
                      flex: 1,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text('Countries', style: textStyle),
                        ],
                      ),
                      flex: 1,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
