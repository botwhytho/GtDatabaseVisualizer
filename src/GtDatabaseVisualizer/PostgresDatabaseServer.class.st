Class {
	#name : #PostgresDatabaseServer,
	#superclass : #DatabaseServer,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseServer class >> fromConnectionString: aString [
	| connector |
	connector := PostgresDatabaseConnector fromConnectionString: aString.
	^ self
		populateInBackground: (self new
				name: connector client asString;
				client: connector)
]

{ #category : #accessing }
PostgresDatabaseServer class >> fromConnectionString: aString withShortName: aShortName [
	| connector |
	connector := PostgresDatabaseConnector
			fromConnectionString: aString
			withShortName: aShortName.
	^ self
		populateInBackground: (self new
				name: aShortName;
				client: connector)
]

{ #category : #accessing }
PostgresDatabaseServer class >> populateInBackground: aDatabaseServer [
	| thisCoder |
	thisCoder := (thisContext stack
			detect: [ :each | each contextClass = GtPharoSourceCoder ]) receiver.
	"[" self inform: 'Beginning import.'.
	"["[ aDatabaseServer populateDatabases ] ensure: [ aDatabaseServer client client close ]"] timeProfile".
	self inform: 'Finished import.'.
	thisCoder
		notifyToolSpawn: (GtInspectorTool forObject: aDatabaseServer)
		withDestination: thisCoder spawnDestination "]
		forkAt: 29
		named: #postgresSchemaPopulate"
]

{ #category : #accessing }
PostgresDatabaseServer >> populateDatabases [
	| databaseNameColumn databasesNames |
	"databasesNames := self client class toDictionaries: self getDatabases."
	databasesNames := self getDatabases.
	databaseNameColumn := databasesNames columnNames indexOf: 'name'.
	databasesNames data
		do: [ :aDatabase | 
			(aDatabase at: databaseNameColumn) = 'template0'
				ifFalse: [ self client client database: (aDatabase at: databaseNameColumn).
					self databases
						add: (PostgresDatabaseInstance new
								name: (aDatabase at: databaseNameColumn);
								client: self client;
								server: self;
								populateSchemas) ] ]
]

{ #category : #accessing }
PostgresDatabaseServer >> query [
	"A specific user may not have the rights to see all databases in a server. Furthermore, some databases may not allow connections to them, like typically template0, for example"

	^ query ifNil: [ query := 'SELECT datname as name FROM pg_database ORDER BY datname' ]
]
