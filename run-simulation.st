| config modelClass model writeResults |

config := STONJSON fromString: '/work/config.json' asFileReference contents.

modelClass := Smalltalk at: (config at: 'modelClass') asSymbol.
model := modelClass new.

writeResults := [
  | probes results |

  probes := config at: 'probes'.
  results := Dictionary new.

  probes do: [ :probeName |
    results
      at: probeName
      put: (model perform: probeName asSymbol)
  ].

  '/work/results.json' asFileReference
    ensureDelete;
    writeStreamDo: [ :stream |
      stream nextPutAll: (STONJSON toString: results)]
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