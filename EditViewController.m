#import "EditViewController.h"
#import "AppDelegate.h"
#import "GlobalStrings.h"

@implementation EditViewController


#define FULL_NAME 3
#define EMAIL 4

struct AAFormField {
    int tag;
    __unsafe_unretained NSString *placeholder;
    __unsafe_unretained NSString *value;
    CGPoint position;
};

struct AAFormField AAFormFieldMake(int tag, NSString *placeholder, NSString *value) {
    struct AAFormField field;
    field.tag = tag;
    field.placeholder = placeholder;
    field.value = value;
    return field;
}

-(void) configure {
    [super configure];
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self configureFormFields];
    [self configureSubmit];
}

-(void) configureFormFields {
    [self createTextField:AAFormFieldMake(FULL_NAME, @"Ditt navn", [delegate valueForKey:KEY_FULL_NAME])];
    [self createTextField:AAFormFieldMake(EMAIL, @"Din epost", [delegate valueForKey:KEY_EMAIL])];
}

-(void) configureSubmit {
    UITextField *nameField = (UITextField *)[[self view] viewWithTag:FULL_NAME];
    UIButton *doneButton = [[UIButton alloc] initWithFrame:
                            CGRectMake(nameField.frame.origin.x,
                                       nameField.frame.origin.y +nameField.frame.size.height*2,
                                       nameField.frame.size.width/3,
                                       nameField.frame.size.height)];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton setBackgroundColor:[UIColor blackColor]];
    [doneButton setTitle:@"Ferdig" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];

    [doneButton setCenter:CGPointMake(self.view.center.x, doneButton.center.y)];
    [[self view] addSubview:doneButton];
}

-(void) done {
    [delegate storeDetails: [self fieldValueForKey:FULL_NAME]
                     email:[self fieldValueForKey:EMAIL]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *) fieldValueForKey:(int)tag {
    UITextField *f = (UITextField *)[[self view] viewWithTag:tag];
    return f.text;
}


-(void) createTextField:(struct AAFormField)field{
    NSString *sizeString = field.value != nil || field.value.length > 0 ? field.value : field.placeholder;
    CGSize size = [sizeString sizeWithFont:[UIFont systemFontOfSize:12]];
    
    CGSize winSize = self.view.frame.size;
    UITextField *textField = [[UITextField alloc] initWithFrame:
                              CGRectMake(0,
                                         winSize.height / 1.5 -
                                         size.height * 4 * field.tag,
                                         winSize.width, size.height*2)];
    textField.center = CGPointMake(self.view.center.x, textField.center.y);
    
    [textField setDelegate:self];
    [[textField layer] setBorderWidth:0.5f];
    [[textField layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [textField setTag:field.tag];
    [textField setPlaceholder:field.placeholder];
    [textField setText:field.value];
    [[self view] addSubview:textField];
}

#pragma mark - UITextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField.tag == EMAIL) {
        UITextField *nextField = (UITextField *)[[self view] viewWithTag:FULL_NAME];
        [nextField becomeFirstResponder];
    }
    
    return YES;
}

@end
