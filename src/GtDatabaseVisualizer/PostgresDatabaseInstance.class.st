Class {
	#name : #PostgresDatabaseInstance,
	#superclass : #DatabaseInstance,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseInstance >> populateSchemas [
	| schemaNames |
	schemaNames := self client class toDictionaries: self getSchemas.
	schemaNames
		do: [ :aSchema | 
			self schemas
				add: (PostgresDatabaseSchema new
						name: aSchema name;
						client: self client;
						database: self;
						populateTables) ]
]

{ #category : #accessing }
PostgresDatabaseInstance >> query [
	^ query ifNil: [ query := 'SELECT nspname as name FROM pg_namespace ORDER BY nspname' ]
]
