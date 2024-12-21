import 'package:flutter/material.dart';
import 'package:tradeapp/src/constants/app_sizes.dart';
import 'package:tradeapp/src/features/ladder_view/presentation/widgets/order_indicator.dart';
import 'package:tradeapp/src/features/ladder_view/presentation/widgets/price_selection_overlay.dart';
import 'package:tradeapp/src/theme/app_theme.dart';
import 'package:tradeapp/src/utils/helper_classes.dart';
import 'package:tradeapp/src/utils/helper_functions.dart';
import 'package:tradeapp/src/widgets/histogram.dart';
import 'package:tradeapp/src/widgets/price_tile.dart';

import 'package:flutter/material.dart';

class PriceLadder extends StatefulWidget {
  final List<Map<String, dynamic>> asks = [
    {'price': '1002.0', 'oi': '70', 'isAsk': true, 'orderStatus': 'noOrder'},
    {'price': '1001.5', 'oi': '50', 'isAsk': true, 'orderStatus': 'noOrder'},
    {'price': '1001.0', 'oi': '70', 'isAsk': true, 'orderStatus': 'noOrder'},
    {'price': '1000.5', 'oi': '120', 'isAsk': true, 'orderStatus': 'noOrder'},
  ];

  final List<Map<String, dynamic>> bids = [
    {'price': '999.5', 'oi': '30', 'isAsk': false, 'orderStatus': 'noOrder'},
    {'price': '999.0', 'oi': '60', 'isAsk': false, 'orderStatus': 'noOrder'},
    {'price': '998.5', 'oi': '90', 'isAsk': false, 'orderStatus': 'noOrder'},
    {'price': '998.0', 'oi': '60', 'isAsk': false, 'orderStatus': 'noOrder'},
    {'price': '997.5', 'oi': '90', 'isAsk': false, 'orderStatus': 'noOrder'},
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
        return InkWell(
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
                      flex: 1,
                      child: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (!item['isAsk'])
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start, // Facing right
                                children: [
                                  HistogramBar(
                                    value: int.parse(item['oi']),
                                    color: color,
                                    isAsk: item['isAsk'],
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(item['price'],
                            style: myTextTheme.bodySmall!
                                .copyWith(fontWeight: FontWeight.w400)),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.end, // Facing right
                        children: [
                          if (item['isAsk'])
                            SizedBox(
                              width: 100,
                              height: 50,
                              child: HistogramBar(
                                value: int.parse(item['oi']),
                                color: color,
                                isAsk: item['isAsk'],
                              ),
                            ),
                          //SizedBox(width: 20, child: Text(item['oi']))
                        ],
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
                  left: AppSizes.appPadding,
                  top: 0,
                  bottom: 0,
                  child: Draggable<Map<String, dynamic>>(
                    data: {
                      'price': item['price'],
                      'oi': item['oi'],
                      'orderStatus': item['orderStatus']
                    },
                    feedback: OrderIndicator(text: "+1 LMT", color: color),
                    childWhenDragging:
                        OrderIndicator(text: "+1 LMT", color: color),
                    child: OrderIndicator(text: "+1 LMT", color: color),
                  ),
                ),
              if (orderStatus == 'openSell')
                Positioned(
                  right: AppSizes.appPadding,
                  top: 0,
                  bottom: 0,
                  child: Draggable<Map<String, dynamic>>(
                    data: {
                      'price': item['price'],
                      'oi': item['oi'],
                      'orderStatus': item['orderStatus']
                    },
                    feedback: OrderIndicator(text: "-1 LMT", color: color),
                    childWhenDragging:
                        OrderIndicator(text: "-1 LMT", color: color),
                    child: OrderIndicator(text: "-1 LMT", color: color),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLtp(String ltp) {
    return Row(
      children: [
        Expanded(
          child: CustomPaint(
            painter: DottedLinePainter(color: Colors.grey),
            child: const SizedBox(height: 1), // Set height for the dotted line
          ),
        ),
        Container(
          height: 31,
          width: 87,
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(ltp, style: myTextTheme.bodySmall),
          ),
        ),
        Expanded(
          child: CustomPaint(
            painter: DottedLinePainter(color: Colors.grey),
            child: const SizedBox(height: 1), // Set height for the dotted line
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...widget.asks.map(
          (ask) => _buildPriceTile(ask, Colors.red, true),
        ),
        _buildLtp(widget.ltp),
        ...widget.bids.map(
          (bid) => _buildPriceTile(bid, Colors.green, false),
        ),
      ],
    );
  }
}
