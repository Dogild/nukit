/*
*   Filename:         NUNumericTextField.j
*   Created:          Fri Jun 20 16:51:28 PDT 2014
*   Author:           Alexandre Wilhelm <alexandre.wilhelm@alcatel-lucent.com>
*   Description:      VSA
*   Project:          VSD - Nuage - Data Center Service Delivery - IPD
*
* Copyright (c) 2011-2012 Alcatel, Alcatel-Lucent, Inc. All Rights Reserved.
*
* This source code contains confidential information which is proprietary to Alcatel.
* No part of its contents may be used, copied, disclosed or conveyed to any party
* in any manner whatsoever without prior written permission from Alcatel.
*
* Alcatel-Lucent is a trademark of Alcatel-Lucent, Inc.
*
*/

@import <Foundation/Foundation.j>
@import <AppKit/CPTextField.j>

@global floatValue
@global isFloatNumber
@global isIntegerNumber

@implementation NUNumericTextField : CPTextField
{
    BOOL     _allowDecimals     @accessors(property=allowDecimals);
}

- (BOOL)_setStringValue:(CPString)aValue isNewValue:(BOOL)isNewValue errorDescription:(CPStringRef)anError
{
    var value = [aValue length] && [self objectValue] ? [self objectValue] : @"";

    if ([self _shouldNotAcceptValue:aValue])
    {
        [self _inputElement].value = value.toString();
        return [super _setStringValue:value isNewValue:isNewValue errorDescription:anError];
    }

    return [super _setStringValue:aValue isNewValue:isNewValue errorDescription:anError];
}

- (void)_setObjectValue:(id)aValue useFormatter:(BOOL)useFormatter
{
    if ([self _shouldNotAcceptValue:aValue])
        return;

    [super _setObjectValue:aValue useFormatter:useFormatter];
}

- (BOOL)_shouldNotAcceptValue:(CPString)aValue
{
    if (!aValue)
        return NO;

    var value = aValue.toString();

    if (value.length == 0)
        return NO;

    if ([self allowDecimals])
        return !value.match(/^\d+\.\d+$/) && !value.match(/^\d+$/) && !value.match(/^\d+\.+$/);

    return !value.match(/^\d+$/);
}

@end
