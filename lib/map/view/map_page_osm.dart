import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:info_traffic_976/alert/providers/alert_providers.dart';
import 'package:info_traffic_976/alert/providers/traffic_alert.dart';
import 'package:info_traffic_976/alert/services/alert_api.dart';
import 'package:info_traffic_976/alert/services/traffic_alert_api.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

class CustomController extends MapController {
  CustomController({
    bool initMapWithUserPosition = true,
    GeoPoint? initPosition,
    BoundingBox? areaLimit = const BoundingBox.world(),
  })  : assert(
          initMapWithUserPosition || initPosition != null,
        ),
        super(
          initMapWithUserPosition: initMapWithUserPosition,
          initPosition: initPosition,
          areaLimit: areaLimit,
        );

  @override
  void init() {
    super.init();
  }
}

class MainExample extends StatefulWidget {
  const MainExample({Key? key}) : super(key: key);

  @override
  _MainExampleState createState() => _MainExampleState();
}

class _MainExampleState extends State<MainExample> with OSMMixinObserver {
  late CustomController controller;
  late GlobalKey<ScaffoldState> scaffoldKey;
  Key mapGlobalkey = UniqueKey();
  ValueNotifier<bool> zoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> visibilityZoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> advPickerNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> trackingNotifier = ValueNotifier(false);
  ValueNotifier<bool> showFab = ValueNotifier(true);
  ValueNotifier<GeoPoint?> lastGeoPoint = ValueNotifier(null);
  Timer? timer;
  int x = 0;

  @override
  void initState() {
    super.initState();
    controller = CustomController(
        // initMapWithUserPosition: false,
        // initPosition: GeoPoint(
        //   latitude: 47.4358055,
        //   longitude: 8.4737324,
        // ),
        // areaLimit: BoundingBox(
        //   east: 10.4922941,
        //   north: 47.8084648,
        //   south: 45.817995,
        //   west: 5.9559113,
        // ),
        );
    controller.addObserver(this);
    scaffoldKey = GlobalKey<ScaffoldState>();
    Wakelock.enable();
  }

