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
                do: [ spec
                                baseline: 'P3'
                                with: [ spec
                                                repository: 'gitlocal://'
                                                                , (FileLocator home / 'GlamorousToolkit' / 'git-dependencies' / 'P3')
                                                                                pathString ].


			spec package: 'GtDatabaseVisualizer' with: [ spec requires: #('P3') ] ]
]
