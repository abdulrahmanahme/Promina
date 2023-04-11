


import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:promina/model/data_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


Widget defaultFormField({
  required TextEditingController? controller,
   TextInputType? type,
  ValueChanged<String>? onSubmit,
  FormFieldValidator<String>? onChange,
  bool isPassword = false,
  required String? Function(String?)? validate,
  String? label,
   IconData? prefix,
  TextStyle? style,
  IconData? suffix,
  Function? suffixpress,
  Widget? suffixIcon,
  int maxLines =1,
  String? hintText,
}) =>
    Padding(
      padding: const EdgeInsets.only(left: 4,right: 4,),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        onFieldSubmitted: onSubmit,
        maxLines: maxLines,
        
        
  

        validator: 
          validate!,
        
        style: style,
        decoration: InputDecoration(
           fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(color: Color(0xff9D9491),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),

       
hintText: hintText,
          suffixIcon: suffixIcon,

          focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,

                  // borderSide: BorderSide(
                  //   color:   Colors.blueGrey.shade900,
                  //   width: 3.0,
                  // ),
                ),
          
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90.0),

                    borderSide: BorderSide.none,
          
            
          ),
        ),
      ),
    );
void navigateAndFinish(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}
class ButtonIcon extends StatelessWidget {
 ButtonIcon({
     this.textcolor,
    this.text,
    this.function,
    this.asset,
    this.heroTag,
    this.colorbutton,
    Key? key,
  }) : super(key: key);
     Color?textcolor;
     Color?colorbutton;

  String ? text;
void Function()? function;
  String ? asset;
  Object? heroTag;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: FloatingActionButton.extended(
        heroTag: heroTag,
  label: Text(text!,
   style: TextStyle(
          fontSize: 18.sp,
          // fontWeight: FontWeight.bold,
          color:textcolor,
        ),
  
  ), // <-- Text
  backgroundColor: colorbutton,
  icon: Tab(
    child: Image.asset(asset!)
  ),
  onPressed: function,
),
    );
  }
}

Widget dialog({void Function()? function1,void Function()? function2}){
  return Dialog(
  
  backgroundColor: Colors.white.withOpacity(.5),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)), //this right here
  child: ClipRect(
    
                  child: BackdropFilter(
                    filter:ImageFilter.blur(sigmaX: .8,sigmaY: .8) ,
                    child: Container(
                      height: Device.orientation == Orientation.portrait? 22.h:49.h,
                      width: Device.orientation == Orientation.portrait? 50.w:60.w,
                      //  color: Colors.white.withOpacity(.8),
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(18),
                      //  decoration: ,
                      decoration: BoxDecoration(
                        // color: Colors.white.withOpacity(.3),
                        // color: Color(0xffFFFFFF),
                  
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            ButtonIcon(heroTag: 'tag 3',asset:'assets/images/image.png' ,textcolor:Color(0xff4A4A4A),colorbutton: Color(0xffefd8f9),text:'Gellary' ,function:function1,
  ),

  ButtonIcon(heroTag: 'tag 4',asset:'assets/images/camera.png' ,textcolor:Color(0xff4A4A4A),colorbutton: Color(0xffebf6ff),text:'Camera' ,function: function2,
  
),
                //      
                        ],
                      ),
                    ),
                  ),
                ),
);



}



 class CardWidget extends StatefulWidget {
  CardWidget({this.image, Key? key}): super(key: key);
  
  String? image;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return 
    // Container(
    //                                   width: 80,
    //                                   height: 80,
    //                                   decoration: BoxDecoration(
    //                                     borderRadius: BorderRadius.circular(10),
    //                                     color: Colors.white,
    //                                     image: DecorationImage(
    //                                       image: NetworkImage(widget.image!
    //                                                ),
    //                                       fit: BoxFit.cover,
    //                                     ),
    //                                   ),
    //                                 );
    Container(
        height:10,
    width: 10.w,
      decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
       
          image: DecorationImage(

            image:NetworkImage(widget.image!),

          //  image: AssetImage(widget.image!),
            fit: BoxFit.cover,
          ),
         ),
    );
  }
}

 Widget cardPlant({String? image,BuildContext? context}){
  return GestureDetector(
      onTap: () {
      
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child:
            // isloading
            //     ? SpinKitFadingCircle(
            //         color: Color(0xffFF4500),
            //       )
            //     :
            Container(
          // height: displayHeight(context!) * 76,

          // width: displayWidth(context) * .9,
          height: 250,
          width: 200,

          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 1, bottom: 10, left: 15, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        
 image==''?
                        Container(
                          height: 140.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:NetworkImage(image!),
                                  // AssetImage('assets/image/Background.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )
                        :
                        Container(
              height: 120,
              width: 110,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/image.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),

                      ],
                    ),
                  ),
                 
                ],
                
              ),
            ),
          ),
        ),
      ),
    );
}