| modelClass model arguments argNamed parameterArguments probeArguments initSelector stepSelector maxSteps stopConditionSelector stopCondition seed writeResults |

modelClass := CMModel installModelFromFile: 'model.cmx' asFileReference.
model := modelClass new.

arguments := Smalltalk arguments.

argNamed := [ :name | (arguments detect: [ :each | each beginsWith: name ]) copyAfter: $= ].

initSelector := (argNamed value: 'initSelector') asSymbol.
stepSelector := (argNamed value: 'stepSelector') asSymbol.
maxSteps := STONJSON fromString: (argNamed value: 'maxSteps').
stopConditionSelector := (argNamed value: 'stopCondition') asSymbol.
seed := STONJSON fromString: (argNamed value: 'seed').

stopCondition := stopConditionSelector
  ifEmpty: [
    [ :model |
      model simulationContext currentTimeStep >= maxSteps
    ]
  ]
  ifNotEmpty: [
    [ :model |
      model simulationContext currentTimeStep >= maxSteps
        or: [ model perform: stopConditionSelector ]
    ]
  ].

parameterArguments := arguments
  select: [ :each | each beginsWith: 'parameter:' ].

parameterArguments do: [ :argument |
  | parts fullName value nameParts target parameterName |

  parts := (argument allButFirst: 'parameter:' size) splitOn: $=.
  fullName := parts first.
  value := STONJSON fromString: parts second.

  nameParts := fullName splitOn: $..

  nameParts size = 1
    ifTrue: [
      target := model.
      parameterName := nameParts first
    ]
    ifFalse: [
      target := Smalltalk at: nameParts first asSymbol.
      parameterName := nameParts second
    ].

  target
    perform: parameterName asSymbol asMutator
    with: value
].

probeArguments := arguments
  select: [ :each | each beginsWith: 'probe:' ].

writeResults := [
  | probes results |

  probes := probeArguments collect: [ :each |
    each allButFirst: 'probe:' size
  ].

  results := Dictionary new.

  probes do: [ :probeName |
    results
      at: probeName
      put: (model perform: probeName asSymbol)
  ].

  'results.json' asFileReference
    ensureDelete;
    writeStreamDo: [ :stream |
      stream nextPutAll: (STONJSON toString: results)
    ].

  Smalltalk snapshot: false andQuit: true
].

(CMSimulation for: model)
  activeInitSelector: initSelector;
  activeControlSelector: stepSelector;
  stopWhen: stopCondition;
  whenFinishedDo: writeResults;
  randomSeed: seed;
  initializeSimulation;
  runAllSteps.