class EVStation {
  final String id;
  final String name;
  final String operatorName;
  final double lat;
  final double lng;
  final int connectors;
  final double price;
  final String address;
  final String port;

  EVStation({
    required this.id,
    required this.name,
    required this.operatorName,
    required this.lat,
    required this.lng,
    required this.connectors,
    required this.price,
    required this.address,
    required this.port,
  });

  factory EVStation.fromMap(String id, Map<String, dynamic> data) {
    return EVStation(
      id: id,
      name: data['name'] ?? 'EV Station',
      operatorName: data['operator'] ?? 'Unknown',
      lat: (data['lat'] as num).toDouble(),
      lng: (data['lng'] as num).toDouble(),
      connectors: (data['connectors'] ?? 0) as int,
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      address: data['address'] ?? '',
      port: data['port'] ?? '',
    );
  }
}
