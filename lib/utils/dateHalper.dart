
String getDateDayAgo(String date){
  String agoDate;
  var mass = date.split('.');

  if(mass[2] == "2020"){
    switch (mass[1]) {
      case "1":
          agoDate = getDay(mass, "30");
        break;

      case "2":
          agoDate = getDay(mass, "30");
        break;

      case "3":
          agoDate = getDay(mass, "29");
        break;

      case "4":
          agoDate = getDay(mass, "31");
        break;

      case "5":
          agoDate = getDay(mass, "30");
        break;

      case "6":
          agoDate = getDay(mass, "31");
        break;

      case "7":
         agoDate = getDay(mass, "30");
        break;

      case "8":
          agoDate = getDay(mass, "31");
        break;

      case "9":
          agoDate = getDay(mass, "31");
        break;

      case "10":
          agoDate = getDay(mass, "30");
        break;

      case "11":
          agoDate = getDay(mass, "31");
        break;

      case "12":
          agoDate = getDay(mass, "30");
        break;

      default: return "No";
    }
  }
  return agoDate;
}

getDay(mass, dayLimit){
  var year = mass[2];
  var day = mass[0];
  var month = mass[1];

  if(mass[1] == "1" && mass[0] == "1"){
    year = (int.parse(mass[2])-1).toString();
    month = (int.parse(mass[1])-1).toString();
    day = dayLimit;
  }
  else if(mass[0] == "1"){
    month = (int.parse(mass[1])-1).toString();
    day = dayLimit;
  }
  else{
    day = (int.parse(mass[0])-1).toString();
  }

  return day+"."+month+"."+year;
}