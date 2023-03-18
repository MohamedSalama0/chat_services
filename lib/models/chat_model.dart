enum Type {text, image}
class Message {
  String? msg;
  String? toId;
  String? read;
  String? sent;
  String? fromId;
  Type? type;

  Message(
      {this.msg, this.toId, this.read, this.type, this.sent, this.fromId});

  Message.fromJson(Map<String, dynamic> json) {
    msg = json['msg'].toString();
    toId = json['toId'].toString();
    read = json['read'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text ;
    sent = json['sent'].toString();
    fromId = json['fromId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['msg'] = msg;
    data['toId'] = toId;
    data['read'] = read;
    data['type'] = type!.name;
    data['sent'] = sent;
    data['fromId'] = fromId;
    return data;
  }
}
