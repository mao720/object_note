class Results {
  Results(this.results);

  Results.fromJson(Map<String, dynamic> json) : results = json['results'];

  List? results;

  Map<String, dynamic> toJson() => {'results': results};
}
