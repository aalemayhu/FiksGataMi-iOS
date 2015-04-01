#import "EditViewController.h"

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void) configure {
    [[self view] setBackgroundColor:[UIColor brownColor]];
    [[self navigationItem] setHidesBackButton:NO];
}

@end
