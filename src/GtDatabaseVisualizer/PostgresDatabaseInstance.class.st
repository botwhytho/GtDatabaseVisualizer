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
PostgresDatabaseInstance >> allForeignKeys [
	^ 'SELECT ns.nspname AS schema_name, conrelid::regclass::text AS table_name, ta.attname AS column_name,
       confrelid::regclass::text AS foreign_table_name, fa.attname AS foreign_column_name,
       conname AS constraint_name 
  FROM (
   SELECT conname, connamespace, conrelid, confrelid,
          unnest(conkey) AS conkey, unnest(confkey) AS confkey
     FROM pg_constraint
  ) sub
  JOIN pg_attribute AS ta ON ta.attrelid = conrelid AND ta.attnum = conkey
  JOIN pg_attribute AS fa ON fa.attrelid = confrelid AND fa.attnum = confkey
  JOIN pg_namespace AS ns ON sub.connamespace = ns.oid
  ORDER BY schema_name, table_name, column_name'
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
