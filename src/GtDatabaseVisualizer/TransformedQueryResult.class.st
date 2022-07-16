Class {
	#name : #TransformedQueryResult,
	#superclass : #Object,
	#instVars : [
		'columnHeaders',
		'rows'
	],
	#category : #'GtDatabaseVisualizer-GtDatabaseVisualizer'
}

{ #category : #accessing }
TransformedQueryResult >> columnHeaders [

	^ columnHeaders
]

{ #category : #accessing }
TransformedQueryResult >> columnHeaders: anObject [

	columnHeaders := anObject
]

{ #category : #accessing }
TransformedQueryResult >> rows [

	^ rows
]

{ #category : #accessing }
TransformedQueryResult >> rows: anObject [

	rows := anObject
]
