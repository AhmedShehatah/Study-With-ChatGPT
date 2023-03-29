class CompletionModel {
  String? id;
  String? object;
  int? created;
  List<CompletionChoice>? choices;
  CompletionUsage? usage;

  CompletionModel({
    this.id,
    this.object,
    this.created,
    this.choices,
    this.usage,
  });

  factory CompletionModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> choicesJson = json['choices'];
    List<CompletionChoice>? choices;
    choices = choicesJson
        .map((choiceJson) => CompletionChoice.fromJson(choiceJson))
        .toList();
    return CompletionModel(
      id: json['id'],
      object: json['object'],
      created: json['created'],
      choices: choices,
      usage: CompletionUsage.fromJson(json['usage']),
    );
  }
}

class CompletionChoice {
  int? index;
  CompletionMessage? message;
  String? finishReason;

  CompletionChoice({
    this.index,
    this.message,
    this.finishReason,
  });

  factory CompletionChoice.fromJson(Map<String, dynamic> json) {
    return CompletionChoice(
      index: json['index'],
      message: CompletionMessage.fromJson(json['message']),
      finishReason: json['finish_reason'],
    );
  }
}

class CompletionMessage {
  String? role;
  String? content;

  CompletionMessage({
    this.role,
    this.content,
  });

  factory CompletionMessage.fromJson(Map<String, dynamic> json) {
    return CompletionMessage(
      role: json['role'],
      content: json['content'],
    );
  }
}

class CompletionUsage {
  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  CompletionUsage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
  });

  factory CompletionUsage.fromJson(Map<String, dynamic> json) {
    return CompletionUsage(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }
}
