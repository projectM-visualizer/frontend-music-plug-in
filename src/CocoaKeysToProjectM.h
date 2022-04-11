#pragma once

#include <libprojectM/projectM.h>

projectMKeycode cocoa2pmKeycode(NSEvent* event)
{
    projectMKeycode
    char_code = (projectMKeycode)[event keyCode];
    switch (char_code)
    {
        case kVK_F1:
        case kVK_ANSI_H:
            return PROJECTM_K_F1;
        case kVK_F2:
            return PROJECTM_K_F2;
        case kVK_F3:
            return PROJECTM_K_F3;
        case kVK_F4:
            return PROJECTM_K_F4;
        default:
            // try and get ascii code
            NSString * chars = [event
            charactersIgnoringModifiers];
            if ([chars length]) {
                return (projectMKeycode)[chars characterAtIndex:0];
            }
            return char_code;
    }
}

projectMModifier cocoa2pmModifier(NSEvent* event)
{
    NSUInteger
    mod = [event modifierFlags];
    if (mod & NSShiftKeyMask)
    {
        return (projectMModifier) PROJECTM_K_LSHIFT;
    }
    if (mod & NSControlKeyMask)
    {
        return (projectMModifier) PROJECTM_K_LCTRL;
    }

    return (projectMModifier) 0;
}
