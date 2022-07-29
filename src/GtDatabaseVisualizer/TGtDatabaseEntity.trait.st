Trait {
	#name : #TGtDatabaseEntity,
	#instVars : [
		'valuable',
		'client',
		'query',
		'name',
		'queryResult',
		'metadata'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
TGtDatabaseEntity >> client [

	^ client
]

{ #category : #accessing }
TGtDatabaseEntity >> client: anObject [

	client := anObject
]

{ #category : #accessing }
TGtDatabaseEntity >> getEntitiesWithArgs: argsArrayOrNil [
	^ queryResult
		ifNil: [ valuable
				ifNil: [ self
						transformQueryResult: (client query: self query withArguments: argsArrayOrNil) ]
				ifNotNil: [ argsArrayOrNil
						ifNil: [ valuable value ]
						ifNotNil: [ valuable valueWithArguments: argsArrayOrNil ] ] ]
]

{ #category : #accessing }
TGtDatabaseEntity >> metadata [

	^ metadata
]

{ #category : #accessing }
TGtDatabaseEntity >> metadata: anObject [

	metadata := anObject
]

{ #category : #accessing }
TGtDatabaseEntity >> name [

	^ name
]

{ #category : #accessing }
TGtDatabaseEntity >> name: anObject [

	name := anObject
]

{ #category : #accessing }
TGtDatabaseEntity >> query [

	^ query
]

{ #category : #accessing }
TGtDatabaseEntity >> query: anObject [

	query := anObject
]

{ #category : #accessing }
TGtDatabaseEntity >> queryResult [

	^ queryResult
]

{ #category : #accessing }
TGtDatabaseEntity >> queryResult: anObject [

	queryResult := anObject
]

{ #category : #accessing }
TGtDatabaseEntity >> transformQueryResult: aQueryResult [
	"This is responsible for transforming different SQL client results into a generic format returning a `TransformedQueryResult` that has an array of `columnHeaders` & and a `rows` array of arrays"

	^ self shouldBeImplemented
]

{ #category : #accessing }
TGtDatabaseEntity >> valuable [

	^ valuable
]

{ #category : #accessing }
TGtDatabaseEntity >> valuable: anObject [

	valuable := anObject
]
