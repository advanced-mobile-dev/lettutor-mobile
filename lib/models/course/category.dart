class Category {
  String id;
  String name;
  String description;
  String key;
  String createdAt;
  String updatedAt;

  Category(
      {this.id,
      this.name,
      this.description,
      this.key,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['title'];
    description = json['description'];
    key = json['key'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.name;
    data['description'] = this.description;
    data['key'] = this.key;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  static List<Category> data = <Category>[
    Category(
        id: "968e7e18-10c0-4742-9ec6-6f5c71c517f5",
        name: "For studying abroad",
        description: null,
        key: "ABROAD",
        createdAt: "2021-09-05T13:06:10.836Z",
        updatedAt: "2021-09-05T13:06:10.836Z"),
    Category(
      id: "d95b69f7-b810-4cdf-b11d-49faaa71ff4b",
      name: "English for Traveling",
      key: "TRAVEL",
    ),
    Category(
      id: "c4e7f418-4006-40f2-ba13-cbade54c1fd0",
      name: "Conversational English",
      key: "CONVERSATIONAL",
    ),
    Category(
      id: "488cc5f8-a5b1-45cd-8d3a-47e690f9298e",
      name: "English for Beginners",
      key: "BEGINNER",
    ),
    Category(
      id: "f01cf003-25d1-432f-aaab-bf0e8390e14f",
      name: "Business English",
      key: "BUSINESS",
    ),
    Category(
      id: "975f83f6-30c5-465d-8d98-65e4182369ba",
      name: "STARTERS",
      key: "STARTERS",
    ),
    Category(
      id: "fb92cf24-1736-4cd7-a042-fa3c37921cf8",
      name: "English for Kid",
      key: "KID",
    ),
    Category(
      id: "0b89ead7-0e92-4aec-abce-ecfeba10dea5",
      name: "PET",
      key: "PET",
    ),
    Category(
      id: "248ca9f5-b46d-4a55-b81c-abafebff5876",
      name: "KET",
      key: "KET",
    ),
    Category(
      id: "534a94f1-579b-497d-b891-47d8e28e1b2c",
      name: "MOVERS",
      key: "MOVERS",
    ),
    Category(
      id: "df9bd876-c631-413c-9228-cc3d6a5c34fa",
      name: "FLYERS",
      key: "FLYERS",
    ),
    Category(
      id: "d87de7ba-bd4c-442c-8d58-957acb298f57",
      name: "TOEFL",
      key: "TOEFL",
    ),
    Category(
      id: "1e662753-b305-47ad-a319-fa52340f5532",
      name: "TOEIC",
      key: "TOEIC",
    ),
    Category(
      id: "255c96b6-fd6f-4f43-8dbd-fec766e361e0",
      name: "IELTS",
      key: "IELTS",
    )
  ];
}
