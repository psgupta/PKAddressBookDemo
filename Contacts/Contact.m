//
//  Contact.m
//  PKAddressBookDemo
//
//  Created by Randem IT on 11/02/16.
//  Copyright © 2016 RIT_MacMini. All rights reserved.
//

#import "Contact.h"
@interface Contact()
@property(nonatomic,copy)NSString *Fname;
@property(nonatomic,copy)NSString *Lname;
@property(nonatomic,copy)NSMutableArray *arrEmail;

@end

@implementation Contact

- (instancetype)initWithABRecordRef:(ABRecordRef)person{
    
    if(self = [super init])
    {
        [self fillUpCredentialsFor:person];
    }
    
    return self;
}

#pragma mark ---- POPULATE CONTACT DETAILS
- (void)fillUpCredentialsFor:(ABRecordRef)person
{
    [self  updateNameFieldWith:person];
    [self  populateEmailArrayWith:person];
}
- (void)updateNameFieldWith:(ABRecordRef)contactPerson
{
    NSString *firstName = CFBridgingRelease(ABRecordCopyValue(contactPerson, kABPersonFirstNameProperty));
    NSString *lastName  = CFBridgingRelease(ABRecordCopyValue(contactPerson, kABPersonLastNameProperty));
    
    if (firstName) {
        _Fname = firstName;
    }
    if (lastName) {
        _Lname  = lastName;
    }
}
- (void)populateEmailArrayWith:(ABRecordRef)contactPerson
{
    ABMultiValueRef emails = ABRecordCopyValue(contactPerson, kABPersonEmailProperty);
    CFIndex phoneNumberCount = ABMultiValueGetCount(emails);
    
    for (int j = 0; j < phoneNumberCount; j++) {
        NSString *phone = CFBridgingRelease(ABMultiValueCopyValueAtIndex(emails, j));
        
        if(!_arrEmail)
        {
            _arrEmail = [NSMutableArray array];
        }
        [_arrEmail addObject:phone];
    }
    
    if (emails) {
        CFRelease(emails);
    }
}


#pragma mark --- GETTER
- (NSString *)getName
{
    return [NSString stringWithFormat:@"%@ %@",_Fname,_Lname];
}

- (NSArray *)getEmails
{
    return _arrEmail;
}
@end
