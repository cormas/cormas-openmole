Class {
	#name : #CMOpenMoleBridge,
	#superclass : #Object,
	#category : #'Cormas-OpenMole'
}

{ #category : #accessing }
CMOpenMoleBridge class >> lastDataOfModel: aModelInstance [
	"a Dictionnary is a dictionnary formatted by CORMAS with name of the class containing a dictionnary of keys"

	"representing values, containing collection"

	"This is a really bad conception and we need to replace all of this by DataFrame later :-)"

	| d  |
	d := Dictionary new.
	(aModelInstance data at: aModelInstance class name) keysAndValuesDo: [ :k :v | d at: k put: v last ].
	 ^d
]

{ #category : #accessing }
CMOpenMoleBridge class >> lastValuesOfVariables: aDictionnary [
	"a Dictionnary is a dictionnary formatted by CORMAS with name of the class containing a dictionnary of keys"

	"representing values, containing collection"

	"This is a really bad conception and we need to replace all of this by DataFrame later :-)"

	| d r |
	d := Dictionary new.
	(aDictionnary at: self name) keysAndValuesDo: [ :k :v | d at: k put: v last ].
	r := Dictionary new.
	r at: self name asSymbol put: d.
	^ r
]

{ #category : #'file in/out' }
CMOpenMoleBridge class >> loadJSONFile: theJSONFile [
	"OpenMole send a .json file. With this method you can read it. You pass in argument the name of JSON file"

	| workingDirectory jsonString |
	
	workingDirectory := FileSystem disk workingDirectory.
	
	jsonString := workingDirectory / theJSONFile
		readStreamDo: [ :stream | stream contents ].
	
	^ STONJSON fromString: jsonString.
]

{ #category : #'file in/out' }
CMOpenMoleBridge class >> saveJSONFile: myDictionary [
	"OpenMole read  .json file. With this method you can write a JSONfile from a dictonary"

	| workingDirectory |
	workingDirectory := FileSystem disk workingDirectory.
	
	(workingDirectory / 'output.json') asFileReference
		writeStreamDo: [ :stream | 
			STONJSON put: myDictionary onStream: stream ]
]
