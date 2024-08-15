import 'data.dart';
import 'package:flutter/material.dart';

List<Data> dataList = List<Data>();

String country = "";
List<String> countries = List<String>();

String ill = "assets/ill.png";
String recover = "assets/recover.png";
String death = "assets/death.png";
String earth = "assets/earth.png";

TextEditingController text = new TextEditingController();

void main() async {
  dataList = await fetchDataList();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //BUILDTEXTFIELD.........
  Widget buildTextField() {
    return Container(
      child: Container(
        height: 150,
        width: 500,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: new BorderRadius.vertical(bottom: new Radius.circular(30.0)),
        ),

        child: TextField(
          style: new TextStyle(color: Colors.white),
          decoration: InputDecoration(
            //borders
            border: OutlineInputBorder(),
            
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),

            //prefixIcon
            prefixIcon: IconButton(
              color: Colors.white,
              icon: ImageIcon(AssetImage(earth)),

              onPressed: () {
                setState(() {
                  text.text = "";

                  FocusScopeNode currentFocus = FocusScope.of(context);

                  Future.delayed(const Duration(milliseconds: 1), () {
                    if (!currentFocus.hasPrimaryFocus)
                      currentFocus.unfocus();
                  });

                  country = text.text;
                });
              },
            ),

            //hintText
            hintText: 'Inserisci il paese da cercare',
            hintStyle: TextStyle(
              color: Colors.white
            ),
          ),

          controller: text,

          //changed
          onChanged: (country) {
            setState(() {
              autocomplete(country);
            });
          },

          //submitted
          onSubmitted: (ctry) {
            setState(() {
              country = ctry;
            });
          },
        ),
        padding: EdgeInsets.all(20),
        alignment: Alignment(0, 0),
      ),

      alignment: Alignment(0, -1),
    );
  }

  //BUILDLIST.........
  Widget buildList() {
    double h = (30.0 * countries.length);

    if(h > 200)
      h = 200;    

    return Container(
      padding: EdgeInsets.only(top:105, left: 21),

      child: Container(
        color: Colors.grey[900],
        height: h,
        width: 370,

        child: ListView.separated(
          itemCount: countries.length,
          padding: EdgeInsets.only(bottom: 10),       

          separatorBuilder: (context, index) => Divider(
            height: 5,
            color: Colors.grey[700],
          ),   

          itemBuilder: (BuildContext ctxt, int index) {
            return Container(
              height: 25,
              color: Colors.grey[900],

              child: GestureDetector(
                child: Text(
                  ("${countries[index]}"),

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23.0
                  ),
                ),

                onTap: () {
                  setState(() {
                    text.text = countries[index];
                    countries.clear();

                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus)
                      currentFocus.unfocus();

                    country = text.text;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  //BUILDCOUNTRY.........
  Widget buildCountry() {
    String txt = "";
    double size = 40;
    Color color = Colors.white;

    if(country == "")
      txt = "All Countries";
    else
      if(exists(country))
        txt = country;
      else{
        size = 25;
        color = Colors.red;
        txt = "This country doesn't exists";
      }

    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),

      child: Container(
        height: 60,
        width: 500,

        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
        ),

        child: Text(
          txt,
          style: TextStyle(
            color: color,
            fontSize: size
          ),
        ),

        alignment: Alignment(0, 0),
      ),

      alignment: Alignment(0, -0.46),
    );
  }

  //BUILDCASES.........
  Widget buildCases() {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),

      child: Container(
        height: 125,
        width: 500,

        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
        ),

        child: Stack(
          children: <Widget>[
            buildText("Cases"),
            buildInfo("Cases")
          ],
        ),

        alignment: Alignment(0, 0),
      ),

      alignment: Alignment(0, -0.1),
    );
  }

  //BUILDDEATHS.........
  Widget buildDeaths() {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),

      child: Container(
        height: 125,
        width: 500,

        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
        ),

        child: Stack(
          children: <Widget>[
            buildText("Deaths"),
            buildInfo("Deaths")
          ],
        ),

        alignment: Alignment(0, 0),
      ),

      alignment: Alignment(0, 0.43)
    );
  }

  //BUILDRECOVERED.........
  Widget buildRecovered() {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),

      child: Container(
        height: 125,
        width: 500,

        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
        ),

        child: Stack(
          children: <Widget>[
            buildText("Recovered"),
            buildInfo("Recovered")
          ],
        ),
        alignment: Alignment(0, 0),
      ),

      alignment: Alignment(0, 0.94),
    );
  }

  //BUILDTEXT....................
  Widget buildText(String type) {
    String text = type;
    Color color;
    String image;
    double x;

    switch(type) {
      case "Cases": color = Colors.yellow; image = ill; x = -0.92; break; 
      case "Deaths": color = Colors.red; image = death; x = -0.90; break; 
      case "Recovered": color = Colors.green; image = recover; x = -0.93; break; 
    }
    
    return Stack(
      children: <Widget>[
        Container(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 40,
              color: color
            )
          ),

          alignment: Alignment(-0.87, -0.85),
        ),

        Container(
          child: ImageIcon(
            new AssetImage(image),
            color: color,
            size: 60,
          ),

          alignment: Alignment(x, 0.70),
        )
      ]
    );
  }

  //BUILDINFO....................
  Widget buildInfo(String type) {
    Color color;
    int total;

    switch(type){
      case "Cases": color = Colors.yellow; total = getTotal("Cases", country); break;
      case "Deaths": color = Colors.red; total = getTotal("Deaths", country); break;
      case "Recovered": color = Colors.green; total = getTotal("Recovered", country); break;
    }
    
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            child: Text(
              '$total',
              style: TextStyle(
                color: color,
                fontSize: 40
              ),
            ),

            alignment: Alignment(0.9, 0.8)
          ),
        ],
      ),
    );
  }

  //AUTOCOMPLETE.....................
  void autocomplete(String country) {
    countries.clear();
    int endIndex = country.length;

    if(country != "")
      for(int i= 0; i < dataList.length - 1; i++)
        if(dataList[i].country.length >= endIndex)
          if(dataList[i].country.toLowerCase().substring(0, endIndex) == country.toLowerCase())
            countries.add(dataList[i].country);
  }

  //EXISTS.....................
  bool exists(String country) {
    bool exist = false;

    for(int i = 0; i < dataList.length; i++){
      if(dataList[i].country == country)
        exist = true;
    }

    return exist;
  }

  //GETTOTAL.................................
  int getTotal(String type, String country) {
    int index = 0;
    int total = 0;

    if(type == "Cases"){
      index = getIndex(country);

      if(index == -2)
        print("Wrong country");
      else{
        if(index == -1)
          for(int i = 0; i < dataList.length; i++){
            total += dataList[i].cases;
          }
        else
          total = dataList[index].cases;
      }
    }

    if(type == "Deaths"){
      index = getIndex(country);

      if(index == -2)
        print("Wrong country");
      else {
        if(index == -1)
          for(int i = 0; i < dataList.length; i++)
            total += dataList[i].deaths;
        else
          total = dataList[index].deaths;
      }
    }

    if(type == "Recovered"){
      index = getIndex(country);

      if(index == -2)
        print("Wrong country");
      else {
        if(index == -1)
          for(int i = 0; i < dataList.length; i++)
            total += dataList[i].recovered;
        else
          total = dataList[index].recovered;
      }
    }

    return total;
  }

  //GETINDEX....................
  int getIndex(String country) {
    int index = -2;
    
    if(country == "")
      index = -1;
    else
      for(int i = 0; i < dataList.length; i++)
        if(dataList[i].country == country)
          index = i;

    return index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[800],
      body: Stack(
        children: <Widget>[
          buildTextField(),
          buildCountry(),
          buildCases(),
          buildDeaths(),
          buildRecovered(),
          if(countries.length != 0)
            buildList(),
        ],
      )
    );
  }
}