
![App Icon](https://raw.githubusercontent.com/benhk2005/PPEx/master/Resources/App-Icon%403x.png)
# PPEx

### Feature
- Support 168 currency rate conversion (subject to API support)
- Local cache for 30 minutes for currency list and exchange rate

### Software Used

XCode Version 12.2 (12B45b)

### App architecture / Implementation approach

- VIPER architecture applied to this application in order to provide high degree of unit test coverage
- Depenedcy injection: Used dependency injection in order to provide high degree of unit test coverage
- Unit Test for Presenter coverage : 85%+
- Widget: 
	- CurrencyEntryView: for decimal number input
	- CurrencyDropDownView: for select currency


### Data Source

https://currencylayer.com/documentation

### Screenshot
<img src="https://raw.githubusercontent.com/benhk2005/PPEx/master/Resources/AppScreenShot.png" height="450px">


### Unit Tests
<img src="https://raw.githubusercontent.com/benhk2005/PPEx/master/Resources/Unit-Test-Screenshot-1.png" width="250px">
<img src="https://raw.githubusercontent.com/benhk2005/PPEx/master/Resources/Unit-Test-Screenshot-2.png" width="250px">

