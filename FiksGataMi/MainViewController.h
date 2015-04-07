#import <UIKit/UIKit.h>
#import "FiksgatamiBaseController.h"
#import "CamUtil.h"

@interface MainViewController : FiksgatamiBaseController<CamUtilDelegate> {
    CamUtil *cam;
}
@end

