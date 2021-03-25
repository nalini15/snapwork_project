import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapwork/functions/widgetFunc.dart';
import 'package:snapwork/models/events.dart';
import 'package:snapwork/provider/handler.dart';

class DetailScreen extends StatefulWidget {
  final EventsDates events;
  final int index;

  DetailScreen({Key key, this.events, this.index}) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<void> openTimePicker(Handler handler) async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 7, minute: 15),
    );
    handler.setFormData({
      "time": "${newTime.hour}:${newTime.minute}",
      "date": "${widget.events.date}",
      "title": "",
      "descp": ""
    });
  }

  Future<void> submitData(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      final handler = Provider.of<Handler>(context, listen: false);
      if (handler.formData["time"] == null) {
        showSnack(context, "Please select time", _scaffoldkey);
      } else {
        _formKey.currentState.save();
        handler.updateEvents(widget.index);
        showSnack(context, "Event updated!", _scaffoldkey);

        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop();
          handler.clearForm();
        });
      }
    } else {
      return;
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      bottomSheet: Container(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            submitData(context);
          },
          child: Text("SAVE"),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Event Detail',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<Handler>(
            builder: (con, handler, _) => Column(
              children: [
                buildSizedBoxMedia(buildHeight(context), 0.05),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        'Date & Time',
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: () {
                                  openTimePicker(handler);
                                },
                                child: Text(
                                  '${handler.formData['time'] ?? "HH:MM"}',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  '${widget.events.date}',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                buildSizedBoxMedia(buildHeight(context), 0.05),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Text(
                              'Title',
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: TextFormField(
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(12.0),
                                    labelStyle: new TextStyle(
                                        color: const Color(0xFF424242)),
                                  ),
                                  validator: (val) {
                                    if (val.trimLeft().trimRight().isEmpty) {
                                      return "Please enter title";
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    handler.formData["title"] =
                                        val.trimLeft().trimRight();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      buildSizedBoxMedia(buildHeight(context), 0.05),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Description',
                          ),
                        ),
                      ),
                      buildSizedBoxMedia(buildHeight(context), 0.03),
                      Container(
                        color: Colors.grey[200],
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          maxLines: 5,
                          autocorrect: true,
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(15.0),
                            labelStyle:
                                new TextStyle(color: const Color(0xFF424242)),
                          ),
                          validator: (val) {
                            if (val.trimLeft().trimRight().isEmpty) {
                              return "Please enter description";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            handler.formData["descp"] =
                                val.trimLeft().trimRight();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
