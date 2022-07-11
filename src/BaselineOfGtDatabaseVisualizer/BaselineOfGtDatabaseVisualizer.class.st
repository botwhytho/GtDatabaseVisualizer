Class {
	#name : #BaselineOfGtDatabaseVisualizer,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtDatabaseVisualizer
}

{ #category : #baseline }
BaselineOfGtDatabaseVisualizer >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec baseline: 'P3' with: [ spec repository: 'github://svenvc/P3:master' ].

			spec package: 'GtDatabaseVisualizer' ]
]
