
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List poses = [];

  Future<void> fetchRunPoses() async {
    final response = await http.get(Uri.parse('http://yourserver.com/get_run_pose.php'));
    if (response.statusCode == 200) {
      setState(() {
        poses = json.decode(response.body);
      });
    }
  }

  Future<void> updateStatus(int id) async {
    await http.post(Uri.parse('http://yourserver.com/update_status.php'), body: {'id': id.toString()});
    fetchRunPoses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Run Poses')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: fetchRunPoses,
            child: Text('Get Run Poses'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: poses.length,
              itemBuilder: (context, index) {
                final pose = poses[index];
                return ListTile(
                  title: Text("Pose: ${pose['pose_data']}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => updateStatus(int.parse(pose['id'])),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
