
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new MaterialApp(
      title: 'Calculator',
      home: new CalculatorFragment(),
      );
  }  
}

class CalculatorFragment extends StatefulWidget {
CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<CalculatorFragment> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String text){
    setState(() {
      if(text == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(text == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(text == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }

      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = text;
        }else {
          equation = equation + text;
        }
      }
    });
  }

  Widget customRaisedButton(String text, Color backGroundColor, int flex, double aspectRatio) {
      return Expanded(
        child: AspectRatio(
          aspectRatio: aspectRatio, //Dimens Ratio to make square or rectangle view
          child: FractionallySizedBox ( //A widget that sizes its child to a fraction of the total available space
            widthFactor: 0.85, //Will  percentage of the width for Parent Widget
            heightFactor: 0.85, //Will  percentage of the height for Parent Widget
            child: new RaisedButton (
              child: FittedBox( // To auto size the child text widget.
                fit: BoxFit.fitWidth,
                child: Text (
                  text,
                  style: TextStyle (
                    fontSize:  30,
                    color: Colors.white //Text Color
                  ),
                ),
              ),
              onPressed: () => buttonPressed(text),
              color: backGroundColor, //Text Background Color
              shape: StadiumBorder(),//shape: CircleBorder(), //To make all widget corner curve
            ),
          )
        ),
        flex: flex, //Weight
      );
  }

  Widget customText(String text) {
    return Expanded( //To avoid overflowed pixels in your widget
      child: FittedBox( //Auto Size
        child: Text (
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.end,
        )
      )
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: new Column (
        mainAxisAlignment: MainAxisAlignment.end, //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  child: customText(" "),
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  child: customText(equation),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  child: customText(result),
                ),
              ],
            ),
          ),
          //SizedBox(height: 1,), //Spacer
          Expanded(
            child: Row (
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                customRaisedButton('C', const Color(0xFFA5A5A5),1,1),
                customRaisedButton('⌫', const Color(0xFFA5A5A5),1,1),
                customRaisedButton('%', const Color(0xFFFF9800),1,1),
                customRaisedButton('÷', Colors.orange,1,1),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                customRaisedButton('7', const Color(0xFF333333),1,1),
                customRaisedButton('8', const Color(0xFF333333),1,1),
                customRaisedButton('9', const Color(0xFF333333),1,1),
                customRaisedButton('×', Colors.orange,1,1),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                customRaisedButton('4', const Color(0xFF333333),1,1),
                customRaisedButton('5', const Color(0xFF333333),1,1),
                customRaisedButton('6', const Color(0xFF333333),1,1),
                customRaisedButton('-', Colors.orange,1,1),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                customRaisedButton('1', const Color(0xFF333333),1,1),
                customRaisedButton('2', const Color(0xFF333333),1,1),
                customRaisedButton('3', const Color(0xFF333333),1,1),
                customRaisedButton('+', Colors.orange,1,1),
              ],
            )
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                customRaisedButton('0', const Color(0xFF333333),2,2),
                customRaisedButton('.', const Color(0xFF333333),1,1),
                customRaisedButton('=', Colors.orange,1,1),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
   //_bloc.dispose(); // to avoid memory leaks
  }
}