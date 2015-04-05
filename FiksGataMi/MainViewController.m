#import "MainViewController.h"
#import "GlobalStrings.h"
#import "EditViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void) configure {
    [self setTitle:MAIN_VIEW_CONTROLLER_TITLE];
    [self configureItems];
    [[self view] setBackgroundColor:[UIColor whiteColor]];
}

-(void) configureItems {
    [[self navigationItem] setRightBarButtonItem:
     [[UIBarButtonItem alloc]
      initWithTitle:@"Rapporter" style:UIBarButtonItemStylePlain
      target:self action:@selector(pressedReportItem)]];
    
    [[self navigationItem] setLeftBarButtonItem:
     [[UIBarButtonItem alloc]
      initWithTitle:@"Rediger" style:UIBarButtonItemStylePlain
      target:self action:@selector(pressedEditItem)]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

-(void) pressedReportItem {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

-(void) pressedEditItem {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    EditViewController *e = [EditViewController new];
    [[self navigationController] presentViewController:e animated:YES completion:nil];
}

@end
