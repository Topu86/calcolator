import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
class cal extends StatefulWidget {
  const cal({Key? key}) : super(key: key);

  @override
  _calState createState() => _calState();
}

class _calState extends State<cal> {
String equation='0';
String result='0';
String expression='';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue,
                  Colors.deepPurpleAccent,
                  Colors.red])
          ),
        ),
        title: Text('Calculator'),
      centerTitle: true,),
      backgroundColor: Colors.grey[300],
      body: Column(
            children: [
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width*.05,
                  vertical: size.height*.12
                ),
                alignment: Alignment.bottomRight,
                child: Text(equation,
                  style: TextStyle(fontSize: size.height*.05),maxLines: 1,),
              ),
              Divider(),
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width*.05,
                    vertical: size.height*.02
                ),
                alignment: Alignment.bottomRight,
                child: Text(result,
                  style: TextStyle(fontSize: size.height*.05),maxLines: 1,),
              ),
              Divider(),
      Row(
        children: <Widget>[
        Container(
          width: size.width*.75,
          child: Table(
            children: [
              TableRow(
                children: [
                   buildBtn('C',1.0,Colors.transparent,Colors.white),
                  buildBtn('AC',1.0,Colors.transparent,Colors.white),
                  buildBtn('÷',1.0,Colors.transparent,Colors.white),
                ]
              ),
              TableRow(
                  children: [
                    buildBtn('7',1.0,Colors.transparent,Colors.white),
                    buildBtn('8',1.0,Colors.transparent,Colors.white),
                    buildBtn('9',1.0,Colors.transparent,Colors.white),
                  ]
              ),
              TableRow(
                  children: [
                    buildBtn('4',1.0,Colors.transparent,Colors.white),
                    buildBtn('5',1.0,Colors.transparent,Colors.white),
                    buildBtn('6',1.0,Colors.transparent,Colors.white),
                  ]
              ),
              TableRow(
                  children: [
                    buildBtn('1',1.0,Colors.transparent,Colors.white),
                    buildBtn('2',1.0,Colors.transparent,Colors.white),
                    buildBtn('3',1.0,Colors.transparent,Colors.white),
                  ]
              ),
              TableRow(
                  children: [
                    buildBtn('.',1.0,Colors.transparent,Colors.white),
                    buildBtn('0',1.0,Colors.transparent,Colors.white),
                    buildBtn('00',1.0,Colors.transparent,Colors.white),
                  ]
              ),
            ],
          ),
        ),
          Container(
            width: size.width*.25,
            child: Table(
              children: [
                TableRow(
                    children: [
                      buildBtn('×',1.0,Colors.transparent,Colors.white),]),
                TableRow(
                    children: [
                      buildBtn('+',1.0,Colors.transparent,Colors.white),]),
                TableRow(
                    children: [
                      buildBtn('-',1.0,Colors.transparent,Colors.white),]),
                TableRow(
                    children: [
                      buildBtn('=',2.3,Colors.blueGrey,Colors.white),]),

              ],
            ),
          )
            ],
    )
            ]
      )
    );
  }
  Widget buildBtn(String btnText,double btnHeight,Color btnColor,Color btnTxtColor){
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.07*btnHeight,

      margin: EdgeInsets.symmetric(horizontal: size.width*.002,vertical: size.height*0.001),
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(size.height*0.03)
      ),
      child:  FlatButton(onPressed: (){
        setState(() {
          if(btnText=='C'){
            equation='0';
            result='0';

          }
          else if(btnText=='AC'){
            equation=equation.substring(0,equation.length-1);
            if(equation==''){
              equation='0';
            }
          }
          else if(btnText=='='){
            expression=equation;
            expression=expression.replaceAll('÷', '/');
            expression=expression.replaceAll('×', '*');
            try{
              Parser P=Parser();
              Expression exp=P.parse(expression);
              ContextModel cm=ContextModel();
              result='${exp.evaluate(EvaluationType.REAL, cm)}';
            }
            catch(error){
              result='error';
            }
          }
          else{
            if(equation=='0'){
              equation=btnText;
            }
            else{
              equation=equation+btnText;
            }
          }
        });
      },
          child: Text(btnText,style: TextStyle(fontSize: size.height*.05),)),
    );
  }
}
