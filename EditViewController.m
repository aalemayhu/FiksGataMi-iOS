#import "EditViewController.h"

#import "AppDelegate.h"

#import "GlobalStrings.h"


@implementation EditViewController

#define FULL_NAME_TAG 3
#define EMAIL_TAG 4

struct AAFormField {
    int tag;
    __unsafe_unretained NSString *placeholder;
    __unsafe_unretained NSString *value;
};


struct AAFormField AAFormFieldMake(int tag, NSString *placeholder, NSString *value) {
    struct AAFormField field;
    field.tag = tag;
    field.placeholder = placeholder;
    field.value = value;
    return field;
}


- (void)configure {
    [super configure];
    delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [self configureFormFields];
    [self configureSubmit];
}


- (void)configureFormFields {
    [self createTextField:AAFormFieldMake(FULL_NAME_TAG, @"Ditt navn", [delegate valueForKey:KEY_FULL_NAME])];
    [self createTextField:AAFormFieldMake(EMAIL_TAG, @"Din epost", [delegate valueForKey:KEY_EMAIL])];
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
        [[[UIAlertView alloc] initWithTitle:@"Feilmelding"
                                    message:@"Ugyldig epostaddresse"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        return;
    } else if (name.length < 1) {
        [[[UIAlertView alloc] initWithTitle:@"Feilmelding"
                                    message:@"Oppgi navn"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
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

- (void)createTextField:(struct AAFormField)field {
    NSString *sizeString = field.value != nil || field.value.length > 0 ? field.value : field.placeholder;
    CGSize size = [sizeString sizeWithFont:[UIFont systemFontOfSize:12]];
    CGSize winSize = self.view.frame.size;
    UITextField *textField = [[UITextField alloc] initWithFrame:
            CGRectMake(0,
                    winSize.height / 1.5 -
                            size.height * 4 * field.tag,
                    winSize.width, size.height * 2)];

    textField.center = CGPointMake(self.view.center.x, textField.center.y);
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setDelegate:self];
    [[textField layer] setBorderWidth:1.0f];
    [[textField layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [textField setTag:field.tag];
    [textField setPlaceholder:field.placeholder];
    [textField setText:field.value];
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    [[self view] addSubview:textField];
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
