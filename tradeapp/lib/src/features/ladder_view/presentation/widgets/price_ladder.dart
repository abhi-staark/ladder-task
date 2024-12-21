import 'package:flutter/material.dart';
import 'package:tradeapp/src/constants/app_sizes.dart';
import 'package:tradeapp/src/features/ladder_view/presentation/widgets/price_selection_overlay.dart';
import 'package:tradeapp/src/theme/app_theme.dart';
import 'package:tradeapp/src/utils/helper_classes.dart';
import 'package:tradeapp/src/widgets/histogram.dart';

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
  OverlayEntry? _overlayEntry;
  String _selectedPrice = '';

  void _showOverlay(
      BuildContext context, Map<String, dynamic> item, bool isAsk) {
    // Calculate the position of the tapped tile
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _removeOverlay, // Close overlay when tapping outside
        child: Stack(
          children: [
            // Dimmed background
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            // Overlay widget
            Positioned(
              left: position.dx,
              top: position.dy,
              child: Material(
                color: Colors.transparent,
                child: PriceSelectionOverlay(
                  price: item['price'],
                  onBuy: () {
                    _handleBuy(
                        item['price'], isAsk ? widget.asks : widget.bids);
                    _removeOverlay();
                  },
                  onSell: () {
                    _handleSell(
                        item['price'], isAsk ? widget.asks : widget.bids);
                    _removeOverlay();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _selectedPrice = '';

    setState(() {});
  }

  void _handleBuy(String price, List<Map<String, dynamic>> list) {
    setState(() {
      for (var item in list) {
        if (item['price'] == price) {
          item['orderStatus'] = 'openBuy';
          _selectedPrice = '';
        }
      }
    });
  }

  void _handleSell(String price, List<Map<String, dynamic>> list) {
    setState(() {
      for (var item in list) {
        if (item['price'] == price) {
          item['orderStatus'] = 'openSell';
          _selectedPrice = '';
        }
      }
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

    return DragTarget<Map<String, dynamic>>(
      onWillAccept: (data) {
        return data != null &&
            data['price'] !=
                item['price']; // Prevent dropping onto the same tile
      },
      onAccept: (data) {
        if (data['price'] != null && data['orderStatus'] != null) {
          _updateOrder(data['price'], item['price'],
              isAsk ? widget.asks : widget.bids, data['orderStatus']);
        }
      },
      builder: (context, candidateData, rejectedData) {
        return InkWell(
          onTap: () {
            setState(() {
              _selectedPrice = item['price'];
            });
            _showOverlay(context, item, isAsk);
          },
          child: Stack(
            children: [
              (_selectedPrice != item['price'])
                  ? SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (!item['isAsk'])
                                  HistogramBar(
                                    value: int.parse(item['oi']),
                                    color: color,
                                    isAsk: item['isAsk'],
                                  ),
                              ],
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(height: 50),
              if (orderStatus == 'openBuy')
                Positioned(
                  left: AppSizes.appPadding,
                  top: 0,
                  bottom: 0,
                  child: SizedBox(
                    height: 20,
                    child: Draggable<Map<String, dynamic>>(
                      data: {
                        'price': item['price'],
                        'oi': item['oi'],
                        'orderStatus': item['orderStatus']
                      },
                      feedback:
                          _buildOrderIndicator(text: "+1 LMT", color: color),
                      childWhenDragging: const SizedBox.shrink(),
                      child: _buildOrderIndicator(text: "+1 LMT", color: color),
                    ),
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
                    feedback:
                        _buildOrderIndicator(text: "-1 LMT", color: color),
                    childWhenDragging: const SizedBox.shrink(),
                    child: _buildOrderIndicator(text: "-1 LMT", color: color),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLtp(String ltp) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.appPadding),
      child: Row(
        children: [
          Expanded(
            child: CustomPaint(
              painter: DottedLinePainter(color: Colors.grey),
              child:
                  const SizedBox(height: 1), // Set height for the dotted line
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
              child:
                  const SizedBox(height: 1), // Set height for the dotted line
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderIndicator({required Color color, required String text}) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.appPadding * 0.9),
      child: Container(
        width: 89,
        height: 34,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(text,
              style:
                  myTextTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500)),
        ),
      ),
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
