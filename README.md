# license_detection

 **Approach**
 
   * Instead of doing letter by letter comparison, I am doing comparison between words.
 
 **Checklist**
 
   * Ignore the replacable text like organization name, bullet points,etc. which marked between ^text^ ✔
 
   * Ignore the copyright notice ✔

   * Ignore the line if '#(code comment indicator)' found at the start of the line. ✔




  **Things yet to be worked on:**

   * Extraneous Text At the End of a License

   * Handling multiple licenses in same file
