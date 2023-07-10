Class {
	#name : #BaselineOfCormasOpenMole,
	#superclass : #BaselineOf,
	#category : #BaselineOfCormasOpenMole
}

{ #category : #baselines }
BaselineOfCormasOpenMole >> baseline: spec [

	<baseline>
	spec for: #common do: [

		"Packages"
		spec
			package: 'Cormas-OpenMole';
			package: 'Cormas-OpenMole-Tests' with: [ spec requires: #( 'Cormas-OpenMole' ) ] ].
]
