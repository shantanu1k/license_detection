# license_detection


 **Approach**
 
   * Instead of doing letter by letter comparison, I am doing comparison between words.
  
   * Created separate class for every original license instead putting them in one **BULKY** class
     (which is in custom format)

 **Usage** 
  
   * Clone this repo.
   
   ```Dart
   import 'package:license_detection/license_detction.dart';
   
   //If we want to detect a single license
   SingleMatching <object_name> = SingleMatching();
   //or multiple licenses
   MultipleMatching <object_name> = MultipleMatching();
   ```
   
   * We have to pass the license as 'String'. All that remain is to add the file handling and tarball functionality.

