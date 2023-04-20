import 'package:flutter/material.dart';

class InfiniteListView extends StatefulWidget {
  final List<Widget> children;
  final Axis scrollDirection;
  final bool hasMore;
  final void Function()? fetchMore;

  const InfiniteListView({
    super.key,
    required this.children,
    this.scrollDirection = Axis.vertical,
    this.hasMore = false,
    this.fetchMore,
  });

  @override
  State<InfiniteListView> createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset &&
          widget.hasMore) {
        if (widget.fetchMore != null) {
          widget.fetchMore!();
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      scrollDirection: widget.scrollDirection,
      itemCount: widget.children.length + 1,
      itemBuilder: (_, index) {
        if (index < widget.children.length) {
          return widget.children[index];
        }

        if (widget.hasMore) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
