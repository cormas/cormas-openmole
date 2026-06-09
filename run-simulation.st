| config modelClass model parameterArguments writeResults |

config := STONJSON fromString: 'config.json' asFileReference contents.

modelClass := Smalltalk at: (config at: 'modelClass') asSymbol.
model := modelClass new.

parameterArguments := Smalltalk arguments
  select: [ :each | each includesSubstring: '=' ].

parameterArguments do: [ :argument |
  | parts name value |
  parts := argument splitOn: $=.
  name := parts first.
  value := STONJSON fromString: parts second.

  model
    perform: name asSymbol asMutator
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