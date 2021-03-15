library license_detection;
class LicenseDetection{
  //Function for comparing 'known' and 'found' licenses
  String matchpercent(String knownLicnese,String foundLicense){
    //Created temperory variable to store keywords
    String temp = "";
    //Actual keyword matches in both known and found license
    num matches = 0;
    //Lists to store known,found license and unmatched keywords
    List<String> known = [];
    List<String> unmatched = [];
    List<String> found = [];
    //Storing the actual keywords in sets from known license
    for(int i = 0;i<knownLicnese.length;i++){
      if(knownLicnese[i] != " " && knownLicnese[i] != "\n"){
        temp += knownLicnese[i];
      }
      //Avoiding adding whitespace and newline characters
      if(knownLicnese[i] == " "|| knownLicnese[i] == "\n"){
        //Not including empty characters
        if(temp!="") known.add(temp);
        temp = "";
      }
    }
    temp = "";  //Using the same variable from line 5
    for(int i = 0;i<foundLicense.length;i++){
      if(foundLicense[i] != " " && foundLicense[i] != "\n"){
        temp += foundLicense[i];
      }
      //Avoiding adding whitespace and newline characters
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
        //Extra/unknown keywords in unmatched set
        unmatched.add(found.elementAt(i));
      }
    }
    num m = matches;
    print("Total matches = $m out of ${found.length}");
    //Sorensen-Dice algorithm formula for actual match percentage
    //Just like the 'licensee' uses
    matches = 2*matches/(known.length+found.length);
    return "${matches*100}% match\nUnmatched keywords = $unmatched";
  }
}
