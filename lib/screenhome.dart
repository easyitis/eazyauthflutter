import 'package:flutter/material.dart';
import 'shared.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                  right: 8.0,
                ),
                child: Text(
                  "EazyAuth",
                  style: Theme.of(context).textTheme.headline3.apply(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: Text(
                  "Easy 2 Factor Authentication",
                  style: Theme.of(context).textTheme.headline6.apply(
                        color: Theme.of(context).primaryColor,
                        fontWeightDelta: 2,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 20.0,
                ),
                child: Text(
                  "By Easy IT Is",
                  style: Theme.of(context).textTheme.subtitle1.apply(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/userhandler', arguments: null)
                      .then((value) {
                    setState(() {});
                  });
                },
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Try it - fully working example",
                          style: Theme.of(context).textTheme.headline6.apply(
                                color: Theme.of(context).primaryColor,
                                fontWeightDelta: 1,
                              ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8),
                          child: Icon(
                            ((userId ?? 0) > 0)
                                ? Icons.person
                                : Icons.person_outline,
                            color: Theme.of(context).primaryColor,
                            size: 30.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        Text(((userId ?? 0) > 0)
                            ? "$userEmail"
                            : "Tap to log in"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
