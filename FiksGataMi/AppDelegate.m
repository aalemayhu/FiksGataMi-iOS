#import "AppDelegate.h"
#import "MainViewController.h"
#import "GlobalStrings.h"

@interface AppDelegate () {
    NSUserDefaults *userDefaults;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MainViewController *root = [[MainViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
    nav.delegate = self;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    userDefaults = [NSUserDefaults standardUserDefaults];

    return YES;
}

-(void) storeDetails:(NSString *) fullname email:(NSString *)email {
    [userDefaults setValue:fullname forKey:KEY_FULL_NAME];
    [userDefaults setValue:email forKey:KEY_EMAIL];
}

-(NSString *) valueForKey:(NSString *)key {
    return [userDefaults valueForKey:key];
}


@end
