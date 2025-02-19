# Objective-C `performSelector` Delay Crash

This repository demonstrates a common but subtle bug in Objective-C related to the use of `performSelector:withObject:afterDelay:` and the potential for crashes due to object deallocation.

## Bug Description
The issue occurs when you use `performSelector:withObject:afterDelay:` to schedule a selector on an object that is deallocated before the delay expires.  Because the object no longer exists, the selector call will result in a crash.

## How to Reproduce
1. Clone this repository.
2. Open `bug.m` which contains the buggy code.
3. Compile and run the code.
4. Observe the crash after approximately 2 seconds.

## Solution
The provided `bugSolution.m` demonstrates how to solve the problem by using a timer or weak references.  Refer to the solution for safer, more robust implementations.