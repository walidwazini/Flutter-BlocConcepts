import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/counter_cubit.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: AboutListener(),
      ),
    );
  }
}

class AboutListener extends StatefulWidget {
  const AboutListener({Key? key}) : super(key: key);

  @override
  _AboutListenerState createState() => _AboutListenerState();
}

class _AboutListenerState extends State<AboutListener> {
  TextStyle style2 = TextStyle(fontSize: 25, color: Colors.black);

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> toggleSnackBar(
     BuildContext ctx, String text, Color indicator) {
    return Scaffold.of(ctx).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(milliseconds: 400),
        backgroundColor: indicator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Listener'),
      ),
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.wasIncremented == true) {
            toggleSnackBar(context,'Incremented', Colors.green);
          } else {
           toggleSnackBar(context, 'Decremented', Colors.red);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: style2,
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                    },
                    //tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).reset();
                    },
                    //tooltip: 'Increment',
                    child: Icon(Icons.accessibility),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    //tooltip: 'Increment',
                    child: Icon(Icons.add),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
