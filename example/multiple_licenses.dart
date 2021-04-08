import 'package:license_detection/licenses/OriginalLicenses.dart';
import 'package:license_detection/src/license_matching.dart';
class MultipleLicense{
  String _comparableFormOf(String foundLicense){
    String backup = foundLicense;foundLicense = "";
    bool consider = false;  //Should consider whitespace or not?
    for(int i = 0;i<backup.length-1;i++){
      if(backup[i] == " "&&backup[i+1] == " "){
        consider = false;
      }
      else if(backup[i] == " "&&backup[i+1] != " "){
        consider = true;
      }
      if(backup[i] == "\n"&&backup[i+1]!=" "){
        foundLicense+=" ";
      }
      if(backup[i]!="\n" && consider){
        foundLicense+=backup[i];
      }
      else if(backup[i] != "\n"&&!consider){
        if(backup[i]!= " "){
          foundLicense+=backup[i];
        }
      }
    }
    consider = false;
    String f = foundLicense;foundLicense = "";
    for(int i = 0;i<f.length-1;i++){
      if(f[i] == " "&&f[i+1] == " "){
        consider = false;
      }
      else if(f[i] == " "&&f[i+1] != " "){
        consider = true;
      }
      if(f[i]!="\n" && consider){
        foundLicense+=f[i];
      }
      else if(f[i] != "\n"&&!consider){
        if(f[i]!= " "){
          foundLicense+=f[i];
        }
      }
    }
    return foundLicense;
  }
  // Function for multiple licenses
  void detectLicense(String foundLicense){
    foundLicense = _comparableFormOf(foundLicense);
    print(foundLicense);
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



BSD-3-clause
        Copyright 2010 Pallets
        Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
        Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
        Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
        Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
        THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  ''';

  MultipleLicense ml = MultipleLicense();
  ml.detectLicense(mylicense);
}

/*
Output
[Running] dart "d:\parse\New\license_detection\example\multiple_licenses.dart"
97.92% match with 'BSD 3-Clause 'New' or 'Revised' License'
97.56% match with 'MIT License'
0.000% match with 'Apache License 2.0'
91.04% match with 'BSD 2-Clause 'Simplified' License'
0.000% match with 'GNU General Public License v3.0 or later'
0.000% match with 'Mozilla Public License 2.0'
0.000% match with 'Eclipse Public License 2.0'

[Done] exited with code=0 in 2.162 seconds
*/