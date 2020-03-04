/**
 * @param {number} x
 * @return {boolean}
 */
var isPalindrome = function(x) {
    if (x < 0) {
        return false;
    }
    if (x % 10 == 0 && x != 0) {
        return false;
    }
    if (x < 10) {
        return true;
    }
    let mX = mirrored(x);
    return mX === x;
};

// https://stackoverflow.com/a/3081328

var mirrored = function(x) {
    let y = x;
    y = 0;
    let tmp = x;
    while (tmp > 0) {
        y = y * 10 + tmp % 10;
        tmp = Math.floor(tmp / 10);
    }

    return y;
};

// Determine whether an integer is a palindrome. An integer is a palindrome when it reads the same backward as forward.
/* 
Input: -121
Output: false
Input: 121
Output: true
*/

let array = [121, -121, 125];
// https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Global_Objects/Array/map
let results = array.map((val)=>{  
    return isPalindrome(val); 
});
results.forEach((value, index)=>{
    console.log('test ' + array[index] + ': ' + isPalindrome(value));
});
array.forEach((value, index)=>{
    console.log(value + ' mirrored value: ' + mirrored(value));
});