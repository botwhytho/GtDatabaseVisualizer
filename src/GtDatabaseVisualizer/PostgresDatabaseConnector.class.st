Class {
	#name : #PostgresDatabaseConnector,
	#superclass : #DatabaseConnector,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseConnector class >> fromConnectionString: aConnectionString [
	^ self new client: (P3Client new url: aConnectionString)
]

{ #category : #accessing }
PostgresDatabaseConnector class >> fromConnectionString: aConnectionString withShortName: aShortName [
	^ self new
		shortName: aShortName;
		client: (P3Client new url: aConnectionString)
]

{ #category : #accessing }
PostgresDatabaseConnector class >> toDictionaries: aP3Result [
	^ aP3Result data
		collect: [ :row | 
			(row
				collectWithIndex: [ :column :index | (aP3Result descriptions at: index) fieldName -> column ])
				asOrderedDictionary as: NeoJSONObject ]
]

{ #category : #accessing }
PostgresDatabaseConnector >> closeConnection [
	client close
]

{ #category : #accessing }
PostgresDatabaseConnector >> printOn: aStream [
	aStream
		nextPutAll: (shortName
				ifNil: [ client host ]
				ifNotNil: [ shortName , '(' , client host , ')' ])
]

{ #category : #accessing }
PostgresDatabaseConnector >> query: aString [
	^ client in: [ :p3Client | [ p3Client query: aString ] ensure: [ client close ] ]
]

{ #category : #accessing }
PostgresDatabaseConnector >> query: aString withArguments: args [
	| statement |
	statement := client prepare: aString.
	^ client in: [ :p3Client | [ statement query: args ] ensure: [ client close ] ]
]

{ #category : #accessing }
PostgresDatabaseConnector >> testConnection [
	^ client in: [ :p3Client | [ p3Client isWorking ] ensure: [ client close ] ]
]
