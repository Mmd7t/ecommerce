import 'package:flutter/material.dart';
import 'package:ecommerce/frontend/widgets/gradient_widget.dart';

class Search extends StatefulWidget {
  static final String routeName = 'search';

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController;
  List filteredList;
  @override
  void initState() {
    searchController = TextEditingController();
    filteredList = data;
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 100),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                GradientWidget(
                  child: IconButton(
                    splashRadius: 20,
                    splashColor: Theme.of(context).accentColor,
                    icon: Icon(Icons.arrow_back_ios_rounded),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: searchController,
                      cursorColor: Theme.of(context).accentColor,
                      decoration: InputDecoration(
                        hintText: 'search',
                        prefixIcon: GradientWidget(
                          child: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
                GradientWidget(
                  child: IconButton(
                    splashRadius: 20,
                    splashColor: Theme.of(context).accentColor,
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(data[index]),
            ),
          );
        },
      ),
    );
  }
}

List data = [
  'Medhat',
  'Mostafa',
  'Atya',
  'Sarah',
  'Ibrahim',
  'Manar',
  'Mohammed',
  'Aml',
  'Mohsen',
  'Mourad',
  'zannouba',
  'firial',
  'hero',
  'kiro',
];
