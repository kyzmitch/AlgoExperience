//
//  main.cpp
//  Fibonacci
//
//  Created by Andrey Ermoshin on 08/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

#include <iostream>
#include <map>

unsigned int slowFibonacci(unsigned int n) {
    if (n == 0) return 0;
    if (n == 1) return 1;
    unsigned int result = slowFibonacci(n - 1) + slowFibonacci(n - 2);
    return result;
}

unsigned int fibonacci(unsigned int n, std::map<unsigned int, unsigned int>& cache) {
    if (n == 0) return 0;
    if (n == 1) return 1;
    
    unsigned int n1;
    if (cache.find(n - 1) != cache.end()) {
        n1 = cache[n - 1];
    }
    else {
        n1 = fibonacci(n - 1, cache);
    }
    
    unsigned int n2;
    if (cache.find(n - 2) != cache.end()) {
        n2 = cache[n - 2];
    }
    else {
        n2 = fibonacci(n - 2, cache);
    }
    unsigned int result = n1 + n2;
    cache[n] = result;
    return result;
}

unsigned int cachedFibonacci(unsigned int n) {
    std::map<unsigned int, unsigned int> cache;
    
    return fibonacci(n, cache);
}





int main(int argc, const char * argv[]) {
    unsigned int n = 44;
    
    std::cout << "Fast Fibonacci number for " << n << " is " << cachedFibonacci(n) << std::endl;
    std::cout << "Slow Fibonacci number for " << n << " is " << slowFibonacci(n) << std::endl;
    
    return 0;
}
