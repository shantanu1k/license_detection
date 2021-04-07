import 'package:license_detection/licenses/OriginalLicenses.dart';
import 'package:license_detection/src/license_matching.dart';
class MultipleLicense{
  // Function for multiple licenses
  void detectLicense(String foundLicense){
    String backup = foundLicense;foundLicense = "";
    bool consider = false;
    for(int i = 0;i<backup.length-1;i++){
      if(backup[i] == " "&&backup[i+1] == " "){
        consider = false;
      }
      else if(backup[i] == " "&&backup[i+1] != " "){
        consider = true;
      }
      // if(backup[i] != "\n"&&consider){
      //     foundLicense+=backup[i];
      // }
      if(consider){
        if(backup[i] == "\n"&& backup[i+1]!=" "){
          foundLicense += " ";
        }
        else if(backup[i] != "\n"){
          foundLicense+=backup[i];
        }
      }
      else if(backup[i] != "\n"&&!consider){
        if(backup[i]!= " "){
          foundLicense+=backup[i];
        }
      }
    }
    //print(foundLicense);
    //To access _matchpercent function
    LicenseMatching lm = LicenseMatching();
    //Instance of class containing 'original license' as 'map'
    //Converted to lower case to avoid case sensitivity
    foundLicense = foundLicense.toLowerCase();
    String type = "BSD3";
    num match = 0;
    switch(type){
      case "BSD3":
        String trueFound = "";String knownLicense = "";String name = "";
        String end = "";String begin = "";
        BSD3 b = BSD3();
        b.data.forEach((key, value) {if(key == 'contents')knownLicense = value;});
        b.data.forEach((key, value) {if(key == 'name')name = value;});
        b.data.forEach((key, value) {if(key == 'begins_with')begin = value;});
        b.data.forEach((key, value) {if(key == 'ends_with')end = value;});
        begin = begin.toLowerCase();end = end.toLowerCase();
        if(foundLicense.indexOf(begin) != -1 && foundLicense.lastIndexOf(end)+end.length != -1)
          for(int i = foundLicense.indexOf(begin);i<(foundLicense.lastIndexOf(end)+end.length);i++){
            trueFound += foundLicense[i];
          }
        //returns % match
        match = lm.matchpercent(knownLicense, trueFound);
        print("${match.toStringAsPrecision(4)}% match with '$name'");
        continue mit;
      mit:
      case "MIT":
        String trueFound = "";String knownLicense = "";String name = "";
        String end = "";String begin = "";
        MIT m = MIT();
        m.data.forEach((key, value) {if(key == 'contents')knownLicense = value;});
        m.data.forEach((key, value) {if(key == 'name')name = value;});
        m.data.forEach((key, value) {if(key == 'begins_with')begin = value;});
        m.data.forEach((key, value) {if(key == 'ends_with')end = value;});
        begin = begin.toLowerCase();end = end.toLowerCase();
        if(foundLicense.indexOf(begin) != -1 && foundLicense.lastIndexOf(end)+end.length != -1)
          for(int i = foundLicense.indexOf(begin);i<(foundLicense.lastIndexOf(end)+end.length);i++){
            trueFound += foundLicense[i];
          }
        match = lm.matchpercent(knownLicense, trueFound);
        print("${match.toStringAsPrecision(4)}% match with '$name'");
        continue apache2;
      apache2:
      case "apache2":
        String trueFound = "";String knownLicense = "";String name = "";
        String end = "";String begin = "";
        Apache2 apache2 = Apache2();
        apache2.data.forEach((key, value) {if(key == 'contents')knownLicense = value;});
        apache2.data.forEach((key, value) {if(key == 'name')name = value;});
        apache2.data.forEach((key, value) {if(key == 'begins_with')begin = value;});
        apache2.data.forEach((key, value) {if(key == 'ends_with')end = value;});
        begin = begin.toLowerCase();end = end.toLowerCase();
        if(foundLicense.indexOf(begin) != -1 && foundLicense.lastIndexOf(end)+end.length != -1)
          for(int i = foundLicense.indexOf(begin);i<(foundLicense.lastIndexOf(end)+end.length);i++){
            trueFound += foundLicense[i];
          }
        match = lm.matchpercent(knownLicense, trueFound);
        print("${match.toStringAsPrecision(4)}% match with '$name'");
        continue bsd2;
      bsd2:
      case "BSD2":
        String trueFound = "";String knownLicense = "";String name = "";
        String end = "";String begin = "";
        BSD2 bsd2 = BSD2();
        bsd2.data.forEach((key, value) {if(key == 'contents')knownLicense = value;});
        bsd2.data.forEach((key, value) {if(key == 'name')name = value;});
        bsd2.data.forEach((key, value) {if(key == 'begins_with')begin = value;});
        bsd2.data.forEach((key, value) {if(key == 'ends_with')end = value;});
        begin = begin.toLowerCase();end = end.toLowerCase();
        if(foundLicense.indexOf(begin) != -1 && foundLicense.lastIndexOf(end)+end.length != -1)
          for(int i = foundLicense.indexOf(begin);i<(foundLicense.lastIndexOf(end)+end.length);i++){
            trueFound += foundLicense[i];
          }
        //print(trueFound);
        match = lm.matchpercent(knownLicense, trueFound);
        print("${match.toStringAsPrecision(4)}% match with '$name'");
        continue gpl3;
      gpl3:
      case "GPL3":
        String trueFound = "";String knownLicense = "";String name = "";
        String end = "";String begin = "";
        GPL3 gpl3 = GPL3();
        gpl3.data.forEach((key, value) {if(key == 'contents')knownLicense = value;});
        gpl3.data.forEach((key, value) {if(key == 'name')name = value;});
        gpl3.data.forEach((key, value) {if(key == 'begins_with')begin = value;});
        gpl3.data.forEach((key, value) {if(key == 'ends_with')end = value;});
        begin = begin.toLowerCase();end = end.toLowerCase();
        if(foundLicense.indexOf(begin) != -1 && foundLicense.lastIndexOf(end)+end.length != -1)
          for(int i = foundLicense.indexOf(begin);i<(foundLicense.lastIndexOf(end)+end.length);i++){
            trueFound += foundLicense[i];
          }
        //print(trueFound);
        match = lm.matchpercent(knownLicense, trueFound);
        print("${match.toStringAsPrecision(4)}% match with '$name'");
      continue mpl2;
      mpl2:
      case "mpl2":
        String trueFound = "";String knownLicense = "";String name = "";
        String end = "";String begin = "";
        MPL2 mpl2 = MPL2();
        mpl2.data.forEach((key, value) {if(key == 'contents')knownLicense = value;});
        mpl2.data.forEach((key, value) {if(key == 'name')name = value;});
        mpl2.data.forEach((key, value) {if(key == 'begins_with')begin = value;});
        mpl2.data.forEach((key, value) {if(key == 'ends_with')end = value;});
        begin = begin.toLowerCase();end = end.toLowerCase();
        if(foundLicense.indexOf(begin) != -1 && foundLicense.lastIndexOf(end)+end.length != -1)
          for(int i = foundLicense.indexOf(begin);i<(foundLicense.lastIndexOf(end)+end.length);i++){
            trueFound += foundLicense[i];
          }
        //print(trueFound);
        match = lm.matchpercent(knownLicense, trueFound);
        print("${match.toStringAsPrecision(4)}% match with '$name'");
        continue epl2;
      epl2:
      case "epl2":
        String trueFound = "";String knownLicense = "";String name = "";
        String end = "";String begin = "";
        EPL2 epl2 = EPL2();
        epl2.data.forEach((key, value) {if(key == 'contents')knownLicense = value;});
        epl2.data.forEach((key, value) {if(key == 'name')name = value;});
        epl2.data.forEach((key, value) {if(key == 'begins_with')begin = value;});
        epl2.data.forEach((key, value) {if(key == 'ends_with')end = value;});
        begin = begin.toLowerCase();end = end.toLowerCase();
        if(foundLicense.indexOf(begin) != -1 && foundLicense.lastIndexOf(end)+end.length != -1)
          for(int i = foundLicense.indexOf(begin);i<(foundLicense.lastIndexOf(end)+end.length);i++){
            trueFound += foundLicense[i];
          }
        match = lm.matchpercent(knownLicense, trueFound);
        print("${match.toStringAsPrecision(4)}% match with '$name'");
    }
  }  
}
void main(){
  String mylicense = '''

Copyright (c) Microsoft Corporation

All rights reserved. 

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


  ''';

  MultipleLicense ml = MultipleLicense();
  ml.detectLicense(mylicense);
}
