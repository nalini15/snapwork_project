import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapwork/functions/widgetFunc.dart';
import 'package:snapwork/models/events.dart';
import 'package:snapwork/navigator/navigation.dart';
import 'package:snapwork/provider/handler.dart';
import 'package:snapwork/screens/details/details.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void modalBottomSheetMenu(bool isYear, Handler handler) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        elevation: 5,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        context: context,
        builder: (builder) {
          return Container(
            height: buildHeight(context) * 0.70,
            color: Colors.transparent,
            child: ListView.builder(
                itemCount: isYear
                    ? handler.getYears().length
                    : handler.getMonth().length,
                itemBuilder: (con, i) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          handler.setYearOrMonth(
                              isYear
                                  ? handler.getYears()[i]
                                  : handler.getMonth()[i]["month"],
                              isYear);
                          if (handler.month != null) {
                            handler.getDatesForMonth(DateTime.parse(
                                "${handler.getYears()[i]}-${handler.getMonth()[i]['mon']}-20T03:17:00.000000Z"));
                          }
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(color: Colors.grey, width: 1),
                            )),
                            alignment: Alignment.center,
                            child: Text(
                              isYear
                                  ? "${handler.getYears()[i]}"
                                  : "${handler.getMonth()[i]["month"]}",
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ],
                  );
                }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Events"),
      body: SafeArea(
          child: Consumer<Handler>(
        builder: (con, handler, _) => Column(
          children: [
            buildSizedBoxHeight(10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            modalBottomSheetMenu(true, handler);
                          },
                          child: Text("${handler.year ?? "Select year"}"))),
                  buildSizedBoxWidth(10),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            if (handler.year != null) {
                              modalBottomSheetMenu(false, handler);
                            }
                          },
                          child: Text("${handler.month ?? "Select Month"}"))),
                ],
              ),
            ),
            buildSizedBoxHeight(10),
            Expanded(
              child: handler.getEvents.isEmpty
                  ? Center(
                      child: Text("Select Dates"),
                    )
                  : ListView.builder(
                      itemCount: handler.getEvents.length,
                      itemBuilder: (con, i) {
                        var data = handler.getEvents[i];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(FadeNavigation(
                                widget: DetailScreen(
                              events: data,
                              index: i,
                            )));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                        right: BorderSide(
                                            color: Colors.grey, width: 1),
                                      )),
                                      child: Column(
                                        children: [
                                          Text("${i + 1}"),
                                          Text("${handler.month}"),
                                        ],
                                      ),
                                    ),
                                    buildSizedBoxWidth(5),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "${data.timeOfEvent} ${data.dateOfEvent}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text("${data.title}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                      ],
                                    ))
                                  ],
                                ),
                                Divider()
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      )),
    );
  }
}
