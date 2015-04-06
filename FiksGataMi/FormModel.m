#import "FormModel.h"

@implementation FormModel

struct AAFormField AAFormFieldMake(int tag, NSString *placeholder, NSString *value) {
    struct AAFormField field;
    field.tag = tag;
    field.placeholder = placeholder;
    field.value = value;
    return field;
}


@end
