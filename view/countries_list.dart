import 'package:covid_tracker_app/model/CovidModel.dart';
import 'package:covid_tracker_app/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'detail_screen.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ServiceApi serviceApi = ServiceApi();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search Country Here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: serviceApi.countriesList(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                      height: 10,
                                      width: 80,
                                      color: Colors.black45),
                                  subtitle: Container(
                                      height: 10,
                                      width: 80,
                                      color: Colors.black45),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return DetailScreen(
                                        name: snapshot.data![index]['country']
                                            .toString(),
                                        image: snapshot.data![index]
                                                ['countryInfo']['flag']
                                            .toString(),
                                        cases: snapshot.data![index]['cases'],
                                        deaths: snapshot.data![index]
                                            ['recovered'],
                                        todayCases: snapshot.data![index]
                                            ['critical'],
                                        recovered: snapshot.data![index]
                                            ['deaths'],
                                        critical: snapshot.data![index]
                                            ['todayCases'],
                                      );
                                    }));
                                  },
                                  child: ListTile(
                                    leading: Image(
                                      height: 60,
                                      width: 60,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                    ),
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                  ),
                                ),
                              ],
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return DetailScreen(
                                        name: snapshot.data![index]['country']
                                            .toString(),
                                        image: snapshot.data![index]
                                                ['countryInfo']['flag']
                                            .toString(),
                                        cases: snapshot.data![index]['cases'],
                                        deaths: snapshot.data![index]
                                            ['recovered'],
                                        todayCases: snapshot.data![index]
                                            ['critical'],
                                        recovered: snapshot.data![index]
                                            ['deaths'],
                                        critical: snapshot.data![index]
                                            ['todayCases'],
                                      );
                                    }));
                                  },
                                  child: ListTile(
                                    leading: Image(
                                      height: 60,
                                      width: 60,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                    ),
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            Container();
                          }
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
