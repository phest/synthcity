
#import "File.h"

#define kLatestIPhone 4

@implementation MyClass : NSObject

@synthesize x, y;

// Doesn't make any sense.

+ (void)nonSense
{
  [super init];
  
  stuff = [NSMutableArray new];
  
  float num = 10;
  
  if (true) num *= 10;
  else num /= 10;
  
  #if TARGET_OS_IPHONE  
  NSLog(@"hello iphone %i", kMyIphone);
  #endif
  
  return;
}

@end

