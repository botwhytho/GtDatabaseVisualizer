Class {
	#name : #PostgresDatabaseServer,
	#superclass : #DatabaseServer,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseServer class >> databaseConnectorClass [
	^ PostgresDatabaseConnector
]

{ #category : #accessing }
PostgresDatabaseServer class >> databaseInstanceClass [
	^ PostgresDatabaseInstance
]

{ #category : #accessing }
PostgresDatabaseServer >> query [
	"A specific user may not have the rights to see all databases in a server. Furthermore, some databases may not allow connections to them, like typically template0, for example"

	^ query ifNil: [ query := 'SELECT datname as name FROM pg_database ORDER BY datname' ]
]

{ #category : #accessing }
PostgresDatabaseServer >> transformQueryResult: aQueryResult [
	^ TransformedQueryResult new
		columnHeaders: aQueryResult columnNames;
		rows: aQueryResult data
]
