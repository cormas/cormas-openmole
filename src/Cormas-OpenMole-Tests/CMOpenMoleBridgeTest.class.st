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
		#numberOfAliveAgents -> model class defaultNumberOfAgents .
		#numberOfDeadAgents -> 0 } asDictionary.
	
	self assert: data equals: expectedData.
]
