#import <Foundation/Foundation.h>

@interface MyObservedObject : NSObject
@property (nonatomic, strong) NSString *observedProperty;
@end

@implementation MyObservedObject
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"observedProperty"];
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MyObservedObject *myObject = [[MyObservedObject alloc] init];
        [myObject addObserver:self forKeyPath:@"observedProperty" options:NSKeyValueObservingOptionNew context:NULL];
        myObject.observedProperty = @"NewValue";
    }
    return 0;
}

//OR using blocks for better memory management
[myObject addObserver:self forKeyPath:@"observedProperty" options:NSKeyValueObservingOptionNew context:NULL];
__weak typeof(myObject) weakObject = myObject;
[myObject addObserverForName:NSKeyValueObservingOptionNew object:myObject queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
      if(weakObject){
        //Access and modify properties if needed
      }
}];