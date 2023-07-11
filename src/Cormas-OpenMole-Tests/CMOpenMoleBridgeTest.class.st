Class {
	#name : #CMOpenMoleBridgeTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'Cormas-OpenMole-Tests'
}

{ #category : #running }
CMOpenMoleBridgeTest >> setUp [

	super setUp.
	
	model := CMMockModel new.
	model class activeProbes: model class probes.
	
	
]

{ #category : #tests }
CMOpenMoleBridgeTest >> testLastDataOfModel [

	| data expectedData |

	model initializeSimulation.
	5 timesRepeat: [ model runStep ].
	
	data := CMOpenMoleBridge lastDataOfModel: model.
	
	expectedData := {
		#numberOfAliveAgents -> model class defaultInitialNumberOfAgents .
		#numberOfDeadAgents -> 0 } asDictionary.
	
	self assert: data equals: expectedData.
]

{ #category : #tests }
CMOpenMoleBridgeTest >> testLoadInputParametersFromJson [

	| contents file |
	
	contents := '{ 
		"numberOfRows": 10,
		"numberOfColumns": 13,
		"initialNumberOfAgents": 2
	}'.
	
	file := FileSystem memory / 'input.json'.
	file writeStreamDo: [ :stream | stream nextPutAll: contents ].

	model loadInputParametersFromJson: file.

	self assert: model numberOfRows equals: 10.
	self assert: model numberOfColumns equals: 13.
	self assert: model initialNumberOfAgents equals: 2.
]

{ #category : #tests }
CMOpenMoleBridgeTest >> testSaveProbesToJson [

	| expectedDictionary actualDictionary file |
	
	expectedDictionary := {
		'numberOfAliveAgents' -> 5 .
		'numberOfDeadAgents' -> 0
	} asDictionary.
	
	file := FileSystem memory / 'output.json'.
	
	model initializeSimulation.
	model saveProbesToJson: file.

	actualDictionary := STONJSON fromString: file contents.

	self assert: actualDictionary equals: expectedDictionary.
]
