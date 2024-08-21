import 'package:flutter/material.dart';

class Resp extends StatelessWidget {
  const Resp({super.key, required this.prompt, required this.response});

  final String? prompt, response;

  @override
  Widget build(BuildContext context) {
    List<Text> widgets = [
      Text(
        'Prompt: $prompt',
        style: const TextStyle(fontSize: 20),
      ),
      Text(
        'Response:\n  $response',
        style: const TextStyle(fontSize: 20),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Response'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return widgets[index];
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
            itemCount: 2),
      ),
    );
  }
}
