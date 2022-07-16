Class {
	#name : #DatabaseSchema,
	#superclass : #Object,
	#traits : 'TGtDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TGtDatabaseEntity classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'database',
		'tables',
		'foreignKeys'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
DatabaseSchema class >> tableClass [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseSchema >> database [

	^ database
]

{ #category : #accessing }
DatabaseSchema >> database: anObject [

	database := anObject
]

{ #category : #accessing }
DatabaseSchema >> foreignKeys [
	^ foreignKeys ifNil: [ foreignKeys := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseSchema >> foreignKeys: anObject [

	foreignKeys := anObject
]

{ #category : #accessing }
DatabaseSchema >> getTables [
	^ self getEntitiesWithArgs: {self name}
]

{ #category : #accessing }
DatabaseSchema >> hierarchyChildren [
	self
		flag: 'TODO: only dealing with tables for now. Account for other DB objects/entities like functions later.'.
	^ children ifNil: [ children := self tables ]
]

{ #category : #accessing }
DatabaseSchema >> hierarchyParent [
	^ parent ifNil: [ parent := database ]
]

{ #category : #accessing }
DatabaseSchema >> populateTables [
	| tableQueryResult |
	tableQueryResult := self getTables.
	tableQueryResult rows
		associationsDo: [ :aTable | 
			self tables
				add: (self class tableClass new
						name: aTable key;
						client: self client;
						schema: self;
						queryResult: (TransformedQueryResult new
								columnHeaders: tableQueryResult columnHeaders;
								rows: aTable value);
						populateColumns) ].
	self allForeignKeys.
	"self allIndexes"
]

{ #category : #accessing }
DatabaseSchema >> printOn: aStream [
	aStream nextPutAll: self class name , '(' , name , ')'
]

{ #category : #accessing }
DatabaseSchema >> tables [
	^ tables ifNil: [ tables := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseSchema >> tables: anObject [

	tables := anObject
]
