import 'package:covid_tracker_app/services/states_services.dart';
import 'package:covid_tracker_app/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> {
  List<Color> colorsList = [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    ServiceApi serviceApi = ServiceApi();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: FutureBuilder(
                future: serviceApi.covidList(),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          chartRadius: 100,
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases.toString()),
                            'Recovered':
                                double.parse(snapshot.data!.deaths.toString()),
                            'Deaths': double.parse(
                                snapshot.data!.recovered.toString()),
                          },
                          colorList: colorsList,
                          animationDuration: const Duration(milliseconds: 1200),
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Card(
                          color: Colors.black45,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 5,
                            ),
                            child: Column(
                              children: [
                                ReUseAble(
                                    title: 'Cases',
                                    value: snapshot.data!.cases.toString()),
                                ReUseAble(
                                    title: 'Deaths',
                                    value: snapshot.data!.deaths.toString()),
                                ReUseAble(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString()),
                                ReUseAble(
                                    title: 'TodayCases',
                                    value:
                                        snapshot.data!.todayCases.toString()),
                                ReUseAble(
                                    title: 'Critical',
                                    value: snapshot.data!.critical.toString()),
                                ReUseAble(
                                    title: 'TodayDeaths',
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                                ReUseAble(
                                    title: 'Population',
                                    value:
                                        snapshot.data!.population.toString()),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const CountriesList();
                            }));
                          },
                          child: Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Align(
                                child: Text(
                              'Track Countries',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                  letterSpacing: 1),
                            )),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ReUseAble extends StatelessWidget {
  String title, value;

  ReUseAble({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  letterSpacing: 1,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  letterSpacing: 1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
