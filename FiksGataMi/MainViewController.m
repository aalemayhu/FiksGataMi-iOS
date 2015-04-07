#import "MainViewController.h"
#import "GlobalStrings.h"
#import "EditViewController.h"
#import "ViewUtil.h"
#import <AVFoundation/AVFoundation.h>

#define IMAGE_VIEW_TAG 2007
#define REPORT_FIELD_TAG 2009

@interface MainViewController ()

@end

@implementation MainViewController

- (void)configure {
  [super configure];
  [self setTitle:MAIN_VIEW_CONTROLLER_TITLE];
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
  UITextField *titleField =
      (UITextField *)[[self view] viewWithTag:REPORT_FIELD_TAG];
  UIView *imageView = [[self view] viewWithTag:IMAGE_VIEW_TAG];
  titleField.frame =
      CGRectMake(titleField.frame.origin.x,
                 imageView.frame.origin.y - titleField.frame.size.height,
                 titleField.frame.size.width, titleField.frame.size.height);
}

- (void)configureToolbar {

  [[self navigationController] setToolbarHidden:NO];
  NSMutableArray *items = [NSMutableArray new];
  [items addObject:[[UIBarButtonItem alloc]
                       initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                            target:self
                                            action:@selector(presentCam)]];
  [items addObject:
             [[UIBarButtonItem alloc]
                 initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil
                                      action:nil]];
  [items addObject:[[UIBarButtonItem alloc]
                       initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                            target:self
                                            action:@selector(presentGal)]];
  [self setToolbarItems:items animated:YES];
}

- (void)configureImageView {

  CGSize winSize = self.view.frame.size;
  UIImageView *imageView = [[UIImageView alloc]
      initWithFrame:CGRectMake(0, winSize.width * 0.5, winSize.width,
                               winSize.height / 2)];
  [imageView setTag:IMAGE_VIEW_TAG];
  [imageView setContentMode:UIViewContentModeScaleAspectFit];
  [imageView setBackgroundColor:[UIColor redColor]];
  [[self view] addSubview:imageView];
  [imageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth |
                                 UIViewAutoresizingFlexibleHeight];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark CAM/GAL actions

- (void)presentCam {
  // https://developer.apple.com/library/ios/documentation/AudioVideo/Conceptual/CameraAndPhotoLib_TopicsForIOS/Articles/TakingPicturesAndMovies.html
  if (![UIImagePickerController
             isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [[[UIAlertView alloc] initWithTitle:@"Feilmelding"
                                message:@"Kamera er ikke tilgjengelig."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
    return;
  }

  UIImagePickerController *c = [[UIImagePickerController alloc] init];
  c.sourceType = UIImagePickerControllerSourceTypeCamera;
  c.mediaTypes = [UIImagePickerController
      availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
  [c setAllowsEditing:YES];
  [c setDelegate:self];
  [[self navigationController] presentViewController:c
                                            animated:YES
                                          completion:nil];
}

- (void)presentGal {
  // TODO: Get image from gallery.
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

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
  UIImage *image =
      (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
  UIImageView *imageView =
      (UIImageView *)[[self view] viewWithTag:IMAGE_VIEW_TAG];
  [imageView setImage:image];
  [imageView setBackgroundColor:[UIColor clearColor]];
  [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [[picker parentViewController] dismissViewControllerAnimated:YES
                                                    completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  [delegate setValue:KEY_TITLE forKeyPath:textField.text];
  return YES;
}

@end
