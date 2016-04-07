//
//  Contact.h
//  PKAddressBookDemo
//
//  Created by Randem IT on 11/02/16.
//  Copyright © 2016 RIT_MacMini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
@interface Contact : NSObject


- (instancetype)initWithABRecordRef :(ABRecordRef)person;
- (NSString *)getName;
- (NSArray *)getEmails;
@end
