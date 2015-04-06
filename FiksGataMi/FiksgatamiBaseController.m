#import "FiksgatamiBaseController.h"

@implementation FiksgatamiBaseController

-(void) viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void) configure {
    [[self view] setBackgroundColor:[UIColor colorWithRed:0.533 green:0.694 blue:0.855 alpha:1.000]];
}
@end
