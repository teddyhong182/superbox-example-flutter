import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '비만도 계산기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BmiMain(),
    );
  }
}

class BmiMain extends StatefulWidget {
  const BmiMain({Key? key}) : super(key: key);

  @override
  State<BmiMain> createState() => _BmiMainState();
}

class _BmiMainState extends State<BmiMain> {
  // TextField 의 현잿값을 얻는 데 필요
  final _formKey = GlobalKey<FormState>(); // 폼의 상태를 얻기 위한 키

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  // 다 사용한 컨트롤러의 인스턴스는 반드시 화면이 종료될 때 해제해야 함!!
  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비만도 계산기'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // 폼
          key: _formKey, // 키 할당
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(  // 외곽선이 있고 힌트로 '키'를 표시
                  border: OutlineInputBorder(),
                  hintText: '키',
                ),
                controller: _heightController,
                keyboardType: TextInputType.number, // 숫자만 입력할 수 있음
                validator: (value) {
                  if (value!.trim().isEmpty) {  // 조건에 맞으면 에러 메시지 표시
                    return '키를 입력하세요.';
                  }
                  return null;  // null을 반환하면 에러가 없는 것임
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: InputDecoration(  // 외곽선이 있고 힌트로 '몸무게'를 표시
                  border: OutlineInputBorder(),
                  hintText: '몸무게',
                ),
                controller: _weightController,
                keyboardType: TextInputType.number, // 숫자만 입력할 수 있음
                validator: (value) {
                  if (value!.trim().isEmpty) {  // 조건에 맞으면 에러 메시지 표시
                    return '몸무게를 입력하세요.';
                  }
                  return null;  // null을 반환하면 에러가 없는 것임
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  onPressed: () {
                    // 폼에 입력된 값 검증
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BmiResult(
                                double.parse(_heightController.text.trim()),
                                double.parse(_weightController.text.trim())
                            ),
                        ),
                      );
                    }
                  },
                  child: Text('결과'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BmiResult extends StatelessWidget {
  final double height;
  final double weight;

  BmiResult(this.height, this.weight);  // 키와 몸무게를 받는 생성자

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('비만도 계산기'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '정상',
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(
              height: 16,
            ),
            Icon( //
              Icons.sentiment_satisfied,
              color: Colors.green,
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}
