#import "ViewUtil.h"

@implementation ViewUtil

+ (void)createTextField:(struct AAFormField)field forView:(UIView *)view delegate:(id)delegate {
    NSString *sizeString = field.value != nil || field.value.length > 0 ? field.value : field.placeholder;
    CGSize size = [sizeString sizeWithFont:[UIFont systemFontOfSize:12]];
    CGSize winSize = view.frame.size;
    UITextField *textField = [[UITextField alloc] initWithFrame:
                              CGRectMake(0,
                                         winSize.height / 1.5 -
                                         size.height * 4 * field.tag,
                                         winSize.width, size.height * 2)];
    textField.center = CGPointMake(view.center.x, textField.center.y);
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setDelegate:delegate];
    [[textField layer] setBorderWidth:1.0f];
    [[textField layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [textField setTag:field.tag];
    [textField setPlaceholder:field.placeholder];
    [textField setText:field.value];
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    [view addSubview:textField];
}

@end
