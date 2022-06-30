import 'dart:async';
import 'package:desafio_mobile/src/domain/entities/location.dart';
import 'package:desafio_mobile/src/presentation/bloc/home/database/database_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/user.dart';
import '../bloc/home/database/database_bloc.dart';
import '../bloc/home/database/database_state.dart';
import '../bloc/home/position/position_bloc.dart';
import '../bloc/home/position/position_event.dart';
import '../bloc/home/position/position_state.dart';

class HomePage extends StatefulWidget {
  final User user;
  final LatLng? position;
  const HomePage({Key? key, required this.user, this.position}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isErrorDisplay = false;
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = <Marker>{};
  LatLng intPosition = const LatLng(-2.9068567, -41.7904943);

  void _onMapController(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> _goToTheLake(LatLng? position) async {
    if (position != null) {
      intPosition = LatLng(position.latitude, position.latitude);
    }

    Marker marker = Marker(
      markerId: const MarkerId('123'),
      position: intPosition,
      infoWindow: const InfoWindow(
        title: 'Sua Localicação',
        snippet: 'Desafio ByCoders',
      ),
    );

    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newLatLng(intPosition));

    setState(() {
      markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    var positionbloc = context.read<PositionBloc>();
    var databasebloc = context.read<DatabaseBloc>();
    return BlocListener<PositionBloc, PositionState>(
      listenWhen: (_, __) => !isErrorDisplay,
      listener: (context, state) {
        if (state is PositionFinishedState) {
          _goToTheLake(state.position!);

          var location = Location(
            latitude: intPosition.latitude,
            longitude: intPosition.longitude,
            user: widget.user,
          );
          databasebloc.add(AddLocation(location));
        }
      },
      bloc: positionbloc,
      child: BlocBuilder<DatabaseBloc, DatabaseState>(
          bloc: databasebloc,
          builder: (context, state) {
            if (state is FeatchDatabaseFinishedState) {
              var positionBank = LatLng(
                state.location!.latitude,
                state.location!.longitude,
              );
              _goToTheLake(positionBank);
              databasebloc.add(DatabaseInitial());
            }
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Bem vindo a Map'),
                leading: Container(),
                actions: [
                  IconButton(
                    onPressed: () {
                      databasebloc.add(FeatchLocation(widget.user.uid));
                    },
                    tooltip: 'Localização no Ultimo Login',
                    icon: const Icon(Icons.mode_of_travel_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      positionbloc.add(RequestPosition());
                    },
                    tooltip: 'Localização Atual',
                    icon: const Icon(Icons.my_location_outlined),
                  ),
                ],
              ),
              body: GoogleMap(
                onMapCreated: _onMapController,
                markers: markers,
                initialCameraPosition: CameraPosition(
                  target: intPosition,
                  zoom: 11.0,
                ),
              ),
            );
          }),
    );
  }
}
