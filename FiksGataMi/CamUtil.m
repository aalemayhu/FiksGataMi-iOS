#import "CamUtil.h"

@implementation CamUtil

- (id)initWithDelegate:(id<CamUtilDelegate>)delegate {
  if (self = [super init]) {
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _delegate = delegate;
  }

  return self;
}

+ (CamUtil *)ready:(id<CamUtilDelegate>)delegate {
  return [[self alloc] initWithDelegate:delegate];
}

#pragma mark - Actions

- (void)showCamera {
  // https://developer.apple.com/library/ios/documentation/AudioVideo/Conceptual/CameraAndPhotoLib_TopicsForIOS/Articles/TakingPicturesAndMovies.html
  if (![UIImagePickerController
          isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [appDelegate presentErrorWithMessage:@"Kamera er ikke tilgjengelig."];
    return;
  }

  UIImagePickerController *c = [[UIImagePickerController alloc] init];
  c.sourceType = UIImagePickerControllerSourceTypeCamera;
  c.mediaTypes = [UIImagePickerController
      availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
  [c setAllowsEditing:YES];
  [c setDelegate:self];
  [[_delegate controller] presentViewController:c animated:YES completion:nil];
}

- (void)showGallery {
  if (![UIImagePickerController
          isSourceTypeAvailable:
              UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
    [appDelegate presentErrorWithMessage:@"Galleri ikke tilgjengelig.."];
  }

  UIImagePickerController *g = [[UIImagePickerController alloc] init];
  g.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
  g.mediaTypes = [UIImagePickerController
      availableMediaTypesForSourceType:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum];
  g.allowsEditing = NO;
  g.delegate = self;
  [[_delegate controller] presentViewController:g animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
  UIImage *image =
      (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
  [_delegate imageSelected:image];
  [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:YES completion:nil];
}

@end