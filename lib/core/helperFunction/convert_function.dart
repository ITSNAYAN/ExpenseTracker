  //  H E L P E R   F U N C T I O N S
  double? convertStringToDouble (String? value) {
  if (value == null ) return 0.0;
    double? convertValue = double.tryParse(value!) ;
    return convertValue ?? 0.0 ;
  }

  String? formatDate(DateTime dateTime){
   return "${dateTime.day}-${dateTime.month}-${dateTime.year}" ;
  }

  // calculate the numbers of month since between two dates
  int calculateMonthCount ( int startYear , startMonth , currentYear, currentMonth){
  int month = (currentYear-startYear)*12 + currentMonth-startMonth+1;
  return month;
  }
