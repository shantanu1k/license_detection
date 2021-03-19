# license_detection

 **Approach**
 
   * Instead of doing letter by letter comparison, I am doing comparison between words.
 
   * Ignore the replaceable text like organization name, bullet points,etc.
 
   * Ignore the copyright notice 

   * Ignore the line if '#(code comment indicator)' found at the start of the line. 


**Currently working on**

   * Ignoring the part of license whether it appears at start, middle or at the end.


  **Things yet to be worked on:**

   * Extraneous Text At the End of a License

   * Handling multiple licenses in same file
