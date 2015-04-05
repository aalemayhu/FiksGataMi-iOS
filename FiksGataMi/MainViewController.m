#import "MainViewController.h"
#import "GlobalStrings.h"
#import "EditViewController.h"

#define IMAGE_VIEW_TAG 2007

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void) configure {
    [self setTitle:MAIN_VIEW_CONTROLLER_TITLE];
    [self configureSubviews];
    [[self view] setBackgroundColor:[UIColor whiteColor]];
}

-(void) configureSubviews {
    [[self navigationItem] setRightBarButtonItem:
     [[UIBarButtonItem alloc]
      initWithTitle:@"Rapporter" style:UIBarButtonItemStylePlain
      target:self action:@selector(pressedReportItem)]];
    
    [[self navigationItem] setLeftBarButtonItem:
     [[UIBarButtonItem alloc]
      initWithTitle:@"Rediger" style:UIBarButtonItemStylePlain
      target:self action:@selector(pressedEditItem)]];

    [self configureImageView];
}

-(void) configureImageView {

    CGSize winSize = self.view.frame.size;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                              CGRectMake(0, winSize.width * 0.5, winSize.width, winSize.height/2)];
    [imageView setTag:IMAGE_VIEW_TAG];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setBackgroundColor:[UIColor redColor]];
    [[self view] addSubview:imageView];
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
