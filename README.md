# license_detection

**There are lots of commits in this repo. Because, I have habit of commiting and pushing every time I make even a small change😅**

 **Approach**
 
   * Instead of doing letter by letter comparison, I am doing comparison between words.
  
   * Created separate class for every original license instead putting them in one **BULKY** class
     (which is in custom format)

 **Usage** 
  
   * Clone this repo. Since, this package is not published.
   
   ```Dart
   import 'package:license_detection/license_detction.dart';
   
   //If we want to detect a single license
   SingleMatching <object_name> = SingleMatching();
   //or multiple licenses
   MultipleMatching <object_name> = MultipleMatching();
   ```
   
   * We have to pass the license as 'String'. All that remain is to add the file handling and tarball functionality.

