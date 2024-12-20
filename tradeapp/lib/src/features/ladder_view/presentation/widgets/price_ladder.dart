import 'package:flutter/material.dart';
import 'package:tradeapp/src/features/ladder_view/presentation/widgets/price_selection_overlay.dart';
import 'package:tradeapp/src/utils/helper_functions.dart';
import 'package:tradeapp/src/widgets/histogram.dart';
import 'package:tradeapp/src/widgets/price_tile.dart';

import 'package:flutter/material.dart';

class PriceLadder extends StatefulWidget {
  final List<Map<String, dynamic>> asks = [
    {'price': '1002.0', 'oi': '70', 'orderStatus': 'noOrder'},
    {'price': '1001.5', 'oi': '50', 'orderStatus': 'noOrder'},
    {'price': '1001.0', 'oi': '70', 'orderStatus': 'noOrder'},
    {'price': '1000.5', 'oi': '120', 'orderStatus': 'noOrder'},
  ];

  final List<Map<String, dynamic>> bids = [
    {'price': '999.5', 'oi': '30', 'orderStatus': 'noOrder'},
    {'price': '999.0', 'oi': '60', 'orderStatus': 'noOrder'},
    {'price': '998.5', 'oi': '90', 'orderStatus': 'noOrder'},
    {'price': '998.0', 'oi': '60', 'orderStatus': 'noOrder'},
    {'price': '997.5', 'oi': '90', 'orderStatus': 'noOrder'},
  ];

  final String ltp = '1000.0';

  PriceLadder({super.key});

  @override
  _PriceLadderState createState() => _PriceLadderState();
}

class _PriceLadderState extends State<PriceLadder> {
  String? _selectedPrice; // To track the selected price for overlay
  bool _isAskOverlay = false; // To track if the overlay is for asks or bids

  void _handleBuy(String price, List<Map<String, dynamic>> list) {
    setState(() {
      for (var item in list) {
        if (item['price'] == price) {
          item['orderStatus'] = 'openBuy';
        }
      }
      _isAskOverlay = false;
      _selectedPrice = null; // Close the overlay
    });
  }

  void _handleSell(String price, List<Map<String, dynamic>> list) {
    setState(() {
      for (var item in list) {
        if (item['price'] == price) {
          item['orderStatus'] = 'openSell';
        }
      }
      _isAskOverlay = false;
      _selectedPrice = null; // Close the overlay
    });
  }

  void _updateOrder(String? fromPrice, String? toPrice,
      List<Map<String, dynamic>> list, String orderStatus) {
    if (fromPrice == null || toPrice == null) return; // Avoid null issues
    setState(() {
      for (var item in list) {
        if (item['price'] == fromPrice) {
          item['orderStatus'] = null; // Clear the previous order status
        }
        if (item['price'] == toPrice) {
          item['orderStatus'] = orderStatus; // Set the new order status
        }
      }
    });
  }

  Widget _buildPriceTile(Map<String, dynamic> item, Color color, bool isAsk) {
    String orderStatus = item['orderStatus'] ?? '';
    bool isSelected = _selectedPrice == item['price'] && _isAskOverlay == isAsk;

    return DragTarget<Map<String, dynamic>>(
      onWillAccept: (data) {
        return data != null &&
            data['price'] !=
                item['price']; // Prevent dropping onto the same tile
      },
      onAccept: (data) {
        if (data != null &&
            data['price'] != null &&
            data['orderStatus'] != null) {
          _updateOrder(data['price'], item['price'],
              isAsk ? widget.asks : widget.bids, data['orderStatus']);
        }
      },
      builder: (context, candidateData, rejectedData) {
        return GestureDetector(
          onTap: !isSelected
              ? () {
                  setState(() {
                    _selectedPrice = item['price'];
                    _isAskOverlay = isAsk;
                  });
                }
              : null,
          child: Stack(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          item['price'],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                PriceSelectionOverlay(
                  price: item['price'],
                  onBuy: () => _handleBuy(
                      item['price'], isAsk ? widget.asks : widget.bids),
                  onSell: () => _handleSell(
                      item['price'], isAsk ? widget.asks : widget.bids),
                ),
              if (orderStatus == 'openBuy')
                Positioned(
                  left: 8,
                  top: 0,
                  bottom: 0,
                  child: Draggable<Map<String, dynamic>>(
                    data: {
                      'price': item['price'],
                      'oi': item['oi'],
                      'orderStatus': item['orderStatus']
                    },
                    feedback:
                        Icon(Icons.shopping_cart, color: Colors.blue, size: 24),
                    childWhenDragging: Icon(Icons.shopping_cart,
                        color: Colors.blue.withOpacity(0.5), size: 24),
                    child:
                        Icon(Icons.shopping_cart, color: Colors.blue, size: 24),
                  ),
                ),
              if (orderStatus == 'openSell')
                Positioned(
                  right: 8,
                  top: 0,
                  bottom: 0,
                  child: Draggable<Map<String, dynamic>>(
                    data: {
                      'price': item['price'],
                      'oi': item['oi'],
                      'orderStatus': item['orderStatus']
                    },
                    feedback: Icon(Icons.sell, color: Colors.orange, size: 24),
                    childWhenDragging: Icon(Icons.sell,
                        color: Colors.orange.withOpacity(0.5), size: 24),
                    child: Icon(Icons.sell, color: Colors.orange, size: 24),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...widget.asks.map(
          (ask) => _buildPriceTile(ask, Colors.red, true),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Text(
              '-------- ${widget.ltp} --------',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        ...widget.bids.map(
          (bid) => _buildPriceTile(bid, Colors.green, false),
        ),
      ],
    );
  }
}
