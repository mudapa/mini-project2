part of 'package:mini_project_team_7/routes/routes.dart';

class MiniMap extends StatelessWidget {
  final LatLng center;
  final double zoom;

  const MiniMap({super.key, required this.center, this.zoom = 18});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.maxFinite,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: center,
          zoom: zoom,
        ),
        mapType: MapType.normal,
        markers: {
          Marker(
            markerId: const MarkerId('center'),
            position: center,
          ),
        },
      ),
    );
  }
}
