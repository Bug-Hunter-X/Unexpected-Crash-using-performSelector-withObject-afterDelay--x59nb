In Objective-C, a rare but impactful bug can arise from the misuse of `performSelector:withObject:afterDelay:`.  If the object whose selector is being performed is deallocated before the delay expires, a crash will occur. This is because the selector is invoked on a nonexistent object.

Example of buggy code:

```objectivec
@interface MyClass : NSObject
@property (nonatomic, strong) NSString *someString;
@end

@implementation MyClass
- (void)someMethod {
    [self performSelector:@selector(delayedMethod) withObject:nil afterDelay:2.0];
}

- (void)delayedMethod {
    NSLog(@"Some string: %@
", self.someString);
}

- (void)dealloc {
    NSLog(@"MyClass deallocated");
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MyClass *obj = [[MyClass alloc] init];
        obj.someString = @"Hello";
        [obj someMethod];
        obj = nil; // Deallocation happens here
    }
    return 0;
}
```

This code will likely crash after 2 seconds.