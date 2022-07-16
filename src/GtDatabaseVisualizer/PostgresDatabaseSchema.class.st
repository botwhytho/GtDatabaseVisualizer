Class {
	#name : #PostgresDatabaseSchema,
	#superclass : #DatabaseSchema,
	#instVars : [
		'allColumns',
		'allForeignKeys'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseSchema class >> tableClass [
	^ PostgresDatabaseTable
]

{ #category : #accessing }
PostgresDatabaseSchema >> allForeignKeys [
	| allForeignKeysInSchema |
	allForeignKeysInSchema := 'SELECT conrelid::regclass::text AS table_name, ta.attname AS column_name,
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
  WHERE ns.nspname = $1
  ORDER BY "table_name", column_name'.
	^ allForeignKeys
		ifNil: [ allForeignKeys := client class
					toDictionaries: (client query: allForeignKeysInSchema withArguments: {name}) ]
]

{ #category : #accessing }
PostgresDatabaseSchema >> allIndexes [
]
