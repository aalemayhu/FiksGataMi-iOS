#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol CamUtilDelegate
@required
-(void) imageSelected:(UIImage *)image;
-(UINavigationController *) controller;
@end

@interface CamUtil : NSObject<UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    id<CamUtilDelegate>_delegate;
    AppDelegate *appDelegate;
}

-(id) initWithDelegate:(id<CamUtilDelegate>)delegate;
+(CamUtil *) ready:(id<CamUtilDelegate>)delegate;
-(void) showCamera;
-(void) showGallery;
@end