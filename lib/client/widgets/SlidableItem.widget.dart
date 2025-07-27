import 'package:flutter/material.dart';

class SlidableItem extends StatefulWidget {
  const SlidableItem({super.key, required this.child});

  final Widget child;

  @override
  State<SlidableItem> createState() => _SlidableItemState();
}

class _SlidableItemState extends State<SlidableItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(color: Colors.amber),
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              const Icon(Icons.archive, color: Colors.white, size: 40),
              const SizedBox(width: 4),
              Text(
                "toto",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
      key: Key(widget.key.toString()),
      onDismissed: (direction) {},
      child: widget.child,
    );
  }
}
