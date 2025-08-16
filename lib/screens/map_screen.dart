import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/firestore_service.dart';
import '../services/location_service.dart';
import '../models/ev_station.dart';
import 'profile_bottom_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _myPos;

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    try {
      final pos = await LocationService.currentPosition();
      setState(() => _myPos = LatLng(pos.latitude, pos.longitude));
    } catch (e) {
      // fallback to Chennai
      setState(() => _myPos = const LatLng(13.0827, 80.2707));
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = context.read<FirestoreService>();
    return StreamBuilder<List<EVStation>>(
      stream: service.streamStations(),
      builder: (context, snapshot) {
        final stations = snapshot.data ?? [];
        final markers = stations.map((s) {
          return Marker(
            markerId: MarkerId(s.id),
            position: LatLng(s.lat, s.lng),
            infoWindow: InfoWindow(title: s.name, snippet: s.address),
            onTap: () {
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                builder: (_) => ProfileBottomSheet(station: s),
              );
            },
          );
        }).toSet();

        final initial = _myPos ?? const LatLng(13.0827, 80.2707);
        return Scaffold(
          appBar: AppBar(title: const Text('EV Stations')),
          body: GoogleMap(
            initialCameraPosition: CameraPosition(target: initial, zoom: 12),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: markers,
            onMapCreated: (c) => _controller.complete(c),
          ),
        );
      },
    );
  }
}
