import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gemini_app/resp.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GeminiHome(),
    );
  }
}

class GeminiHome extends StatefulWidget {
  const GeminiHome({super.key});

  @override
  State<GeminiHome> createState() => _GeminiHomeState();
}

class _GeminiHomeState extends State<GeminiHome> {
  final formKey = GlobalKey<FormState>();
  final apiform = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String apiKey = "";
    String prompt = "";
    String api = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Home'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Wrap(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      maxLength: 1500,
                      initialValue: prompt,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter prompt',
                        labelText: 'Prompt *',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a valid prompt.";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        prompt = value!;
                      },
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      initialValue: apiKey,
                      maxLength: 1500,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter API Key',
                        labelText: 'API Key *',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a valid API Key.";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        api = value!;
                      },
                    ),
                    TextButton(
                      child: const Text('Submit'),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          var content = [Content.text(prompt)];
                          apiKey = api;
                          var model = GenerativeModel(
                              model: 'gemini-1.5-pro-latest', apiKey: apiKey);
                          var response = await model.generateContent(content);

                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Resp(
                                  prompt: prompt,
                                  response: response.text,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