  Future<void> mapIsInitialized() async {
    await controller.setZoom(zoomLevel: 15);
    // await controller.setMarkerOfStaticPoint(
    //   id: "line 1",
    //   markerIcon: MarkerIcon(
    //     icon: Icon(
    //       Icons.train,
    //       color: Colors.red,
    //       size: 48,
    //     ),
    //   ),
    // );
    await controller.setMarkerOfStaticPoint(
      id: 'traffic alert',
      markerIcon: const MarkerIcon(
        icon: Icon(
          Icons.warning,
          color: Colors.red,
          size: 100,
        ),
      ),
    );

    await controller.setStaticPosition(
      [
        GeoPointWithOrientation(
          latitude: -12.84363,
          longitude: 45.11622,
        ),
        GeoPointWithOrientation(
          latitude: -12.84423,
          longitude: 45.11675,
        ),
      ],
      'traffic alert',
    );
    final bounds = await controller.bounds;
    print(bounds.toString());
    await controller.addMarker(
      GeoPoint(latitude: 47.442475, longitude: 8.4680389),
      markerIcon: const MarkerIcon(
        icon: Icon(
          Icons.car_repair,
          color: Colors.black45,
          size: 48,
        ),
      ),
    );
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      await mapIsInitialized();
      var timer = Timer.periodic(const Duration(minutes: 2), myCallback);
    }
  }

  @override
  void dispose() {
    if (timer != null && timer!.isActive) {
      timer?.cancel();
    }
    //controller.listenerMapIsReady.removeListener(mapIsInitialized);
    controller.dispose();
    Wakelock.disable();
    super.dispose();
  }

  void myCallback(Timer timer) async {
    final alertProvider = Provider.of<AlertProvider>(context, listen: false);
    final trafficAlertProvider =
        Provider.of<TrafficAlertProvider>(context, listen: false);
    var res1 = await AlertAPIHelper.getAlertTable();
    var res2 = await TrafficAlertAPIHelper.getTrafficAlert();
    print(res1.data);
    print(res2.data);
    alertProvider.setAlertTable(res1.data);
    trafficAlertProvider.setTrafficAlert(res2.data);
    print(trafficAlertProvider.trafficAlert);
    List<GeoPoint> listGeoPts = [];
    trafficAlertProvider.trafficAlert.forEach((element) async {
      listGeoPts.add(
        GeoPoint(latitude: element.lat, longitude: element.lon),
      );
    });
    await controller.setStaticPosition(listGeoPts, "traffic alert");
    print(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: OSMFlutter(
        controller: controller,
        trackMyPosition: false,
        androidHotReloadSupport: true,
        mapIsLoading: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text('Chargement de la carte..'),
            ],
          ),
        ),
        onMapIsReady: (isReady) {
          if (isReady) {
            print('map is ready');
          }
        },
        initZoom: 15,
        minZoomLevel: 3,
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.location_history_rounded,
              color: Colors.red,
              size: 48,
            ),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(
              Icons.gps_fixed,
              color: Colors.blue,
              size: 100,
            ),
          ),
        ),
        showContributorBadgeForOSM: true,
        onLocationChanged: (myLocation) {
          // TODO : calculer distance aux obstacles
          print(myLocation);
        },
        onGeoPointClicked: (geoPoint) async {
          // TODO: afficher les informations sur un obstacles

          ScaffoldMessenger.of(context).showSnackBar(
            // todo : extraire dans une fonction pour pouvoir réutiliser
            SnackBar(
              content: Text(
                '${geoPoint.toMap().toString()}',
              ),
              action: SnackBarAction(
                onPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                label: 'ok',
              ),
            ),
          );
        },
        markerOption: MarkerOption(
          defaultMarker: const MarkerIcon(
            icon: Icon(
              Icons.home,
              color: Colors.orange,
              size: 64,
            ),
          ),
          advancedPickerMarker: const MarkerIcon(
            icon: const Icon(
              Icons.location_searching,
              color: Colors.green,
              size: 64,
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final alertProvider =
                  Provider.of<AlertProvider>(context, listen: false);
              final trafficAlertProvider =
                  Provider.of<TrafficAlertProvider>(context, listen: false);
              var res1 = await AlertAPIHelper.getAlertTable();
              var res2 = await TrafficAlertAPIHelper.getTrafficAlert();
              print(res1.data);
              print(res2.data);
              alertProvider.setAlertTable(res1.data);
              trafficAlertProvider.setTrafficAlert(res2.data);
              print(trafficAlertProvider.trafficAlert);
              List<GeoPoint> listGeoPts = [];
              trafficAlertProvider.trafficAlert.forEach((element) async {
                listGeoPts.add(
                  GeoPoint(latitude: element.lat, longitude: element.lon),
                );
              });
              await controller.setStaticPosition(listGeoPts, "traffic alert");
            },
            child: const Icon(Icons.refresh),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: showFab,
            builder: (ctx, isShow, child) {
              if (!isShow) {
                return const SizedBox.shrink();
              }
              return child!;
            },
            child: FloatingActionButton(
              onPressed: () async {
                if (!trackingNotifier.value) {
                  await controller.currentLocation();
                  await controller.enableTracking();
                  //await controller.zoom(5.0);
                } else {
                  await controller.disabledTracking();
                }
                trackingNotifier.value = !trackingNotifier.value;
              },
              child: ValueListenableBuilder<bool>(
                valueListenable: trackingNotifier,
                builder: (ctx, isTracking, _) {
                  if (isTracking) {
                    return const Icon(Icons.gps_off_sharp);
                  }
                  return const Icon(Icons.my_location);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> mapRestored() async {
    super.mapRestored();
    print('log map restored');
  }
}
