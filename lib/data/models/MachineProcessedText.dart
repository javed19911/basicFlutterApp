class MachineProcessedText {
  String text;
  String color;

  MachineProcessedText({this.text, this.color});

  MachineProcessedText.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['color'] = this.color;
    return data;
  }
}