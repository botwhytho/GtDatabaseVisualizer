Class {
	#name : #DatabaseColumn,
	#superclass : #Object,
	#traits : 'TGtDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TGtDatabaseEntity classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'attributes',
		'table'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
DatabaseColumn >> attributes [
	^ attributes ifNil: [ attributes := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseColumn >> attributes: anObject [

	attributes := anObject
]

{ #category : #accessing }
DatabaseColumn >> getColumnAttributes [
	^ self
		getEntitiesWithArgs: {self table schema name.
				self table name.
				self name}
]

{ #category : #accessing }
DatabaseColumn >> hierarchyChildren [
	^ children ifNil: [ children := self attributes ]
]

{ #category : #accessing }
DatabaseColumn >> hierarchyParent [
	^ parent ifNil: [ parent := table ]
]

{ #category : #accessing }
DatabaseColumn >> printOn: aStream [
	aStream nextPutAll: self class name , '(' , name , ')'
]

{ #category : #accessing }
DatabaseColumn >> table [

	^ table
]

{ #category : #accessing }
DatabaseColumn >> table: anObject [

	table := anObject
]
