Extension { #name : #CMAbstractModel }

{ #category : #'*Cormas-OpenMole' }
CMAbstractModel >> finalTime: aNumber [

	self simulationManager finalTime: aNumber
]

{ #category : #'*Cormas-OpenMole' }
CMAbstractModel >> loadInputParametersFromJson: aFileReference [

	| jsonString parameters selector |
	
	jsonString := aFileReference
		readStreamDo: [ :stream | stream contents ].
	
	parameters := STONJSON fromString: jsonString.
	
	parameters keysAndValuesDo: [ :parameterName :value |
		selector := (parameterName, ':') asSymbol.
		self perform: selector with: value ].
	

]

{ #category : #'*Cormas-OpenMole' }
CMAbstractModel class >> runOpenMoleSimulation [

	| inputFile outputFile model |
	
	inputFile := FileSystem disk workingDirectory / 'input.json'.
	outputFile := FileSystem disk workingDirectory / 'output.json'.

	model := self new
		loadInputParametersFromJson: inputFile;
		initializeSimulation;
		yourself.
		
	model simulationManager runSimulation.
	model saveProbesToJson: outputFile.
	

]

{ #category : #'*Cormas-OpenMole' }
CMAbstractModel >> saveProbesToJson: aFileReference [

	| probesDictionary jsonString |
	
	probesDictionary := (self class probes collect: [ :selector |
		selector asString -> (self perform: selector)
	]) asDictionary.

	jsonString := STONJSON toString: probesDictionary.
	
	aFileReference writeStreamDo: [ :stream | 
		stream nextPutAll: jsonString ].

]
