library license_detection;

import 'EquivalentWords.dart';
class LicenseDetection{
  //Function for comparing 'known' and 'found' licenses
  String matchpercent(String knownLicense,String foundLicense){
    //Converting to lowercase because of case sensitivity
    knownLicense = knownLicense.toLowerCase();
    foundLicense = foundLicense.toLowerCase();
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
      if(knownLicense[i] == " "|| knownLicense[i] == "\n"){
        //Not including empty characters
        if(temp!="") known.add(temp);
        temp = "";
      }
    }
    temp = "";  //Using the same variable from line 9
    //Storing the actual keywords in list from found license
    for(int i = 0;i<foundLicense.length;i++){
      //Avoiding adding whitespace, comma, newline characters to list
      if(foundLicense[i] != " " && foundLicense[i] != "\n" && foundLicense[i] != ","){
        temp += foundLicense[i];
      }
      //If we encounter any whitespace or a newline then add keyword stored in 'temp' to list
      if(foundLicense[i] == " "|| foundLicense[i] == "\n"){
        //Not including empty characters
        if(temp!="") found.add(temp);
        temp = "";
      }
    }
    //Finding the keywords that are present in both known and found license
    for(int i = 0;i<found.length;i++){
      if(known.contains(found.elementAt(i))){
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
    // print(known);
    // print(found);
    print("Total matches = $matches out of ${found.length}");
    //Sørensen–Dice coefficient formula for actual match percentage
    //Just like the 'licensee' uses
    matches = 2*matches/(known.length+found.length);
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
