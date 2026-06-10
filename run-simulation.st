| config modelClass model parameterArguments writeResults |

config := STONJSON fromString: 'config.json' asFileReference contents.
modelClass := CMModel installModelFromFile: 'model.cmx' asFileReference.
model := modelClass new.

parameterArguments := Smalltalk arguments
  select: [ :each | each includesSubstring: '=' ].

parameterArguments do: [ :argument |
  | parts fullName value nameParts target parameterName |

  parts := argument splitOn: $=.
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

writeResults := [
  | probes results |

  probes := config at: 'probes'.
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
  activeInitSelector: (config at: 'initSelector') asSymbol;
  activeControlSelector: (config at: 'stepSelector') asSymbol;
  stopAfterStep: (config at: 'numberOfSteps');
  whenFinishedDo: writeResults;
  initializeSimulation;
  runAllSteps.