"Run one simulation of a zipped Cormas model, and write the final value of each probe to a JSON file.

Arguments, each written as name=value:
  model          the zip of the model folder
  workspace      a folder that does not exist yet, where the model is unzipped and installed
  results        the JSON file to write
  initSelector   the init method
  stepSelector   the control method
  maxSteps       the simulation stops after this step
  stopCondition  a method of the model returning a Boolean, which also stops the simulation, or nothing
  seed           the random seed
  parameter:Class.getter=value   a parameter of an entity class, the value written in JSON
  parameter:getter=value         a parameter of the model
  probe:selector                 a method of the model returning a number"

[
	| arguments valueOf workspace folder modelClass model maxSteps stopSelector parameterValues simulation probes results |
	arguments := Smalltalk arguments.
	valueOf := [ :name |
		(arguments
			detect: [ :each | each beginsWith: name , '=' ]
			ifNone: [ self error: 'Missing argument ' , name ]) allButFirst: name size + 1 ].

	workspace := CMWorkspace createAt: (valueOf value: 'workspace') asFileReference.
	CMWorkspace current: workspace.
	folder := workspace addFromZip: (valueOf value: 'model') asFileReference.
	workspace install: folder.
	modelClass := ((workspace installedModelNamed: folder baselineName) loadedPackages
		flatCollect: [ :each | each definedClasses ])
		detect: [ :each | each inheritsFrom: CMModel ].
	model := modelClass new.

	parameterValues := Dictionary new.
	(arguments select: [ :each | each beginsWith: 'parameter:' ]) do: [ :each |
		| nameAndValue names |
		nameAndValue := (each allButFirst: 'parameter:' size) splitOn: $=.
		names := nameAndValue first splitOn: $..
		names size = 1 ifTrue: [ names := { modelClass name } , names ].
		(parameterValues at: names first ifAbsentPut: [ Dictionary new ])
			at: names second
			put: (STONJSON fromString: nameAndValue second) ].
	model parameterValues: parameterValues.

	maxSteps := (valueOf value: 'maxSteps') asNumber.
	stopSelector := (valueOf value: 'stopCondition') asSymbol.
	simulation := (CMSimulation for: model)
		activeInitSelector: (valueOf value: 'initSelector') asSymbol;
		activeControlSelector: (valueOf value: 'stepSelector') asSymbol;
		randomSeed: (valueOf value: 'seed') asNumber;
		recordLastStepOnly;
		stopWhen: (stopSelector
			ifEmpty: [ [ :aModel | aModel currentTimeStep >= maxSteps ] ]
			ifNotEmpty: [
				[ :aModel | aModel currentTimeStep >= maxSteps or: [ aModel perform: stopSelector ] ] ]);
		yourself.
	simulation
		initializeSimulation;
		runUntilStopped.

	probes := (arguments select: [ :each | each beginsWith: 'probe:' ])
		collect: [ :each | each allButFirst: 'probe:' size ].
	results := Dictionary new.
	probes do: [ :each | results at: each put: (model perform: each asSymbol) asFloat ].
	(valueOf value: 'results') asFileReference
		ensureDelete;
		writeStreamDo: [ :stream | stream nextPutAll: (STONJSON toString: results) ].
	Smalltalk snapshot: false andQuit: true ]
	on: Error
	do: [ :error |
		Stdio stderr
			nextPutAll: 'Cormas: ' , error description;
			lf.
		error signalerContext stack do: [ :each |
			Stdio stderr
				nextPutAll: each printString;
				lf ].
		Smalltalk exitFailure ]
