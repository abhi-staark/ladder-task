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
    {'price': '1000.5', 'oi': '120', 'orderStatus': 'openSell'},
  ];

  final List<Map<String, dynamic>> bids = [
    {'price': '999.5', 'oi': '30', 'orderStatus': 'noOrder'},
    {'price': '999.0', 'oi': '60', 'orderStatus': 'noOrder'},
    {'price': '998.5', 'oi': '90', 'orderStatus': 'openBuy'},
    {'price': '998.0', 'oi': '60', 'orderStatus': 'noOrder'},
    {'price': '997.5', 'oi': '90', 'orderStatus': 'noOrder'},
  ];

  final String ltp = '1000.0';

  PriceLadder({super.key});

  @override
  _PriceLadderState createState() => _PriceLadderState();
}

class _PriceLadderState extends State<PriceLadder> {
  // Function to handle placing buy order
  void _handleBuy(String price, List<Map<String, dynamic>> list) {
    setState(() {
      for (var item in list) {
        if (item['price'] == price) {
          item['orderStatus'] = 'openBuy';
        }
      }
    });
  }

  // Function to handle placing sell order
  void _handleSell(String price, List<Map<String, dynamic>> list) {
    setState(() {
      for (var item in list) {
        if (item['price'] == price) {
          item['orderStatus'] = 'openSell';
        }
      }
    });
  }

  // Function to modify the price of an existing order after drag
  void _modifyOrder(String newPrice, Map<String, dynamic> order,
      List<Map<String, dynamic>> list) {
    setState(() {
      order['price'] = newPrice;
    });
  }

  // Build draggable price tile for each price level
  Widget _buildDraggableTile(
      Map<String, dynamic> item, Color color, bool isAsk) {
    return Draggable<Map<String, dynamic>>(
      data: item,
      feedback: Material(
        child: Container(
          width: 250,
          child: ListTile(
            tileColor: color.withOpacity(0.5),
            title: Text(item['price'], style: const TextStyle(fontSize: 16)),
            trailing: Icon(
              isAsk ? Icons.sell : Icons.shopping_cart,
              color: isAsk ? Colors.orange : Colors.blue,
            ),
          ),
        ),
      ),
      childWhenDragging: Container(
        color: color.withOpacity(0.1),
      ),
      child: _buildPriceTile(item, color, isAsk),
    );
  }

  // Build price tile for each price level (buy or sell)
  Widget _buildPriceTile(Map<String, dynamic> item, Color color, bool isAsk) {
    String orderStatus = item['orderStatus'];

    return DragTarget<Map<String, dynamic>>(
      onWillAccept: (draggedItem) {
        final double draggedPrice = double.parse(draggedItem?['price'] ?? '0');
        final double targetPrice = double.parse(item['price']);
        final double ltp = double.parse(widget.ltp);

        if (isAsk) {
          // Allow dragging for sell orders within the range until LTP
          return draggedPrice >= targetPrice && targetPrice > ltp;
        } else {
          // Allow dragging for buy orders within the range until LTP
          return draggedPrice <= targetPrice && targetPrice < ltp;
        }
      },
      onAccept: (draggedItem) {
        _modifyOrder(
            item['price'], draggedItem, isAsk ? widget.asks : widget.bids);
      },
      builder: (context, candidateData, rejectedData) {
        return Stack(
          children: [
            ListTile(
              tileColor: color.withOpacity(0.1),
              title: Text(item['price'], style: const TextStyle(fontSize: 16)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  HistogramBar(value: int.parse(item['oi'])),
                ],
              ),
              onTap: () {
                // Show the overlay to place an order when tapping a price tile
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return PriceSelectionOverlay(
                      price: item['price'],
                      onBuy: () => _handleBuy(
                          item['price'], isAsk ? widget.asks : widget.bids),
                      onSell: () => _handleSell(
                          item['price'], isAsk ? widget.asks : widget.bids),
                    );
                  },
                );
              },
            ),
            if (orderStatus == 'openBuy')
              Positioned(
                left: 8,
                top: 0,
                bottom: 0,
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.blue,
                  size: 24,
                ),
              ),
            if (orderStatus == 'openSell')
              Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: Icon(
                  Icons.sell,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...widget.asks.map(
          (ask) => ask['orderStatus'] == 'noOrder'
              ? _buildPriceTile(ask, Colors.red, true)
              : _buildDraggableTile(ask, Colors.red, true),
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
          (bid) => bid['orderStatus'] == 'noOrder'
              ? _buildPriceTile(bid, Colors.green, false)
              : _buildDraggableTile(bid, Colors.green, false),
        ),
      ],
    );
  }
}
