import 'package:bloc/bloc.dart';

// ignore: unused_import
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(counterValue: 0));

  void increment() => emit(CounterState(
        counterValue: state.counterValue + 1,
        wasIncremented: true,
      ));

  void reset() => emit(CounterState(counterValue: state.counterValue = 0));

  void decrement() => emit(CounterState(counterValue: state.counterValue - 1));
}
