library license_detection;
class LicenseDetection{
  String matchpercent(String knownLicnese,String foundLicense){
    String temp = "";
    num matches = 0;
    Set<String> known = {};
    List<String> unmatched = [];
    Set<String> found = {};
    for(int i = 0;i<knownLicnese.length;i++){
      if(knownLicnese[i] != " " && knownLicnese[i] != "\n"){
        temp += knownLicnese[i];
      }
      if(knownLicnese[i] == " "|| knownLicnese[i] == "\n"){
        known.add(temp);
        temp = "";
      }
    }
    temp = "";
    for(int i = 0;i<foundLicense.length;i++){
      if(foundLicense[i] != " " && foundLicense[i] != "\n"){
        temp += foundLicense[i];
      }
      if(foundLicense[i] == " "|| foundLicense[i] == "\n"){
        found.add(temp);
        temp = "";
      }
    }
    for(int i = 0;i<found.length;i++){
      if(known.contains(found.elementAt(i))){
        matches++;
      }
      else{
        unmatched.add(found.elementAt(i));
      }
    }
    num m = matches;
    print(m);
    print("$known\n$found");
    matches = 2*matches/(known.length+found.length);
    return "${matches*100}% match\nUnmatched keywords = $unmatched";
  }
}