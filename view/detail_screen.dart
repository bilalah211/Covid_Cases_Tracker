import 'package:covid_tracker_app/view/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int cases, deaths, todayCases, recovered, critical;

  DetailScreen({super.key,
    required this.name,
    required this.image,
    required this.cases,
    required this.deaths,
    required this.todayCases,
    required this.recovered,
    required this.critical,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(widget.name,style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067,left: 15,right: 15),
                child: Card(
                  color: Colors.black45,
                  child: Column(
                    children: [
                      ReUseAble(
                          title: 'Cases',
                          value: widget.cases.toString()),
                      ReUseAble(
                          title: 'Deaths',
                          value: widget.deaths.toString()),
                      ReUseAble(
                          title: 'TodayCases',
                          value: widget.todayCases.toString()),
                      ReUseAble(
                          title: 'Critical',
                          value: widget.critical.toString()),
                      ReUseAble(
                          title: 'Recovered',
                          value: widget.recovered.toString()),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
