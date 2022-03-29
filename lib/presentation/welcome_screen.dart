import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatapp/presentation/login_screen.dart';
import 'package:chatapp/presentation/registration_screen.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();

  
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

 late AnimationController controller;
 late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
    controller = AnimationController(
      
      duration: Duration(seconds: 2),

      vsync: this);
      animation = ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(controller);
      //animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
      controller.forward();
     /*controller.addStatusListener((status) {
       if(status ==AnimationStatus.completed){controller.reverse(from: 1.0);}
       else if (status ==AnimationStatus.dismissed){controller.forward();}
     });*/
      controller.addListener(() {
        setState(() {
          
        });
        print(animation.value);});
  }
  
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                SizedBox(
  width: 250.0,
  child: DefaultTextStyle(
    style: const TextStyle(
      fontSize: 39,
     
      fontWeight: FontWeight.w900,
      color: Colors.black
    ),
    child: AnimatedTextKit(
      pause: Duration(seconds: 3),
      animatedTexts: [
        TypewriterAnimatedText('Flash Chat', speed: Duration(milliseconds: 150)),
     
      ],
      onTap: () {
        print("Tap Event");
      },
    ),
  ),
)
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
           CustomButton(text: 'Log In', color: Colors.lightBlueAccent, onPressed:(){Navigator.pushNamed(context, LoginScreen.id);} ),
           CustomButton(text: 'Register', color: Colors.blue, onPressed:(){Navigator.pushNamed(context, RegistrationScreen.id);} ),
           
          ],
        ),
      ),
    );
  }
}