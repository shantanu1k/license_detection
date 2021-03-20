library license_detection;
import 'EquivalentWords.dart';
class LicenseDetection{
  //Function for comparing 'known' and 'found' licenses
  String matchpercent(String knownLicense,String foundLicense){
    //Converting to lowercase because of case sensitivity
    //Need to add blank space unless algorithm won't consider last word :P
    knownLicense = knownLicense.toLowerCase() + " ";
    foundLicense = foundLicense.toLowerCase() + " ";
    //Created temperory variable to store keywords
    String temp = "";
    //Actual keyword matches in both known and found license
    num matches = 0;
    //Lists to store known,found license and unmatched keywords
    List<String> known = [];
    List<String> unmatched = [];
    List<String> found = [];
    //Storing the actual keywords in list from known license
    for(int i = 0;i<knownLicense.length;i++){
      //Avoiding adding whitespace, comma, newline characters to list
      if(knownLicense[i] != " " && knownLicense[i] != "\n" && knownLicense[i] != ","){
        temp += knownLicense[i];
      }
      //If we encounter any whitespace or a newline then add keyword stored in 'temp' to list
      else if(knownLicense[i] == " "|| knownLicense[i] == "\n"){
        //Not including empty characters
        if(temp!="") known.add(temp);
        temp = "";
      }
    }
    temp = "";  //Using the same variable from line 9
    bool isCommented = false;
    //Storing the actual keywords in list from found license
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
      //Avoiding adding whitespace, comma, code comment indicator, newline characters to list
      //and also if text is not commented
      if(foundLicense[i] != " " && foundLicense[i] != "\n" && foundLicense[i] != "," && foundLicense[i] != "#" && !isCommented){
        temp += foundLicense[i];
      }
      //If we encounter any whitespace or a newline then add keyword stored in 'temp' to list
      else if(foundLicense[i] == " "|| foundLicense[i] == "\n"){
        //Not including empty characters
        if(temp!="") found.add(temp);
        temp = "";
      }
    }
    //Keeping backup of both licenses
    var trueFoundLength = found.length;
    var trueknownLength = known.length;
    print(known);
    print(found);
    //Finding the keywords that are present in both known and found license
    for(int i = 0;i<found.length;i++){
      if(known.contains(found.elementAt(i))){
        //Quickly remove that word to avoid unecessary match afterwards
        known.remove(found.elementAt(i));
        //increment count
        matches++;
      }
      else{
        //Extra/unknown keywords in unmatched list
        unmatched.add(found.elementAt(i));
      }
    }
    //If unmatched keywords are from equivalent words mentioned in SPDX guidelines
    List<String> equivalent = unmatchedAnalysis(unmatched);
    //Adding in the count
    matches += equivalent.length;
    //Removing the equivalent keywords from unmatched list
    for(int i = 0;i<equivalent.length;i++){
      int j = 0;
      while(j<unmatched.length){
        if(equivalent.elementAt(i) == unmatched[j]){
          unmatched.remove(equivalent.elementAt(i));
        }
        j++;
      }
    }
    //if(trueFoundLength>trueknownLength)
      print("Total matches = $matches out of $trueFoundLength");
    // else  
    //   print("Total matches = $matches out of $trueknownLength");
    //Sørensen–Dice coefficient formula for actual match percentage
    //Just like the 'licensee' uses
    matches = 2*matches/(trueFoundLength+trueknownLength);
    return "${matches*100}% match\nUnmatched keywords = $unmatched";
  }
  //Function to check if unmatched keyword is from SPDX guidelines
  List<String> unmatchedAnalysis(List<String> unmatched){
    List<String> equivalent = [];
    //Instance of 'Equivalent' class
    EquivalentWords e = EquivalentWords();
    for(int i = 0;i<unmatched.length;i++){
      //Comparing key and value with unmatched keywords
      e.words.forEach((key, value) {
        if(unmatched[i] == key||unmatched[i] == value) equivalent.add(unmatched[i]);});
    }
    return equivalent;
  }
}
