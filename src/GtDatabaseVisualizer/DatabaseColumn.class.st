Class {
	#name : #DatabaseColumn,
	#superclass : #Object,
	#traits : 'TGtDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TGtDatabaseEntity classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'attributes',
		'table',
		'indexes',
		'foreignKeys'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
DatabaseColumn class >> columnAttributeClass [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseColumn >> attributes [
	^ attributes ifNil: [ attributes := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseColumn >> attributes: anObject [

	attributes := anObject
]

{ #category : #accessing }
DatabaseColumn >> foreignKeys [
	^ foreignKeys ifNil: [ foreignKeys := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseColumn >> foreignKeys: anObject [

	foreignKeys := anObject
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
	^ hierarchyChildren ifNil: [ hierarchyChildren := self attributes ]
]

{ #category : #accessing }
DatabaseColumn >> hierarchyParent [
	^ hierarchyParent ifNil: [ hierarchyParent := table ]
]

{ #category : #accessing }
DatabaseColumn >> indexes [
	^ indexes ifNil: [ indexes := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseColumn >> indexes: anObject [

	indexes := anObject
]

{ #category : #accessing }
DatabaseColumn >> populateColumnAttributes [
	| attributeNames columnAttributeQueryResult |
	columnAttributeQueryResult := self getColumnAttributes.
	attributeNames := columnAttributeQueryResult columnHeaders.
	columnAttributeQueryResult rows
		associationsDo: [ :aColumnAttributeRow | 
			(attributeNames reject: [:each| #('schema_name' 'table_name' 'column_name') includes: each])
				do: [ :aColumnAttribute | 
					self attributes
						add: ((self class columnAttributeClass) new
								name: aColumnAttribute;
								value: (aColumnAttributeRow at: (attributeNames indexOf: aColumnAttribute));
								client: self client;
								column: self) ] ]
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
