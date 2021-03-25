library license_matching;
import 'EquivalentWords.dart';
class LicenseMatching{
  //Function for comparing 'known' and 'found' licenses
  String matchpercent(String knownLicense,String foundLicense){
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
    print("Total matches = $matches out of $trueFoundLength");
    //Sørensen–Dice coefficient formula for actual match percentage
    //Just like the 'licensee' uses
    matches = (2*matches/(trueFoundLength+trueknownLength))*100;
    return "${matches.toStringAsPrecision(4)}% \nUnmatched words: $unmatched";
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
}
