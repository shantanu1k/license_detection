library license_matching;
import 'EquivalentWords.dart';
import 'package:license_detection/licenses/OriginalLicenses.dart';
class MultipleMatching{
  //Function for comparing 'known' and 'found' licenses
  num _matchpercent(String knownLicense,String foundLicense){
    //Converting to lowercase because of case sensitivity
    //Need to add blank space unless algorithm won't consider the last word 
    knownLicense = knownLicense.toLowerCase() + " ";
    foundLicense = foundLicense.toLowerCase() + " ";
    //Created temperory variable to store words
    String temp = "";
    //Actual word matches in both known and found license
    num matches = 0;
    //List to store words from known/original license
    List<String> known = [];
    //List to store words from found/modified license which are not present in known/original license
    List<String> unmatched = [];
    //List to store words from found/modified license
    List<String> found = [];
    //Storing the actual words in list from known license
    for(int i = 0;i<knownLicense.length;i++){
      //Avoiding adding whitespace, comma, newline character to list
      if(knownLicense[i] != " " && knownLicense[i] != "\n" && knownLicense[i] != ","){
        temp += knownLicense[i];
      }
      //If we encounter any whitespace or a newline then add the word stored in 'temp' to 'known' list
      else if(knownLicense[i] == " "|| knownLicense[i] == "\n"){
        //Not including empty characters
        if(temp!="") known.add(temp);
        temp = "";
      }
    }
    temp = "";  //Using the same variable from line 9
    bool isCommented = false;
    //Storing the actual words in list from found license
    for(int i = 0;i<foundLicense.length;i++){
      //If we find code comment indicator(#) then we will
      //ignore the text appears afterwards
      if(foundLicense[i] == "#"){
        isCommented = true;
      }
      //If we find a newline then we will start considering text
      if(foundLicense[i] == "\n"){
        isCommented = false;
      }
      //Avoiding adding whitespace, comma, code comment indicator, newline character to list
      //and also if text is not commented
      if(foundLicense[i] != " " && foundLicense[i] != "\n" && foundLicense[i] != "," && foundLicense[i] != "#" && !isCommented){
        temp += foundLicense[i];
      }
      //If we encounter any whitespace or a newline character then add the word stored in 'temp' to 'found' list
      else if(foundLicense[i] == " "|| foundLicense[i] == "\n"){
        //Not including empty characters
        if(temp!="") found.add(temp);
        temp = "";
      }
    }
    //Keeping backup of both license lengths
    var trueFoundLength = found.length;
    var trueknownLength = known.length;
    // print(known);
    // print(found);
    //Finding the words that are present in both known and found license
    for(int i = 0;i<found.length;i++){
      if(known.contains(found.elementAt(i))){
        //Quickly remove that word to avoid unecessary match afterwards
        known.remove(found.elementAt(i));
        //increment count
        matches++;
      }
      else{
        //Add the extra/unknown words in unmatched list
        unmatched.add(found.elementAt(i));
      }
    }
    //If unmatched words are from equivalent words mentioned in SPDX guidelines
    List<String> equivalent = _unmatchedAnalysis(unmatched);
    //Adding in the count
    matches += equivalent.length;
    //Removing the equivalent words from unmatched list
    for(int i = 0;i<equivalent.length;i++){
      int j = 0;
      while(j<unmatched.length){
        if(equivalent.elementAt(i) == unmatched[j]){
          unmatched.remove(equivalent.elementAt(i));
        }
        j++;
      }
    }
    //Sørensen–Dice coefficient formula for actual match percentage
    //Just like the 'licensee' uses
    matches = (2*matches/(trueFoundLength+trueknownLength))*100;
    return matches;
  }
  //Function to check if unmatched word is from SPDX guidelines equivalent words
  List<String> _unmatchedAnalysis(List<String> unmatched){
    List<String> equivalent = [];
    //Instance of 'Equivalent' class
    EquivalentWords e = EquivalentWords();
    for(int i = 0;i<unmatched.length;i++){
      //Comparing key and value with unmatched words
      e.words.forEach((key, value) {
        if(unmatched[i] == key||unmatched[i] == value) equivalent.add(unmatched[i]);});
    }
    return equivalent;
  }
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
    //print(foundLicense);
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
        match = _matchpercent(knownLicense, trueFound);
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
        match = _matchpercent(knownLicense, trueFound);
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
        match = _matchpercent(knownLicense, trueFound);
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
        match = _matchpercent(knownLicense, trueFound);
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
        match = _matchpercent(knownLicense, trueFound);
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
        match = _matchpercent(knownLicense, trueFound);
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
        match = _matchpercent(knownLicense, trueFound);
        print("${match.toStringAsPrecision(4)}% match with '$name'");
    }
  }
}
