import 'package:flutter/material.dart';
import '../models/ev_station.dart';

class ProfileBottomSheet extends StatelessWidget {
  final EVStation station;
  const ProfileBottomSheet({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(station.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(station.address),
          const SizedBox(height: 8),
          Text('Operator: ${station.operatorName}'),
          Text('Connectors: ${station.connectors} • Port: ${station.port}'),
          Text('Price: ₹${station.price.toStringAsFixed(2)} per kWh'),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          )
        ],
      ),
    );
  }
}
