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
PostgresDatabaseInstance >> allIndexes [
	^ '
-- Get the index id & related column names in the order they apply to the index. Sorting on the index/ordinality column created with `WITH ORDINALITY` command is key to next step
WITH ordered_index_columns AS (
SELECT idx.indexrelid AS index_id, idx.indrelid AS table_id, cols.position AS column_position, cols.index AS index_column_ordinality, attr.attname AS column_name
FROM
    pg_index AS idx,
    unnest(string_to_array(idx.indkey::text, '' '')::int2[]) WITH ORDINALITY AS cols (position, index),
    pg_attribute AS attr
WHERE
    idx.indrelid = attr.attrelid
    AND cols.position = attr.attnum
ORDER BY index_id, index_column_ordinality
),
-- Aggregate different column names into one comma-separated column. The last step ensures they are in correct order
ordered_column_names AS (
SELECT idx_col.index_id, array_to_string(array_agg(idx_col.column_name), '', '') AS column_names
FROM ordered_index_columns AS idx_col
GROUP By index_id
)
SELECT
    ns.nspname AS schema_name,
    tbl.relname AS table_name,
    i.relname AS index_name,
    cols.column_names,
    idx.indisunique AS is_unique,
    idx.indisprimary AS is_primary,
    idx_def.indexdef AS index_definition
FROM ordered_column_names AS cols
    JOIN pg_index AS idx ON idx.indexrelid = cols.index_id 
    JOIN pg_class AS tbl ON tbl.oid = idx.indrelid
    JOIN pg_namespace AS ns ON ns.oid = tbl.relnamespace
    JOIN pg_class AS i ON i.oid = idx.indexrelid
    LEFT JOIN pg_indexes AS idx_def ON idx_def.schemaname = ns.nspname AND idx_def.tablename = tbl.relname AND idx_def.indexname = i.relname
ORDER BY
    schema_name,
    table_name,
    index_name'
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
