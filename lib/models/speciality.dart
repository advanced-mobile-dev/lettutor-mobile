class Speciality {
  final String code;
  final String name;
  Speciality(this.code, this.name);
  static List<Speciality> data = [
    Speciality('', 'All'),
    Speciality('english-for-kids', 'English for kids'),
    Speciality('business-english', 'English for business'),
    Speciality('conversational-english', 'Conversational'),
    Speciality('starters', 'STATERS'),
    Speciality('movers', 'MOVERS'),
    Speciality('flyers', 'FLYERS'),
    Speciality('ket', 'KET'),
    Speciality('pet', 'PET'),
    Speciality('ielts', 'IELTS'),
    Speciality('toefl', 'TOEFT'),
    Speciality('toeic', 'TOEIC'),
  ];
}
