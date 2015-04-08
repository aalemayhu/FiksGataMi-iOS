#import "MainViewController.h"
#import "GlobalStrings.h"
#import "EditViewController.h"
#import "ViewUtil.h"
#import <AVFoundation/AVFoundation.h>
#import "CamUtil.h"

#define IMAGE_VIEW_TAG 2007
#define REPORT_FIELD_TAG 2009

@interface MainViewController ()

@end

@implementation MainViewController

- (void)configure {
  [super configure];
  [self setTitle:MAIN_VIEW_CONTROLLER_TITLE];
  cam = [CamUtil ready:self];
  [self configureSubviews];
}

- (void)configureSubviews {
  [[self navigationItem]
      setRightBarButtonItem:[[UIBarButtonItem alloc]
                                initWithTitle:@"Rapporter"
                                        style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(pressedReportItem)]];

  [[self navigationItem]
      setLeftBarButtonItem:[[UIBarButtonItem alloc]
                               initWithTitle:@"Rediger"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(pressedEditItem)]];
  [self configureImageView];
  [self configureTitleField];
  [self configureToolbar];
}

- (void)configureTitleField {
  [ViewUtil createTextField:AAFormFieldMake(REPORT_FIELD_TAG, @"Titel",
                                            [delegate valueForKey:KEY_TITLE])
                    forView:self.view
                   delegate:self];
  UITextField* titleField =
      (UITextField*)[[self view] viewWithTag:REPORT_FIELD_TAG];
  UIView* imageView = [[self view] viewWithTag:IMAGE_VIEW_TAG];
  titleField.frame =
      CGRectMake(titleField.frame.origin.x,
                 imageView.frame.origin.y - titleField.frame.size.height*1.5,
                 titleField.frame.size.width, titleField.frame.size.height);
}

- (void)configureToolbar {
  [[self navigationController] setToolbarHidden:NO];
  NSMutableArray* items = [NSMutableArray new];
  [items addObject:[[UIBarButtonItem alloc]
                       initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                            target:cam
                                            action:@selector(showCamera)]];
  [items addObject:
             [[UIBarButtonItem alloc]
                 initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil
                                      action:nil]];
  [items addObject:[[UIBarButtonItem alloc]
                       initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                            target:cam
                                            action:@selector(showGallery)]];
  [self setToolbarItems:items animated:YES];
}

- (void)configureImageView {
  CGSize winSize = self.view.frame.size;
  UIImageView* imageView = [[UIImageView alloc]
      initWithFrame:CGRectMake(0, winSize.width * 0.4, winSize.width,
                               winSize.height / 2)];
  [imageView setTag:IMAGE_VIEW_TAG];
  [imageView setContentMode:UIViewContentModeScaleAspectFit];
  [imageView setBackgroundColor:[UIColor redColor]];
  [[self view] addSubview:imageView];
  [imageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (void)pressedReportItem {
  NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)pressedEditItem {
  [[self navigationController] presentViewController:[EditViewController new]
                                            animated:YES
                                          completion:nil];
}

#pragma mark - CamUtilDelegate

- (void)imageSelected:(UIImage*)image {
  UIImageView* imageView =
      (UIImageView*)[[self view] viewWithTag:IMAGE_VIEW_TAG];
  [imageView setImage:image];
  [imageView setBackgroundColor:[UIColor clearColor]];
}


-(UINavigationController *) controller {
    return self.navigationController;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
  [textField resignFirstResponder];
  [delegate setValue:KEY_TITLE forKeyPath:textField.text];
  return YES;
}

@end
