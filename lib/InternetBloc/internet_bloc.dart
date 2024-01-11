import 'dart:async';
import 'package:InternetConnectivity/InternetBloc/internet_event.dart';
import 'package:InternetConnectivity/InternetBloc/internet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState>{

  Connectivity _connectivity = Connectivity();    //Initializing Connectivity
  StreamSubscription? connectivitySubscription;

  InternetBloc(): super(InternetInitialState()){     //Initializing the bloc, while doing so we have to provide the InitialState parameter inside super
   on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
   on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

   connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
     if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
       add(InternetGainedEvent());
     }
     else{
       add(InternetLostEvent());
     }
   });
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }

}