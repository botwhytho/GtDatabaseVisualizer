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
DatabaseInstance class >> indexClass [
	^ DatabaseColumnIndex
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
DatabaseInstance >> allIndexes [
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
			| column foreignColumn foreignKey |
			column := self
					findNestedChildByName: {
							row at: (foreignKeyQueryResult columnHeaders indexOf: 'schema_name').
							row at: (foreignKeyQueryResult columnHeaders indexOf: 'table_name').
							row at: (foreignKeyQueryResult columnHeaders indexOf: 'column_name')}.
			foreignColumn := self
					findNestedChildByName: {
							row at: (foreignKeyQueryResult columnHeaders indexOf: 'schema_name').
							row at: (foreignKeyQueryResult columnHeaders indexOf: 'foreign_table_name').
							row at: (foreignKeyQueryResult columnHeaders indexOf: 'foreign_column_name')}.
			foreignKey := self class foreignKeyClass new
					name: (row at: (foreignKeyQueryResult columnHeaders indexOf: 'constraint_name'));
					client: self client;
					table: column table;
					column: column;
					foreignTable: foreignColumn table;
					foreignColumn: foreignColumn.
			column foreignKeys add: foreignKey.
			foreignColumn foreignKeys add: foreignKey.
			column table schema foreignKeys add: foreignKey ]
]

{ #category : #accessing }
DatabaseInstance >> populateIndexes [
	| columnHeaders indexQueryResult |
	self query: self allIndexes.
	indexQueryResult := self getEntitiesWithArgs: nil.
	columnHeaders := indexQueryResult columnHeaders.
	indexQueryResult rows
		do: [ :row | 
			| table columns columnIndex |
			table := self
					findNestedChildByName: {row at: (columnHeaders indexOf: 'schema_name').
							row at: (columnHeaders indexOf: 'table_name')}.
			table
				ifNotNil: [ columns := ($; split: (row at: (columnHeaders indexOf: 'column_names')))
							collect: [ :each | table findNestedChildByName: {each} ].
					columnIndex := self class indexClass new
							name: (row at: (columnHeaders indexOf: 'index_name'));
							client: self client;
							columns: columns;
							unique: (row at: (columnHeaders indexOf: 'is_unique'));
							primary: (row at: (columnHeaders indexOf: 'is_primary'));
							definition: (row at: (columnHeaders indexOf: 'index_definition'));
							algorithm: ('USING' split: (row at: (columnHeaders indexOf: 'index_definition'))) second
									substrings first.
					columns do: [ :each | each ifNotNil: [ each indexes add: columnIndex ] ].
					table schema indexes add: columnIndex ] ]
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
	self populateIndexes.
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
