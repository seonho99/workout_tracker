enum DaysOfWeek{
  mon('월'),
  tue('화'),
  wed('수'),
  thu('목'),
  fri('금'),
  sat('토'),
  sun('일');

  const DaysOfWeek(this.kor);
  final String kor;
  static DaysOfWeek fromIndex(int index){
   return DaysOfWeek.values[index];
  }
}