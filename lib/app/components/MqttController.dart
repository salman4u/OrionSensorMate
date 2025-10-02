import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:sensor_mate/app/utility/Utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MqttController extends GetxController {
  // Configuration
  static const String _tag = 'MQTT';
  static const String _prefs = 'mqtt_prefs';
  static const String _prefClientId = 'client_id';
  static const String topic = 'xcom5gc_event';
  static const String serverUri = 'tcp://50.248.143.225:1883';
  static const String username = 'xcom5gnc';
  static const String password = 'XyC?5gBr828+eL!';
  static const String lwtTopic = 'clients/android/status';
  static const String lwtPayload = 'offline';
  static const int baseDelayMs = 2000; // 2s
  static const int maxDelayMs = 120000; // 2m
  static const int maxInflight = 10;

  late MqttServerClient _client;
  final _topicQos = <String, int>{}.obs; // Observable map for subscriptions
  final _isConnected = false.obs;
  final _networkAvailable = false.obs;
  final _currentDelayMs = baseDelayMs.obs;
  final _connecting = false.obs;
  final _started = false.obs;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  Function(String, String)? onMessageCallback;
  Function(bool)? onConnectedCallback;
  Function(Throwable)? onDisconnectedCallback;
  Function(String, Throwable)? onErrorCallback;

  @override
  void onInit() {
    super.onInit();
    _initializeClient();
   // _registerNetworkCallback();
  }

  @override
  void onClose() {
    stop();
    super.onClose();
  }

  Future<void> _initializeClient() async {
    String clientId = await _getOrCreateStableClientId();
     _client = MqttServerClient('50.248.143.225', '');
    _client.port = 1883;
    _client.useWebSocket = false;
    _client.logging(on: true);

    // _client = MqttServerClient(serverUri, clientId);
    // _client.logging(on: false);
    // _client.setProtocolV311();
    _client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .authenticateAs(username, password)
        .withWillTopic(lwtTopic)
        .withWillMessage(lwtPayload)
        .withWillQos(MqttQos.atLeastOnce)
        .keepAliveFor(45)
        .startClean();
    _client.connectTimeoutPeriod = 10000;
    // _client. = maxInflight;

    _client.onConnected = () {
      print('$_tag: connectComplete');
      _currentDelayMs.value = baseDelayMs; // Reset backoff
      _isConnected.value = true;
      onConnectedCallback?.call(false);
      _resubscribeAll();
      _subscribeToTopic(topic, 1);
    };

    _client.onDisconnected = () {
      print('$_tag: connectionLost');
      _isConnected.value = false;
     // onDisconnectedCallback?.call(null);
      _scheduleReconnect('connectionLost');
    };
    connect();

  }
  void connect() async {
    try {
      print("Connecting to MQTT broker...");
      await _client.connect();

      if (_client.connectionStatus?.state == MqttConnectionState.connected) {
        print("Connected successfully!");

        // Listen safely after connection
        _client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
          for (var message in messages) {
            final mqttMessage = message.payload as MqttPublishMessage;
            final payload =
            MqttPublishPayload.bytesToStringAsString(mqttMessage.payload.message);
            showThrottledToast(payload);
            final topic = message.topic;

            print('$_tag: topic=$topic payload=$payload');

            try {
              onMessageCallback?.call(topic, payload);
            } catch (e) {
              print('$_tag: Payload convert error: $e');
              //onErrorCallback?.call('messageConvert');
            }
          }
        });
      } else {
        print("Connection failed: ${_client.connectionStatus}");
      }
    } catch (e) {
      print("Connection error: $e");
      _client.disconnect();
    }
  }
  DateTime? _lastToastTime;

  void showThrottledToast(String message) {
    final now = DateTime.now();
    if (_lastToastTime == null ||
        now.difference(_lastToastTime!).inSeconds >= 10) {
      _lastToastTime = now;
      Utility.showCustomToast(message); // use your custom toast here
    } else {
      print("⏳ Skipping toast (last shown ${now.difference(_lastToastTime!).inSeconds}s ago)");
    }
  }

  Future<String> _getOrCreateStableClientId() async {
    final prefs = await SharedPreferences.getInstance();
    String? clientId = prefs.getString(_prefClientId);
    if (clientId == null || clientId.trim().isEmpty) {
      clientId = 'FlutterClient_${DateTime.now().millisecondsSinceEpoch}';
      await prefs.setString(_prefClientId, clientId);
    }
    return clientId;
  }

  void start() {
    if (_started.value) return;
    _started.value = true;
   // _registerNetworkCallback();
    _tryConnect('start');
  }

  void stop() {
    if (!_started.value) return;
    _started.value = false;
    _unregisterNetworkCallback();
    if (_isConnected.value) {
      try {
        _client.disconnect();
      } catch (e) {
        print('$_tag: disconnect error: $e');
        onErrorCallback?.call('disconnect', e as Throwable);
      }
    }
  }

  bool get isConnected => _isConnected.value;

  void subscribeToTopic(String topic, int qos) {
    _topicQos[topic] = qos;
    if (isConnected) {
      try {
        _client.subscribe(topic, MqttQos.values[qos]);
        print('$_tag: Subscribed to $topic');
      } catch (e) {
        print('$_tag: subscribe error $topic: $e');
        onErrorCallback?.call('subscribe', e as Throwable);
      }
    }
  }

  void unsubscribe(String topic) {
    _topicQos.remove(topic);
    if (isConnected) {
      try {
        _client.unsubscribe(topic);
        print('$_tag: Unsubscribed from $topic');
      } catch (e) {
        print('$_tag: unsubscribe error $topic: $e');
        onErrorCallback?.call('unsubscribe', e as Throwable);
      }
    }
  }

  void publish(String topic, List<int> payload, int qos, bool retained) {
    try {
      if (!isConnected) {
        print('$_tag: publish queued (offline buffer) topic=$topic');
      }
      final builder = MqttClientPayloadBuilder();
     // builder.addBuffer(Uint8List.fromList(payload));
      _client.publishMessage(topic, MqttQos.values[qos], builder.payload!, retain: retained);
    } catch (e) {
      print('$_tag: publish error $topic: $e');
      onErrorCallback?.call('publish', e as Throwable);
    }
  }

  void _subscribeToTopic(String topic, int qos) {
    try {
      _client.subscribe(topic, MqttQos.values[qos]);
      print('$_tag: Subscribed to $topic');
    } catch (e) {
      print('$_tag: Exception during subscribe: $e');
    }
  }

  void _resubscribeAll() {
    if (!isConnected) return;
    for (var entry in _topicQos.entries) {
      try {
        _client.subscribe(entry.key, MqttQos.values[entry.value]);
        print('$_tag: Resubscribed to ${entry.key}');
      } catch (e) {
        print('$_tag: resubscribe error ${entry.key}: $e');
        onErrorCallback?.call('resubscribe', e as Throwable);
      }
    }
  }

  void _tryConnect(String reason) {
    if (!_networkAvailable.value) {
      print('$_tag: tryConnect skipped ($reason) — no network');
      return;
    }
    if (isConnected) {
      print('$_tag: tryConnect: already connected');
      return;
    }
    if (_connecting.value) {
      print('$_tag: tryConnect: already connecting');
      return;
    }
    _connecting.value = true;
    print('$_tag: Connecting ($reason)...');
    _client.connect().then((_) {
      _connecting.value = false;
      print('$_tag: Connected');
    }).catchError((e) {
      _connecting.value = false;
      print('$_tag: Connect failed: $e');
      onErrorCallback?.call('connect', e as Throwable);
      _scheduleReconnect('connectFailure');
    });
  }

  void _scheduleReconnect(String stage) {
    if (!_started.value) return;
    if (!_networkAvailable.value) {
      print('$_tag: scheduleReconnect skipped ($stage) — no network');
      return;
    }
    final jitter = (Random().nextDouble() * 0.25 * _currentDelayMs.value).toInt();
    final delay = _currentDelayMs.value + jitter;
    print('$_tag: Reconnecting in $delay ms (stage=$stage)');
    Future.delayed(Duration(milliseconds: delay), () {
      _tryConnect('reconnectTimer');
    });
    _currentDelayMs.value = min(maxDelayMs, _currentDelayMs.value * 2);
  }

  void _registerNetworkCallback() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      final hasInternet = results.any((result) => result != ConnectivityResult.none);
      _networkAvailable.value = hasInternet;
      if (hasInternet) {
        _currentDelayMs.value = baseDelayMs; // Optimistic reset
        print('$_tag: Network available');
        _tryConnect('networkAvailable');
      } else {
        print('$_tag: Network lost');
      }
    }) as StreamSubscription<ConnectivityResult>?;
    Connectivity().checkConnectivity().then((List<ConnectivityResult> results) {
      _networkAvailable.value = results.any((result) => result != ConnectivityResult.none);
    });
  }
  void _unregisterNetworkCallback() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
  }

  // Integration with previous startMQTT and updateWifi methods
  void startMQTT() {
    final data = [
      ['flolive.net', '587fdc3f-682a-41b7-9570-4682d1ff4e6a'],
      ['mqtt://50.248.143.225', '3b187bbb-4556-4309-8a66-a613624d81b7'],
      ['1883', '0bc80a1a-ad2b-49fd-85be-d0a31d13ef74'],
      ['xcom5gnc', '9c9c0738-8163-412f-8617-ee0c020a0c2a'],
      ['XyC?5gBr828+eL!', '5aae588a-ffa2-4516-a324-d7b5a671f66a'],
      ['xcom5gc_event', 'c3cfdfef-3b10-4620-beb3-3bb918302262'],
    ];

    int delay = 0;
    for (var entry in data) {
      final value = entry[0];
      final uuid = entry[1];
      Future.delayed(Duration(milliseconds: delay), () {
        publish('hub/topic', utf8.encode('$value,$uuid'), 1, false);
      });
      delay += 10000;
    }
  }

  void updateWifi(String wifiName, String password) {
    final data = [
      [wifiName, '234839e8-604a-47b2-9659-07a98e7f7c23'],
      [password, '990edbd9-e3ff-4a58-b346-706ab51a503c'],
    ];

    int delay = 0;
    for (var entry in data) {
      final value = entry[0];
      final uuid = entry[1];
      Future.delayed(Duration(milliseconds: delay), () {
        publish('hub/topic', utf8.encode('$value,$uuid'), 1, false);
      });
      delay += 10000;
    }
  }
}

// Placeholder for Throwable (Dart doesn't have a direct equivalent)
class Throwable {
  final dynamic error;
  Throwable(this.error);
}