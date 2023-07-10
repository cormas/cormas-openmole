Class {
	#name : #BaselineOfCormasOpenMole,
	#superclass : #BaselineOf,
	#category : #BaselineOfCormasOpenMole
}

{ #category : #baselines }
BaselineOfCormasOpenMole >> baseline: spec [

	<baseline>
	spec for: #common do: [
		"Dependencies"
		self loadCormas: spec.

		"Packages"
		spec
			package: 'Cormas-OpenMole' with: [ spec requires: #( 'Cormas' ) ];
			package: 'Cormas-OpenMole-Tests' with: [ spec requires: #( 'Cormas-OpenMole' ) ] ].
]

{ #category : #'as yet unclassified' }
BaselineOfCormasOpenMole >> loadCormas: spec [

	spec
		baseline: 'Cormas'
		with: [ spec loads: #(Core); repository: 'github://cormas/cormas:v0.5' ]
]
