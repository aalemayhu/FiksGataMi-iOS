#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MainViewController.h"
#import "AppDelegate.h"
#import "GlobalStrings.h"

@interface FiksGataMiTests : XCTestCase {
    MainViewController *vc;
    AppDelegate *delegate;
}

@end

@implementation FiksGataMiTests

- (void)setUp {
    [super setUp];
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    vc = (MainViewController *) delegate.window.rootViewController;
}

- (void)tearDown {
    [super tearDown];
}

-(void) testMainViewControllerPresent {
    UIViewController *c = delegate.window.rootViewController;
    XCTAssert(![c isKindOfClass:[MainViewController class]]);
}

-(void) testMainViewControllerTitle {
    [self compareStrings:vc.title got:MAIN_VIEW_CONTROLLER_TITLE];
}

-(void) testMainViewControllerLeftNavigationItem {
    [self compareStrings:vc.navigationItem.leftBarButtonItem.title got:LEFT_NAVIGATION_ITEM];
}

-(void) testMainViewControllerRightNavigationItem {
    [self compareStrings:vc.navigationItem.rightBarButtonItem.title got:RIGHT_NAVIGATION_ITEM];
}


-(void) compareStrings:(NSString *)expected got:(NSString *)got {
    NSLog(@"Comparing %@ with %@", expected, got);
    XCTAssert([expected isEqual:got]);
}




@end
