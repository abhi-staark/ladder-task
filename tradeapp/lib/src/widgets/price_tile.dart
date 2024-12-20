import 'package:flutter/material.dart';
import 'package:tradeapp/src/features/ladder_view/presentation/widgets/price_selection_overlay.dart';
import 'package:tradeapp/src/widgets/histogram.dart';

class PriceTile extends StatefulWidget {
  final String price;
  final String quantity;
  final Color color;
  final VoidCallback onTap;

  const PriceTile({
    super.key,
    required this.price,
    required this.quantity,
    required this.color,
    required this.onTap,
  });

  @override
  _PriceTileState createState() => _PriceTileState();
}

class _PriceTileState extends State<PriceTile> {
  bool _isOverlayVisible = false;

  void _toggleOverlay() {
    setState(() {
      _isOverlayVisible = !_isOverlayVisible;
    });
  }

  void onBuy() {
    setState(() {
      _isOverlayVisible = false;
    });
  }

  void onSell() {
    setState(() {
      _isOverlayVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isOverlayVisible) {
      return PriceSelectionOverlay(
        price: widget.price,
        onBuy: onBuy,
        onSell: onSell,
      );
    }

    return Stack(
      children: [
        ListTile(
          onTap: _toggleOverlay,
          tileColor: widget.color.withOpacity(0.1),
          title: Text(widget.price, style: const TextStyle(fontSize: 16)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              HistogramBar(
                value: int.parse(widget.quantity),
                color: Colors.black38,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
