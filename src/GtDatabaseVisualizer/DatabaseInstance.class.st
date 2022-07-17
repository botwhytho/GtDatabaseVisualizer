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
DatabaseInstance class >> foreignKeyClass [
	^ DatabaseForeignKey
]

{ #category : #accessing }
DatabaseInstance class >> schemaClass [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseInstance >> allForeignKeys [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseInstance >> getSchemas [
	^ self getEntitiesWithArgs: nil
]

{ #category : #accessing }
DatabaseInstance >> groupQueryResult: schemaQueryResult [
	"This turns rows that have 'schema_name', 'tatble_name', 'column_name' and an arbitraty number of additional columns into nested Dictionaries to assist with turning those rows into domain objects"

	| groupedEntites |
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
	^ groupedEntites
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
DatabaseInstance >> populateForeignKeys [
	| foreignKeyQueryResult |
	self query: self allForeignKeys.
	foreignKeyQueryResult := self getEntitiesWithArgs: nil.
	foreignKeyQueryResult rows
		do: [ :row | 
			| column foreignColumn foreignKey foreignTable schema table |
			schema := self schemas
					detect: [ :each | 
						each name
							= (row at: (foreignKeyQueryResult columnHeaders indexOf: 'schema_name')) ].
			table := schema tables
					detect: [ :each | 
						each name
							= (row at: (foreignKeyQueryResult columnHeaders indexOf: 'table_name')) ].
			column := table columns
					detect: [ :each | 
						each name
							= (row at: (foreignKeyQueryResult columnHeaders indexOf: 'column_name')) ].
			foreignTable := schema tables
					detect: [ :each | 
						each name
							= (row at: (foreignKeyQueryResult columnHeaders indexOf: 'foreign_table_name')) ].
			foreignColumn := foreignTable columns
					detect: [ :each | 
						each name
							= (row at: (foreignKeyQueryResult columnHeaders indexOf: 'foreign_column_name')) ].
			foreignKey := self class foreignKeyClass new
					name: (row at: (foreignKeyQueryResult columnHeaders indexOf: 'constraint_name'));
					client: self client;
					table: table;
					column: column;
					foreignTable: foreignTable;
					foreignColumn: foreignColumn.
			column foreignKeys add: foreignKey.
			foreignColumn foreignKeys add: foreignKey.
			schema foreignKeys add: foreignKey ]
]

{ #category : #accessing }
DatabaseInstance >> populateSchemas [
	| groupedEntites schemaQueryResult |
	schemaQueryResult := self getSchemas.
	groupedEntites := self groupQueryResult: schemaQueryResult.
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
						populateTables) ].
	self populateForeignKeys.
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
