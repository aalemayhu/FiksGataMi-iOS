#import <Foundation/Foundation.h>

@interface FormModel : NSObject
struct AAFormField AAFormFieldMake(int tag, NSString *placeholder, NSString *value) ;
@end

struct AAFormField {
    int tag;
    __unsafe_unretained NSString *placeholder;
    __unsafe_unretained NSString *value;
};