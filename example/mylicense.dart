import 'package:license_detection/licenses/MIT.dart';
import 'package:license_detection/src/license_matching.dart';
class MyLicense{
  //This is MIT License
  //My modification is on line 22 and copyright notice
  //Comment on line 15
  String mylicense = '''
    Copyright (c) 2021 Shantanu Kawade.
    Permission is hereby granted, free of charge, to any person obtaining a copy 
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights 
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
  # This code commented line will be ignored anyway
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
  //Instance of class containing 'MIT' license
  MIT mit = MIT();
  //Instance of class containing license comparing function
  LicenseMatching lm = LicenseMatching();
  String knownlicense = "";
  //Getting the known license from class
  mit.data.forEach((key, value) {if(key == 'contents')knownlicense = value;});
  String foundlicense = mine.mylicense;
  //Calculating the % similarity
  print(lm.matchpercent(knownlicense, foundlicense));
}
// Actual output:

// [Running] dart "d:\parse\New\license_detection\example\mylicense.dart"
// Total matches = 158 out of 164
// 95.76% 
// Unmatched words: [(c), 2021, shantanu, kawade., shantanu, kawade]

// [Done] exited with code=0 in 2.557 seconds
  
 

