# license_detection

 **Approach**
 
   * Instead of doing letter by letter comparison, I am doing comparison between words.
 
   * Working on ignoring the replaceable text like organization name, bullet points,etc.
 
   * Ignored the copyright notice 

   * Ignored the line if '#(code comment indicator)' found at the start of the line. 


  **Things yet to be worked on:**
  
   * Comparing modified license with two or more licenses in single run.

   * Extraneous Text At the End of a License

   * Handling multiple licenses in same file
