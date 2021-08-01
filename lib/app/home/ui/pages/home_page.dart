import 'dart:async';

import 'package:desafio_mobile/app/common/widgets/custom_progress_indicator.dart';
import 'package:desafio_mobile/app/home/ui/controller/home_controller.dart';
import 'package:desafio_mobile/core/common/injected/module.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = getIt.get<HomeController>();

  Completer<GoogleMapController> _controller = Completer();
  _getMarkers(LatLng location) {
    return <Marker>{
      Marker(
        markerId: MarkerId("marker0"),
        position: location,
      ),
    };
  }

  late final LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  _fetchCurrentLocation() async {
    _currentLocation = await controller.getCurrentLocation();
    controller.saveUserInfoInDb(_currentLocation);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Observer(
            builder: (_) => _buildBody(),
          ),
        ),
      );

  Widget _buildBody() {
    if (controller.isLoading) {
      return _buildProgressIndicator();
    }

    final CameraPosition _currentPosition = CameraPosition(
      target: _currentLocation,
      zoom: 16,
    );

    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: _currentPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: _getMarkers(_currentLocation),
    );
  }

  Widget _buildProgressIndicator() => buildProgressIndicator(
        containerHeight: MediaQuery.of(
              context,
            ).size.height /
            2,
      );
}
