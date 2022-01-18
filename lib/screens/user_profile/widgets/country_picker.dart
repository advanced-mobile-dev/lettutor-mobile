import 'package:flutter/material.dart';
import 'package:lettutor_app/constants/config.dart';
import 'package:lettutor_app/models/config/country.dart';

class CountryPicker extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query == null) {
      return Center(
        child: Text(
          'Enter your country',
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView(
        children: AppConfig.countries
            .where((element) => element.name.contains(query))
            .map((e) => CountryItem(
                  country: e,
                ))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
        children: AppConfig.countries
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .map(
              (e) => CountryItem(
                country: e,
              ),
            )
            .toList());
  }
}

class CountryItem extends StatelessWidget {
  final Country country;
  const CountryItem({Key key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, country.code);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Image.asset(
              'assets/national_flags/${country.code.toLowerCase()}.png',
              height: 15,
              width: 30,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              country.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ))
          ],
        ),
      ),
    );
  }
}
