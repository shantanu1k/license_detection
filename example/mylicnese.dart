import 'package:license_detection/License.dart';
import 'package:license_detection/license_detection.dart';
class MyLicense{
  String mylicense = '''
  Copyright (c) [year] [fullname]
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
  String license = ""; 
  String lookFrom = "";
  l.MIT.forEach((key, value) {if(key == 'Actual_license_starts_from') lookFrom = value;});
  //Neglecting the 'copyright' notice from 'known' license
  l.MIT.forEach((key, value) {if(key == 'contents')license = value;});
  var startingpoint = license.indexOf(lookFrom);
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
  print(ld.matchpercent(knownlicense, foundlicense));
  //Actual output:  Total matches = 115
//                  97.87234042553192% match
//                  Unmatched keywords = [Shantanu, Kawade]   //Unmatched keywords are my name and surname :)
}