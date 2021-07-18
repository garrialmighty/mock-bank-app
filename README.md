#  Mock Bank Application

## Applicant Name: Garri Adrian Nablo

## Assumptions
### Login
- Client data does not need to persist in any way. Once the app is killed all registered users, balances are deleted.
- Reigstering/Logging in does not require a password of any kind 
- User will not use a non-empty string as their username

### Topup
- User will always input a valid amount (non-negative number)

### Pay
- User will always input a valid amount (non-negative number)

## Disclaimer
- Login, Topup and Pay input textfields do not have input validation. This is considered a tech debt.
