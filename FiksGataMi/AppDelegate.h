#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void) storeDetails:(NSString *) fullname email:(NSString *)email;
-(NSString *) valueForKey:(NSString *)key;

@end

