getTextMonth(String date){
  String responseMonth;

  var mass = date.split(".");
  switch (mass[1]) {
    case "1": responseMonth = "Января"; break;
    case "2": responseMonth = "Февраля"; break;
    case "3": responseMonth = "Марта"; break;
    case "4": responseMonth = "Апреля"; break;
    case "5": responseMonth = "Мая"; break;
    case "6": responseMonth = "Июня"; break;
    case "7": responseMonth = "Июля"; break;
    case "8": responseMonth = "Августа"; break;
    case "9": responseMonth = "Сентября"; break;
    case "10": responseMonth = "Октября"; break;
    case "11": responseMonth = "Ноября"; break;
    default: responseMonth = "Декабря"; break;
  }

  return mass[0] + " " + responseMonth + " " + mass[2];
}