#import <UIKit/UIKit.h>

@interface UIColor (ColorHexadecimal)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)

+ (UIColor *) colorWithHexString: (NSString *)color;

@end
