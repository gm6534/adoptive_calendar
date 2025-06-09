## 0.2.1

* Breaking Change: Added new parameter `currentDate` to set the current date of the calendar. This will be used for the `disableFutureDates` and `disablePastDates`.
The dates will be disabled based on the `currentDate`, rather than the `initialDate`. Initial date is the currently selected date in the calendar, 
while the current date is the current date of the device.
* Bug Fixed: Orientation being reset to portrait in Android when the dialog is closed. Added 'resetOrientationOnDismiss' parameter to control this behavior.
* Bug Fixed: When setting the time at 12:00 AM or 12:00 PM and switching between AM/PM, the date would automatically change to the next day.
* Add ability to change action button title with `actionButtonTitle` parameter.
* Add ability to show or hide the divider between the calendar and time picker with `showTimePickerDivider` parameter.
* Add ability to disable future dates with `disableFutureDates` parameter
* Replace GestureDetector with TextButton for the action button to ensure accessibility and focusability.

## 0.2.0

* Bugs Fixed
* Min & Max years bug fixed

## 0.1.9

* Add `disablePastDates` parameter to disable previous dates

## 0.1.8

* Bugs Fixed

## 0.1.7

* Add onSelection for current picked value
* Add ability to select date from Adoptive calendar without showing in dialog. Now you can use AdoptiveCalendar directly in your UI.

## 0.1.6

* Add option for Date Picker only

## 0.1.5

* Bugs Fixed
* Improve UI According to Material 3

## 0.1.4

* Bugs Fixed

## 0.1.3

* Action Button Added

## 0.1.2

* Leap Year Bugs Fixed

## 0.1.1

* Readme.md update

## 0.1.0

* Bugs Fixing

## 0.0.9

* Bugs Fixing

## 0.0.8

* Bugs Fixing

## 0.0.7

* Enhance UI
* Seasonal Effects For Background Added
* Brand Logo Add in Features

## 0.0.6

* Bugs Fixed

## 0.0.5

* 24 Hours Format Added
* Bugs Fixed

## 0.0.4

* Minutes Interval Added
* Bugs Fixed

## 0.0.3

* Demo Added

## 0.0.2

* Time Picker Changed to Cupertino
* Theme Added
* Bugs Fixed

## 0.0.1

* TODO: Describe initial release.

