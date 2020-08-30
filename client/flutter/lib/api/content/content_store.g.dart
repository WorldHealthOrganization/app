// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContentStore on _ContentStore, Store {
  Computed<bool> _$unsupportedSchemaVersionAvailableComputed;

  @override
  bool get unsupportedSchemaVersionAvailable =>
      (_$unsupportedSchemaVersionAvailableComputed ??= Computed<bool>(
              () => super.unsupportedSchemaVersionAvailable,
              name: '_ContentStore.unsupportedSchemaVersionAvailable'))
          .value;

  final _$logicContextAtom = Atom(name: '_ContentStore.logicContext');

  @override
  LogicContext get logicContext {
    _$logicContextAtom.reportRead();
    return super.logicContext;
  }

  @override
  set logicContext(LogicContext value) {
    _$logicContextAtom.reportWrite(value, super.logicContext, () {
      super.logicContext = value;
    });
  }

  final _$travelAdviceAtom = Atom(name: '_ContentStore.travelAdvice');

  @override
  AdviceContent get travelAdvice {
    _$travelAdviceAtom.reportRead();
    return super.travelAdvice;
  }

  @override
  set travelAdvice(AdviceContent value) {
    _$travelAdviceAtom.reportWrite(value, super.travelAdvice, () {
      super.travelAdvice = value;
    });
  }

  final _$getTheFactsAtom = Atom(name: '_ContentStore.getTheFacts');

  @override
  FactContent get getTheFacts {
    _$getTheFactsAtom.reportRead();
    return super.getTheFacts;
  }

  @override
  set getTheFacts(FactContent value) {
    _$getTheFactsAtom.reportWrite(value, super.getTheFacts, () {
      super.getTheFacts = value;
    });
  }

  final _$protectYourselfAtom = Atom(name: '_ContentStore.protectYourself');

  @override
  FactContent get protectYourself {
    _$protectYourselfAtom.reportRead();
    return super.protectYourself;
  }

  @override
  set protectYourself(FactContent value) {
    _$protectYourselfAtom.reportWrite(value, super.protectYourself, () {
      super.protectYourself = value;
    });
  }

  final _$homeIndexAtom = Atom(name: '_ContentStore.homeIndex');

  @override
  IndexContent get homeIndex {
    _$homeIndexAtom.reportRead();
    return super.homeIndex;
  }

  @override
  set homeIndex(IndexContent value) {
    _$homeIndexAtom.reportWrite(value, super.homeIndex, () {
      super.homeIndex = value;
    });
  }

  final _$learnIndexAtom = Atom(name: '_ContentStore.learnIndex');

  @override
  IndexContent get learnIndex {
    _$learnIndexAtom.reportRead();
    return super.learnIndex;
  }

  @override
  set learnIndex(IndexContent value) {
    _$learnIndexAtom.reportWrite(value, super.learnIndex, () {
      super.learnIndex = value;
    });
  }

  final _$newsIndexAtom = Atom(name: '_ContentStore.newsIndex');

  @override
  IndexContent get newsIndex {
    _$newsIndexAtom.reportRead();
    return super.newsIndex;
  }

  @override
  set newsIndex(IndexContent value) {
    _$newsIndexAtom.reportWrite(value, super.newsIndex, () {
      super.newsIndex = value;
    });
  }

  final _$questionsAnsweredAtom = Atom(name: '_ContentStore.questionsAnswered');

  @override
  QuestionContent get questionsAnswered {
    _$questionsAnsweredAtom.reportRead();
    return super.questionsAnswered;
  }

  @override
  set questionsAnswered(QuestionContent value) {
    _$questionsAnsweredAtom.reportWrite(value, super.questionsAnswered, () {
      super.questionsAnswered = value;
    });
  }

  final _$symptomPosterAtom = Atom(name: '_ContentStore.symptomPoster');

  @override
  PosterContent get symptomPoster {
    _$symptomPosterAtom.reportRead();
    return super.symptomPoster;
  }

  @override
  set symptomPoster(PosterContent value) {
    _$symptomPosterAtom.reportWrite(value, super.symptomPoster, () {
      super.symptomPoster = value;
    });
  }

  final _$updateAsyncAction = AsyncAction('_ContentStore.update');

  @override
  Future<void> update() {
    return _$updateAsyncAction.run(() => super.update());
  }

  @override
  String toString() {
    return '''
logicContext: ${logicContext},
travelAdvice: ${travelAdvice},
getTheFacts: ${getTheFacts},
protectYourself: ${protectYourself},
homeIndex: ${homeIndex},
learnIndex: ${learnIndex},
newsIndex: ${newsIndex},
questionsAnswered: ${questionsAnswered},
symptomPoster: ${symptomPoster},
unsupportedSchemaVersionAvailable: ${unsupportedSchemaVersionAvailable}
    ''';
  }
}
