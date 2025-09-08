import 'package:flutter/material.dart';
import 'package:kali/client/Style.service.dart';

class SlidableItem extends StatefulWidget {
  const SlidableItem({super.key, required this.child, required this.onRemove});

  final Widget child;
  final Function onRemove;

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
        decoration: BoxDecoration(color: style.background.error.color),
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 18),
          child: const Icon(Icons.delete, color: Colors.white, size: 30),
        ),
      ),
      key: Key(widget.key.toString()),
      onDismissed: (direction) {
        widget.onRemove();
      },
      child: widget.child,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder:
              (ctx) => AlertDialog(
                title: Text('Confirmer la suppression'),
                content: Text('Voulez-vous vraiment supprimer cet élément ?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: Text('Annuler'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: Text('Supprimer'),
                  ),
                ],
              ),
        );
      },
    );
  }
}
