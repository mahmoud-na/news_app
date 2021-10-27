import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child:
          BlocConsumer<CounterCubit, CounterStates>(listener: (context, state) {
        if (state is CounterInitialStates) {
          print('CounterInitialStates');
        }
        if (state is CounterPlusStates) {
          print('CounterPlusStates ${state.counter}');
        }
        if (state is CounterMinusStates) {
          print('CounterMinusStates ${state.counter}');
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    CounterCubit.get(context).plus();
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 50.0,
                  ),
                ),
                const SizedBox(
                  width: 40.0,
                ),
                Text(
                  '${CounterCubit.get(context).counter}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    fontFamily: 'Orbitron-VariableFont_wght',
                  ),
                ),
                const SizedBox(
                  width: 40.0,
                ),
                IconButton(
                  onPressed: () {
                    CounterCubit.get(context).minus();
                  },
                  icon: const Icon(
                    Icons.remove,
                    size: 50.0,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
