# EVENT MANAGER

## DESCRIPTION
This is a project of an Event Manager developed as part of The Odin Project Ruby course. The objective of this project is to manipulate file input and output, read content from a CSV (Comma Separated Value) file, transform it into a standardized format, use the data to contact a remote service, fill a template with user data, manipulate strings, access the Google Civic Information API through the Google API Client Gem and use ERB (Embedded Ruby) for templates.

## Learning Goals
After completing this tutorial, I was be able to:

- manipulate file input and output
- read content from a CSV (Comma Separated Value) file
- transform it into a standardized format
- utilize the data to contact a remote service
- populate a template with user data
- manipulate strings
- access Sunlight’s Congressional API through the Sunlight Congress gem
- use ERB (Embedded Ruby) for templating

 
## What I did in This Tutorial
Imagine that a friend of yours runs a non-profit org around political activism. A number of people have registered for an upcoming event. She has asked for your help in engaging these future attendees.

### Assignment: Form Letter
After having our attendees and their respective representatives. We can now generate a personalized call to action. For each attendee we want to include a customized letter that thanks them for attending the conference and provides a list of their representatives. 

### Assignment: Clean Phone Numbers
Similar to the zip codes, the phone numbers suffer from multiple formats and inconsistencies. If we wanted to allow individuals to sign up for mobile alerts with the phone numbers, we would need to make sure all of the numbers are valid and well-formed.

- If the phone number is less than 10 digits, assume that it is a bad number
- If the phone number is 10 digits, assume that it is good
- If the phone number is 11 digits and the first number is 1, trim the 1 and use the first 10 digits
- If the phone number is 11 digits and the first number is not 1, then it is a bad number
- If the phone number is more than 11 digits, assume that it is a bad number

### Assignment: Time Targeting
The boss is already thinking about the next conference: “Next year I want to make better use of our Google and Facebook advertising. Find out which hours of the day the most people registered, so we can run more ads during those hours.” Interesting!

Using the registration date and time we want to find out what the peak registration hours are.

### Assignment: Day of the Week Targeting
The big boss gets excited about the results from your hourly tabulations. It looks like there are some hours that are clearly more important than others. But now, tantalized, she wants to know “What days of the week did most people register?”

Use Date#wday to find out the day of the week.

