Class {
	#name : #DatabaseColumnIndex,
	#superclass : #DatabaseColumnAttribute,
	#instVars : [
		'columns',
		'unique',
		'primary',
		'definition',
		'algorithm'
	],
	#category : #'GtDatabaseVisualizer-GtDatabaseVisualizer'
}

{ #category : #accessing }
DatabaseColumnIndex >> algorithm [

	^ algorithm
]

{ #category : #accessing }
DatabaseColumnIndex >> algorithm: anObject [

	algorithm := anObject
]

{ #category : #accessing }
DatabaseColumnIndex >> columns [
	^ columns ifNil: [ columns := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseColumnIndex >> columns: anObject [

	columns := anObject
]

{ #category : #accessing }
DatabaseColumnIndex >> definition [

	^ definition
]

{ #category : #accessing }
DatabaseColumnIndex >> definition: anObject [

	definition := anObject
]

{ #category : #accessing }
DatabaseColumnIndex >> primary [

	^ primary
]

{ #category : #accessing }
DatabaseColumnIndex >> primary: anObject [

	primary := anObject
]

{ #category : #accessing }
DatabaseColumnIndex >> unique [

	^ unique
]

{ #category : #accessing }
DatabaseColumnIndex >> unique: anObject [

	unique := anObject
]
