## **VARIABLES**
```dart
String ill
String recover
String death
String earth
```
String containing the path to the homonymous pngs
##
```dart
List<Data> dataList
```
List containing all the json data of the site
##
```dart
String country
```
String containing the name of the country to search for. This is empty by default
##
```dart
List<String> countries
```
List of strings containing the countries entered by the **_autocomplete()_** method
##
```dart
TextEditingController text
```
Used to edit what has been written inside a TextField
## **METHODS**
```dart
Widget buildTextField()
```
This method builds a TextField, which has an IconButton, which has as its icon an ImageIcon, an icon containing a png, created using the AssetImage class and the _earth_ variable. When the button is clicked, it sets the variables _country_ and _text_ empty.

When the country entered inside is changed, it calls the method
**_autocomplete(country)_**.

When the country entered is sent, the _country_ variable is set to the country searched for.
##
```dart
void autocomplete(String country)
```
This method is used for autocomplete, and is called whenever a country name is being entered into the TextField. 

The first thing it does is empty the _countries_ list, then it creates a variable called _endIndex_ to which a value equal to the length of the entered country name is applied.

In case the country name is not empty, then it goes and compares all the countries within the _dataList_.

This method does not take the entire country name, but only the letters between 0 and _endIndex_, and in the event that the portion of the country name is equal to the name entered in the TextField, then the entire country name is added within the _countries_ list
##
```dart
Widget buildList()
```
This method is only called if the _countries_ list is not empty.

When called, it builds a ListView containing a GestureDetector, with the names of the countries contained in the _countries_ list inside.

A GestureDetector is used, so that when the name of a country is clicked, then the variables _country_ and _text_ are assigned the name of the country.

Finally the _countries_ list is emptied, so that the word autocompletion is no longer visible and the keyboard is closed
##
```dart
Widget buildCountry()
```
This method is used to display the name of the country being searched for.
			
In the case where the name is empty, then "All Countries" is written

In the case where the country name is non-existent, then "This country doesn't exist" is written
##
```dart
Widget buildCases()
Widget buildDeaths()
Widget buildRecovered()
```
These methods are used to display the infected, dead and healed within a container.

They call the methods **_buildText(String type)_** and **_buildInfo(String type)_**.
##
```dart
Widget buildText(String type)
```
Based on the string "type", displays a string saying "Cases", "Deaths" or "Recovered" and below the string, the png _ill.png_, _deaths.png_ or _recovered.png_
##
```dart
Widget buildInfo(String type)
```
Based on the string _type_, values are displayed using the method 
**_getTotal(String type, String country)_**
##
```dart
int getTotal(String type, String country)
```
Used to get the values of infected, dead and cured, based on the country 
entered. To do this, we need the position of the selected country in the
of the _dataList_, so a support method is used, called **_getIndex(String country)_**.

If the index is equal to -2 then the country entered does not exist, if the index is equal to -1 then we need to get the data for all countries, if the index has a number other than -2 and -1 then we get the data for that particular country
##
```dart
int getIndex(String country)
```
The default index is -2, if the country argument is empty, then the index is set to -1, and if the country entered exists, the index variable takes a value equal to the position of that country in the _dataList_. 
Finally, index is returned.
