Class {
	#name : #DatabaseInstance,
	#superclass : #Object,
	#traits : 'TGtDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TGtDatabaseEntity classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'server',
		'schemas'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
DatabaseInstance class >> schemaClass [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseInstance >> getSchemas [
	^ self getEntitiesWithArgs: nil
]

{ #category : #accessing }
DatabaseInstance >> hierarchyChildren [
	^ hierarchyChildren ifNil: [ hierarchyChildren := self schemas ]
]

{ #category : #accessing }
DatabaseInstance >> hierarchyParent [
	^ hierarchyParent ifNil: [ hierarchyParent := server ]
]

{ #category : #accessing }
DatabaseInstance >> populateSchemas [
	| groupedEntites schemaQueryResult |
	schemaQueryResult := self getSchemas.
	groupedEntites := schemaQueryResult rows
			groupedBy: [ :row | row at: (schemaQueryResult columnHeaders indexOf: 'schema_name') ].
	groupedEntites
		associationsDo: [ :each | 
			each
				value: (each value
						groupedBy: [ :row | row at: (schemaQueryResult columnHeaders indexOf: 'table_name') ]) ].
	groupedEntites
		do: [ :each | 
			each
				associationsDo: [ :inner | 
					inner
						value: (inner value
								groupedBy: [ :row | row at: (schemaQueryResult columnHeaders indexOf: 'column_name') ]) ] ].
	groupedEntites
		associationsDo: [ :aSchema | 
			self schemas
				add: (self class schemaClass new
						name: aSchema key;
						client: self client;
						database: self;
						queryResult: (TransformedQueryResult new
								columnHeaders: schemaQueryResult columnHeaders;
								rows: aSchema value);
						populateTables) ]
]

{ #category : #accessing }
DatabaseInstance >> printOn: aStream [
	aStream nextPutAll: self class name , '(' , name , ')'
]

{ #category : #accessing }
DatabaseInstance >> schemas [
	^ schemas ifNil: [ schemas := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseInstance >> schemas: anObject [

	schemas := anObject
]

{ #category : #accessing }
DatabaseInstance >> server [

	^ server
]

{ #category : #accessing }
DatabaseInstance >> server: anObject [

	server := anObject
]
