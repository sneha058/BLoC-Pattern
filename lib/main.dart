import 'package:InternetConnectivity/InternetBloc/internet_bloc.dart';
import 'package:InternetConnectivity/InternetBloc/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocProvider(
        create: (context) => InternetBloc(),
        child: MaterialApp(
          title: 'Internet Connectivity',
          theme: ThemeData(),
          home: HomePage(),
          debugShowCheckedModeBanner: false,
        ),
      );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("InternetConnectivity"),
        ),
        body: Center(
          child: BlocConsumer<InternetBloc, InternetState>(
            builder: (BuildContext context, state) {
              if (state is InternetGainedState) {
                return Text("Connected!");
              }
              else if (state is InternetLostState) {
                return Text("NotConnected!");
              }
              else {
                return Text("Loading...");
              }
            }, listener: (BuildContext context, InternetState state) {
            if (state is InternetGainedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Internet Connected!"),
                    backgroundColor: Colors.green,));
            }
            else if
              (state is InternetLostState)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Internet NotConnected!"),
                    backgroundColor: Colors.red,));
            }
          },
          ),
        )
    );
  }

}
