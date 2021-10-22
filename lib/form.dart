import 'package:flutter/material.dart';
import 'package:network_trial/network_helper.dart';

class DemoForm extends StatefulWidget {
  const DemoForm({Key? key}) : super(key: key);

  @override
  _DemoFormState createState() => _DemoFormState();
}

class _DemoFormState extends State<DemoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  bool _isLoading = false;
  postData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await NetworkUtil.postData(
          "https://jsonplaceholder.typicode.com/posts", _formData);

      setState(() {
        _isLoading = false;
      });
      print(result);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Success"),
          content: const Text("Data posted successfully"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Success"),
          content: const Text("Data posted successfully"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Form"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("title"),
                ),
                onSaved: (String? val) {
                  _formData['title'] = val;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("body"),
                ),
                onSaved: (String? val) {
                  _formData['body'] = val;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("userId"),
                ),
                onSaved: (String? val) {
                  _formData['userId'] = int.parse(val!);
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      child: const Text("Submit"),
                      onPressed: postData,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
