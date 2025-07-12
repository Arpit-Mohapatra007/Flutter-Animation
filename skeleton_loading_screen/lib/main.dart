import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skeleton Loading Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SkeletonDemo(),
    );
  }
}

class SkeletonDemo extends StatefulWidget {
  @override
  _SkeletonDemoState createState() => _SkeletonDemoState();
}

class _SkeletonDemoState extends State<SkeletonDemo> {
  bool isLoading = true;
  List<String> data = [];

  @override
  void initState() {
    super.initState();
    // Simulate data loading
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
        data = [
          'John Doe',
          'Jane Smith',
          'Bob Johnson',
          'Alice Brown',
          'Charlie Wilson',
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skeleton Loading Demo'),
      ),
      body: isLoading
          ? SkeletonLoader()
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(data[index][0]),
                  ),
                  title: Text(data[index]),
                  subtitle: Text('User details for ${data[index]}'),
                  trailing: Icon(Icons.arrow_forward_ios),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isLoading = !isLoading;
          });
        },
        child: Icon(isLoading ? Icons.stop : Icons.refresh),
      ),
    );
  }
}

class SkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return SkeletonItem();
      },
    );
  }
}

class SkeletonItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          // Avatar skeleton
          SkeletonBox(
            width: 50,
            height: 50,
            borderRadius: 25,
          ),
          SizedBox(width: 16),
          // Content skeleton
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(
                  width: double.infinity,
                  height: 16,
                ),
                SizedBox(height: 8),
                SkeletonBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 14,
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          // Trailing icon skeleton
          SkeletonBox(
            width: 16,
            height: 16,
          ),
        ],
      ),
    );
  }
}

class SkeletonBox extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonBox({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 4,
  }) : super(key: key);

  @override
  _SkeletonBoxState createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              colors: [
                Colors.grey[300]!,
                Colors.grey[100]!,
                Colors.grey[300]!,
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        );
      },
    );
  }
}

// Alternative simpler skeleton without animation
class SimpleSkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SimpleSkeletonBox({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

// Card-style skeleton loader
class SkeletonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title skeleton
            SkeletonBox(
              width: double.infinity,
              height: 20,
            ),
            SizedBox(height: 12),
            // Image skeleton
            SkeletonBox(
              width: double.infinity,
              height: 200,
              borderRadius: 8,
            ),
            SizedBox(height: 12),
            // Description skeleton
            SkeletonBox(
              width: double.infinity,
              height: 16,
            ),
            SizedBox(height: 8),
            SkeletonBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 16,
            ),
            SizedBox(height: 8),
            SkeletonBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}