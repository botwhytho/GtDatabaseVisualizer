Class {
	#name : #PostgresDatabaseSchema,
	#superclass : #DatabaseSchema,
	#instVars : [
		'allColumns'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseSchema >> allColumns [
	| allColumnsInSchema |
	allColumnsInSchema := 'SELECT "table_name", column_name, ordinal_position, column_default, is_nullable, data_type
FROM information_schema.columns
WHERE table_schema = $1
ORDER BY "table_name", ordinal_position'.
	^ allColumns
		ifNil: [ allColumns := client class
					toDictionaries: (client query: allColumnsInSchema withArguments: {name}) ]
]

{ #category : #accessing }
PostgresDatabaseSchema >> populateTables [
	| tableNames |
	tableNames := self client class toDictionaries: self getTables.
	tableNames
		do: [ :aTable | 
			self tables
				add: (PostgresDatabaseTable new
						name: aTable name;
						client: self client;
						schema: self;
						valuable: (MessageSend receiver: self selector: #allColumns);
						populateColumns) ]
]

{ #category : #accessing }
PostgresDatabaseSchema >> query [
	^ query
		ifNil: [ query := 'SELECT tablename AS name FROM pg_catalog.pg_tables WHERE schemaname = $1 ORDER BY tablename' ]
]
