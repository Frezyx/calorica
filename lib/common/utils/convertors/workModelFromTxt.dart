  double getWorkModelFromText(text){
    double result = 1.2;
      result = text == 'Минимум физической активности' ? 1.2: text == 'Занимаюсь спортом 1-3 раза в неделю'? 1.375:
      text == 'Занимаюсь спортом 3-4 раза в неделю' ? 1.55: text == 'Занимаюсь спортом каждый день' ? 1.7 : 1.9;
    return result;
  }