#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FormModel.h"

@interface ViewUtil : NSObject
+ (void)createTextField:(struct AAFormField)field forView:(UIView *)view delegate:(id)delegate;
@end
