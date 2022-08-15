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
DatabaseColumn >> asRelationsViewElement [
	| items |
	items := {BlTextElement new text: self name asRopedText} asOrderedCollection.
	self indexes
		ifNotEmpty: [ items addFirst: BrGlamorousVectorIcons emphasizedInspect asElement ].
	self foreignKeys
		detect: [ :fk | fk foreignColumn = self ]
		ifFound: [ items addFirst: BrGlamorousVectorIcons right asElement ].
	self foreignKeys
		detect: [ :fk | fk column = self ]
		ifFound: [ items addLast: BrGlamorousVectorIcons right asElement ].

	^ BrHorizontalPane new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		addChildren: items
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
		getEntitiesWithArgs: nil
]

{ #category : #accessing }
DatabaseColumn >> gtAttributesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Column Attributes';
		priority: 1;
		items: [ self attributes , self indexes , self foreignKeys ];
		column: 'Name' text: [ :aNode :anIndex | aNode name ];
		column: 'Value'
			text: [ :aNode :anIndex | 
				| value |
				(aNode isKindOf: DatabaseColumnAttribute) ifTrue: [ value := aNode value ].
				(aNode isKindOf: DatabaseColumnIndex) ifTrue: [ value := aNode definition ].
				(aNode isKindOf: DatabaseForeignKey)
					ifTrue: [ value := aNode table name , '.' , aNode column name , ' -> '
								, aNode foreignTable name , '.' , aNode foreignColumn name ].
				value ]
]

{ #category : #accessing }
DatabaseColumn >> hierarchyChildren [
	^ hierarchyChildren
		ifNil: [ hierarchyChildren := self attributes , self indexes , self foreignKeys ]
]

{ #category : #accessing }
DatabaseColumn >> hierarchyParent [
	^ table
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
