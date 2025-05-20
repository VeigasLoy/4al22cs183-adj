/*3b. String Exercise progams
Q1. Write a Java Program for Checking if a given string is null or contains only whitespace using user
defined function isNullOrEmpty().
Q2. Write a Java Program for Counting how many times a substring appears in a main string
using user defined function countOccurrences()
Q3. Write a Java Program for Reversing the characters in a string using user defined function
reverseString().
Q4. Write a Java Program for Checking if a string reads the same backward as forward (ignoring case
and punctuation) using user defined function isPalindrome():
Q5. Write a Java Program for Eliminating all whitespace characters from a string using user defined
function removeWhitespace()
  */


package StringExcercise;

import java.util.Random;

public class StringExercises {

    // Q1: Check if string is null or empty
    public static boolean isNullOrEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    // Q2: Count how many times a substring appears
    public static int countOccurrences(String main, String sub) {
        int count = 0, index = 0;
        while ((index = main.indexOf(sub, index)) != -1) {
            count++;
            index += sub.length();
        }
        return count;
    }

    // Q3: Reverse a string
    public static String reverseString(String str) {
        return new StringBuilder(str).reverse().toString();
    }

    // Q4: Check if string is a palindrome (ignoring case and punctuation)
    public static boolean isPalindrome(String str) {
        str = str.replaceAll("[^a-zA-Z0-9]", "").toLowerCase();
        return str.equals(reverseString(str));
    }

    // Q5: Remove whitespace
    public static String removeWhitespace(String str) {
        return str.replaceAll("\\s", "");
    }
    // Test driver
    public static void main(String[] args) {
        System.out.println("Q1: isNullOrEmpty: " + isNullOrEmpty("   "));
        System.out.println("Q2: countOccurrences: " + countOccurrences("ababab", "ab"));
        System.out.println("Q3: reverseString: " + reverseString("AIET"));
        System.out.println("Q4: isPalindrome: " + isPalindrome("A man, a plan, a canal: Panama"));
        System.out.println("Q5: removeWhitespace: " + removeWhitespace(" AIET College "));
    }
}
