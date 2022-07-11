Class {
	#name : #PostgresDatabaseServer,
	#superclass : #DatabaseServer,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseServer class >> fromConnectionString: aString [
	| connector |
	connector := PostgresDatabaseConnector fromConnectionString: aString.
	^ self new
		name: connector client asString;
		client: connector;
		populateDatabases
]

{ #category : #accessing }
PostgresDatabaseServer class >> fromConnectionString: aString withShortName: aShortName [
	^ self new
		name: aShortName;
		client: (PostgresDatabaseConnector
				fromConnectionString: aString
				withShortName: aShortName);
		populateDatabases
]

{ #category : #accessing }
PostgresDatabaseServer >> populateDatabases [
	| databasesNames |
	databasesNames := self client class toDictionaries: self getDatabases.

	self databases
		addAll: (databasesNames
				collect: [ :aDatabase | 
					PostgresDatabaseInstance new
						name: aDatabase name;
						client: self client;
						server: self;
						populateSchemas	";
						yourself" ])
]

{ #category : #accessing }
PostgresDatabaseServer >> query [
	"A specific user may not have the rights to see all databases in a server. Furthermore, some databases may not allow connections to them, like typically template0, for example"

	^ query ifNil: [ query := 'SELECT datname as name FROM pg_database ORDER BY datname' ]
]
