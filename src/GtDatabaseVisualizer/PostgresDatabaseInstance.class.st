Class {
	#name : #PostgresDatabaseInstance,
	#superclass : #DatabaseInstance,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseInstance >> populateSchemas [
	| schameNameColumn schemaNames |
	"schemaNames := self client class toDictionaries: self getSchemas."
	schemaNames := self getSchemas.
	schameNameColumn := schemaNames columnNames indexOf: 'name'.
	schemaNames data
		do: [ :aSchema | 
			self schemas
				add: (PostgresDatabaseSchema new
						name: (aSchema at: schameNameColumn);
						client: self client;
						database: self;
						populateTables) ]
]

{ #category : #accessing }
PostgresDatabaseInstance >> query [
	^ query ifNil: [ query := 'SELECT nspname as name FROM pg_namespace ORDER BY nspname' ]
]
