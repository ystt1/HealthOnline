import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HealthCheckPage extends StatefulWidget {
  @override
  _HealthCheckPageState createState() => _HealthCheckPageState();
}

class _HealthCheckPageState extends State<HealthCheckPage> {
  final _formKey = GlobalKey<FormState>();
  String selectedApi = 'predict_a';


  final Map<String, TextEditingController> _predictAControllers = {
    'SGOT': TextEditingController(),
    'SGPT': TextEditingController(),
    'HDL-C': TextEditingController(),
    'LDL-C': TextEditingController(),
    'GGT': TextEditingController(),
    'Cre': TextEditingController(),
    'Uric': TextEditingController(),
    'HCT': TextEditingController(),
    'MCV': TextEditingController(),
    'LYM': TextEditingController(),
    'BachCauMono': TextEditingController(),
  };

  // Controllers for predict_b
  final Map<String, TextEditingController> _predictBControllers = {
    'Age': TextEditingController(),
    'Gender': TextEditingController(),
    'Total Bilirubin': TextEditingController(),
    'Direct Bilirubin': TextEditingController(),
    'Alkphos': TextEditingController(),
    'SGPT': TextEditingController(),
    'SGOT': TextEditingController(),
    'Total Proteins': TextEditingController(),
    'ALB': TextEditingController(),
    'A/G Ratio': TextEditingController(),
  };

  String? advice = "";
  double? probability;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final url = selectedApi == 'predict_a'
          ? 'http://127.0.0.1:5000/predict_a'
          : 'http://127.0.0.1:5000/predict_b';

      final inputData = selectedApi == 'predict_a'
          ? _predictAControllers.map((key, value) =>
          MapEntry(key, double.tryParse(value.text) ?? 0.0))
          : _predictBControllers.map((key, value) =>
          MapEntry(key, double.tryParse(value.text) ?? 0.0));

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(inputData),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            probability = data['probability'];
            advice = (data['advice'] as List).join("\n");
          });
        } else {
          setState(() {
            advice = "Có lỗi xảy ra: ${response.body}";
          });
        }
      } catch (e) {
        setState(() {
          advice = "Không thể kết nối đến server: $e";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controllers =
    selectedApi == 'predict_a' ? _predictAControllers : _predictBControllers;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dự đoán sức khỏe'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chọn API để dự đoán',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: Text('Predict A'),
                      value: 'predict_a',
                      groupValue: selectedApi,
                      onChanged: (value) {
                        setState(() {
                          selectedApi = value.toString();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text('Predict B'),
                      value: 'predict_b',
                      groupValue: selectedApi,
                      onChanged: (value) {
                        setState(() {
                          selectedApi = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Nhập các chỉ số sức khỏe của bạn',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ...controllers.keys.map((key) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          controller: controllers[key],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.health_and_safety),
                            labelText: key,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập $key';
                            }
                            if (double.tryParse(value) == null) {
                              return '$key phải là số hợp lệ';
                            }
                            return null;
                          },
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Dự đoán', style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 20),
              if (probability != null)
                Card(
                  elevation: 4,
                  color: Colors.teal.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          selectedApi == 'predict_a'
                              ? "Xác suất mắc bệnh về tim mạch, tiểu đường:"
                              : "Xác suất mắc bệnh gan:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        Text(
                          "${(probability! * 100).toStringAsFixed(2)}%",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (advice != null && advice!.isNotEmpty)
                Card(
                  elevation: 4,
                  color: Colors.orange.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lời khuyên:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          advice!,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
