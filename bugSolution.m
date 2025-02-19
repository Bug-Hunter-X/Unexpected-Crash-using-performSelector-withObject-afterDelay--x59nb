To fix this, use techniques that prevent the selector from being called after the object has been deallocated. Here's a solution using `NSTimer`:

```objectivec
@interface MyClass : NSObject
@property (nonatomic, strong) NSString *someString;
@end

@implementation MyClass
- (void)someMethod {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(delayedMethod) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes]; //Important for UI responsiveness
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
This approach ensures that the timer remains associated with the object’s lifecycle, preventing crashes.