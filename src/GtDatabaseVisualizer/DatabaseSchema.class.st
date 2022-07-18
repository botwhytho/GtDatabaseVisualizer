Class {
	#name : #DatabaseSchema,
	#superclass : #Object,
	#traits : 'TGtDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TGtDatabaseEntity classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'database',
		'tables',
		'foreignKeys',
		'indexes'
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
	^ self getEntitiesWithArgs: nil
]

{ #category : #accessing }
DatabaseSchema >> hierarchyChildren [
	self
		flag: 'TODO: only dealing with tables for now. Account for other DB objects/entities like functions later.'.
	^ hierarchyChildren ifNil: [ hierarchyChildren := self tables ]
]

{ #category : #accessing }
DatabaseSchema >> hierarchyParent [
	^ hierarchyParent ifNil: [ hierarchyParent := database ]
]

{ #category : #accessing }
DatabaseSchema >> indexes [
	^ indexes ifNil: [ indexes := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseSchema >> indexes: anObject [

	indexes := anObject
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
						populateColumns) ]
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
