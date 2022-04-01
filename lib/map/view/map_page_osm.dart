import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

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
    controller.listenerMapLongTapping.addListener(() async {
      if (controller.listenerMapLongTapping.value != null) {
        print(controller.listenerMapLongTapping.value);
        final randNum = Random.secure().nextInt(100).toString();
        print(randNum);
        await controller.addMarker(
          controller.listenerMapLongTapping.value!,
          markerIcon: MarkerIcon(
            iconWidget: SizedBox.fromSize(
              size: const Size.square(48),
              child: Stack(
                children: [
                  const Icon(
                    Icons.store,
                    color: Colors.brown,
                    size: 48,
                  ),
                  Text(
                    randNum,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          //angle: pi / 3,
        );
      }
    });
    controller.listenerMapSingleTapping.addListener(() async {
      if (controller.listenerMapSingleTapping.value != null) {
        if (lastGeoPoint.value != null) {
          await controller.removeMarker(lastGeoPoint.value!);
        }
        print(controller.listenerMapSingleTapping.value);
        lastGeoPoint.value = controller.listenerMapSingleTapping.value;
        await controller.addMarker(
          lastGeoPoint.value!,
          markerIcon: const MarkerIcon(
            icon: Icon(
              Icons.person_pin,
              color: Colors.red,
              size: 32,
            ),
            // assetMarker: AssetMarker(
            //   image: const AssetImage('asset/pin.png'),
          ),
          // assetMarker: AssetMarker(
          //   image: AssetImage("asset/pin.png"),
          //   //scaleAssetImage: 2,
          // ),

          //angle: -pi / 4,
        );
      }
    });
    controller.listenerRegionIsChanging.addListener(() async {
      if (controller.listenerRegionIsChanging.value != null) {
        print(controller.listenerRegionIsChanging.value);
      }
    });

    //controller.listenerMapIsReady.addListener(mapIsInitialized);
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
      id: 'line 2',
      markerIcon: const MarkerIcon(
        icon: Icon(
          Icons.train,
          color: Colors.orange,
          size: 48,
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
      'line 2',
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
    }
  }

  @override
  void dispose() {
    if (timer != null && timer!.isActive) {
      timer?.cancel();
    }
    //controller.listenerMapIsReady.removeListener(mapIsInitialized);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          OSMFlutter(
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
              print(myLocation);
            },
            onGeoPointClicked: (geoPoint) async {
              // if (geoPoint ==
              //     GeoPoint(latitude: 47.442475, longitude: 8.4680389)) {
              //   await controller.setMarkerIcon(
              //       geoPoint,
              //       const MarkerIcon(
              //         icon: const Icon(
              //           Icons.bus_alert,
              //           color: Colors.blue,
              //           size: 24,
              //         ),
              //       ));
              // }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${geoPoint.toMap().toString()}',
                  ),
                  action: SnackBarAction(
                    onPressed: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                    label: 'hide',
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
          Positioned(
            bottom: 10,
            left: 10,
            child: ValueListenableBuilder<bool>(
              valueListenable: advPickerNotifierActivation,
              builder: (ctx, visible, child) {
                return Visibility(
                  visible: visible,
                  child: AnimatedOpacity(
                    opacity: visible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: child,
                  ),
                );
              },
              child: FloatingActionButton(
                key: UniqueKey(),
                child: const Icon(Icons.arrow_forward),
                heroTag: 'confirmAdvPicker',
                onPressed: () async {
                  advPickerNotifierActivation.value = false;
                  GeoPoint p = await controller.selectAdvancedPositionPicker();
                  print(p);
                },
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: ValueListenableBuilder<bool>(
              valueListenable: visibilityZoomNotifierActivation,
              builder: (ctx, visibility, child) {
                return Visibility(
                  visible: visibility,
                  child: child!,
                );
              },
              child: ValueListenableBuilder<bool>(
                valueListenable: zoomNotifierActivation,
                builder: (ctx, isVisible, child) {
                  return AnimatedOpacity(
                    opacity: isVisible ? 1.0 : 0.0,
                    onEnd: () {
                      visibilityZoomNotifierActivation.value = isVisible;
                    },
                    duration: const Duration(milliseconds: 500),
                    child: child,
                  );
                },
                child: Column(
                  children: [
                    ElevatedButton(
                      child: const Icon(Icons.add),
                      onPressed: () async {
                        controller.zoomIn();
                      },
                    ),
                    ElevatedButton(
                      child: const Icon(Icons.remove),
                      onPressed: () async {
                        controller.zoomOut();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
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
    );
  }

  @override
  Future<void> mapRestored() async {
    super.mapRestored();
    print('log map restored');
  }
}
