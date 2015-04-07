#import "EditViewController.h"
#import "AppDelegate.h"
#import "GlobalStrings.h"
#import "FormModel.h"
#import "ViewUtil.h"


@implementation EditViewController

#define FULL_NAME_TAG 3
#define EMAIL_TAG 4

- (void)configure {
    [super configure];
    [self configureFormFields];
    [self configureSubmit];
}


- (void)configureFormFields {
    [ViewUtil createTextField:AAFormFieldMake(FULL_NAME_TAG, @"Ditt navn", [delegate valueForKey:KEY_FULL_NAME])
                      forView:self.view delegate:self];
    [ViewUtil createTextField:AAFormFieldMake(EMAIL_TAG, @"Din epost", [delegate valueForKey:KEY_EMAIL])
     forView:self.view delegate:self];
}


- (void)configureSubmit {
    UITextField *nameField = (UITextField *) [[self view] viewWithTag:FULL_NAME_TAG];
    UIButton *doneButton = [[UIButton alloc] initWithFrame:
            CGRectMake(nameField.frame.origin.x,
                    nameField.frame.origin.y + nameField.frame.size.height * 2,
                    nameField.frame.size.width / 3,
                    nameField.frame.size.height)];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton setBackgroundColor:[UIColor blackColor]];
    [doneButton setTitle:@"Ferdig" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setCenter:CGPointMake(self.view.center.x, doneButton.center.y)];
    [[self view] addSubview:doneButton];
}


- (void)done {
    NSString *email = [self fieldValueForKey:EMAIL_TAG];
    NSString *name = [self fieldValueForKey:FULL_NAME_TAG];
    if (![self isEmailValid:email]) {
        [delegate presentErrorWithMessage:@"Ugyldig epostaddresse"];
        return;
    } else if (name.length < 1) {
        [delegate presentErrorWithMessage:@"Oppgi navn"];
        return;
    }

    [delegate storeDetails:name
                     email:email];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)fieldValueForKey:(int)tag {
    UITextField *f = (UITextField *) [[self view] viewWithTag:tag];
    return f.text;
}




- (BOOL)isEmailValid:(NSString *)email {
    // from https://github.com/benmcredmond/DHValidation/blob/master/DHValidation.m
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField.tag == EMAIL_TAG) {
        UIColor *borderColor = [UIColor blackColor];
        if ([self isEmailValid:textField.text]) {
            UITextField *nextField = (UITextField *) [[self view] viewWithTag:FULL_NAME_TAG];
            [nextField becomeFirstResponder];
        } else {
            borderColor = [UIColor redColor];
        }
        [[textField layer] setBorderColor:[borderColor CGColor]];
    } else if (textField.tag == FULL_NAME_TAG) {
        [self done];
    }
    return YES;
}

@end
