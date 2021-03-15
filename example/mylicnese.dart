import 'package:license_detection/License.dart';
import 'package:license_detection/license_detection.dart';
class MyLicense{
  //This is MIT License
  //My modification on line 21, col 5
  String mylicense = '''
    Copyright (c) 2021 Shantanu Kawade.
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
    Shantanu Kawade BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.''';
}
void main(){
  //Instance of current class
  MyLicense mine = MyLicense();
  //Instance of class containing 'known' license
  License l = License();
  //Instance of class containing license comparing function
  LicenseDetection ld = LicenseDetection();
  //Known licnese with copyright notice
  String license = ""; 
  String lookFrom = "";
  //Getting the value from which actual license start
  l.MIT.forEach((key, value) {if(key == 'Actual_license_starts_from') lookFrom = value;});
  //Getting the known license from class
  l.MIT.forEach((key, value) {if(key == 'contents')license = value;});
  //Storing the index of actual start of license(without copyright notice)
  var startingpoint = license.indexOf(lookFrom);
  //Known licnese without copyright notice
  String knownlicense = "";
  for(int i = startingpoint;i<license.length;i++){
    knownlicense += license[i];
  }
  //Neglecting the 'copyright' notice from 'found' license
  String foundlicense = "";
  startingpoint = mine.mylicense.indexOf(lookFrom);
  //Storing the 'found' license without 'copyright' notice
  for(int i = startingpoint;i<mine.mylicense.length;i++){
    foundlicense += mine.mylicense[i];
  }
  //Calculating the % similarity
  print(ld.matchpercent(knownlicense, foundlicense));

// Actual output:

//   [Running] dart "d:\parse\New\license_detection\example\mylicnese.dart"
//   Total matches = 156 out of 158
//   97.80564263322884% match
//   Unmatched keywords = [Shantanu, Kawade]

//   [Done] exited with code=0 in 2.497 seconds
 
}
