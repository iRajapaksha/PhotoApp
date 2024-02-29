class Caption {
  String description;

  Caption({
    required this.description,
  });

  static List<Caption> getCaptions() {
    List<Caption> captions = [];

    captions.add(Caption(description: "description1"));
    captions.add(Caption(description: "description2"));
    captions.add(Caption(description: "description3"));
    captions.add(Caption(description: "description4"));
    captions.add(Caption(description: "description5"));
    captions.add(Caption(description: "description6"));
    captions.add(Caption(description: "description7"));
    captions.add(Caption(description: "description8"));


    return captions;
  }
}
