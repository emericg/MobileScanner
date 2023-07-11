/*!
 * Copyright (c) 2020 Emeric Grange
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include "utils_os_ios.h"

#if defined(Q_OS_IOS)

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/* ************************************************************************** */

void UtilsIOS::screenKeepOn(bool on)
{
    if (on)
    {
        [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    }
    else
    {
        [[UIApplication sharedApplication] setIdleTimerDisabled: NO];
    }
}

/* ************************************************************************** */

// For reference:
//enum ScreenOrientation_iOS {
//    UIInterfaceOrientationUnknown = 0,          // The orientation of the device is unknown.
//    UIInterfaceOrientationPortrait,             // The device is in portrait mode, with the device upright and the Home button on the bottom.
//    UIInterfaceOrientationPortraitUpsideDown,   // The device is in portrait mode but is upside down, with the device upright and the Home button at the top.
//    UIInterfaceOrientationLandscapeLeft,        // The device is in landscape mode, with the device upright and the Home button on the left.
//    UIInterfaceOrientationLandscapeRight,       // The device is in landscape mode, with the device upright and the Home button on the right.
//};

void UtilsIOS::screenLockOrientation(int orientation)
{
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
    if (orientation != 0) value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];

    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

void UtilsIOS::screenLockOrientation(int orientation, bool autoRotate)
{
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];

    if (orientation == 0 || autoRotate) value = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    else if (orientation == 1) value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    else if (orientation == 2) value = [NSNumber numberWithInt:UIInterfaceOrientationPortraitUpsideDown];
    else if (orientation == 4) value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    else if (orientation == 8) value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];

    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

/* ************************************************************************** */

void UtilsIOS::vibrate(int ms)
{
//https://stackoverflow.com/questions/4724980/making-the-iphone-vibrate
/*
For notifications:

let generator = UINotificationFeedbackGenerator()
generator.notificationOccured(style: .error)

Available styles are .error, .success, and .warning. Each has its own distinctive feel.
From the docs:

    A concrete UIFeedbackGenerator subclass that creates haptics to communicate successes, failures, and warnings.

For simple vibrations:

let generator = UIImpactFeedbackGenerator(style: .medium)
generator.impactOccured()

Available styles are .heavy, .medium, and .light. These are simple vibrations with varying degrees of "hardness".
From the docs:

    A concrete UIFeedbackGenerator subclass that creates haptics to simulate physical impacts

For when the user selected an item

let generator = UISelectionFeedbackGenerator()
generator.selectionChanged()

This is the least noticeable of all the haptics, and so is the most suitable for when haptics should not be taking over the app experience.
From the docs:

    A concrete UIFeedbackGenerator subclass that creates haptics to indicate a change in selection.
*/
}

/* ************************************************************************** */
#endif // Q_OS_IOS
