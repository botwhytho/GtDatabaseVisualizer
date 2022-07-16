Class {
	#name : #PostgresDatabaseInstance,
	#superclass : #DatabaseInstance,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseInstance class >> schemaClass [
	^ PostgresDatabaseSchema
]

{ #category : #accessing }
PostgresDatabaseInstance >> query [
	^ query
		ifNil: [ query := 'SELECT table_schema AS schema_name, table_name, column_name, ordinal_position, column_default, is_nullable, data_type
FROM information_schema.columns
ORDER BY table_schema, table_name, ordinal_position' ]
]

{ #category : #accessing }
PostgresDatabaseInstance >> transformQueryResult: aQueryResult [
	^ TransformedQueryResult new
		columnHeaders: aQueryResult columnNames;
		rows: aQueryResult data
]
