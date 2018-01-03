

#import "UIView+HUD.h"

#define kShowWarningDelayDuration   1
#define kTimeoutDuration 30

@implementation UIView (HUD)

- (void)showWarning:(NSString *)words{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = words;
        hud.yOffset = -80;
        [hud hide:YES afterDelay:kShowWarningDelayDuration];
    });
}
- (void)showBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.yOffset = -100;
        [hud hide:YES afterDelay:kTimeoutDuration];
    });
}
- (void)hideBusyHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
    });
}


@end







