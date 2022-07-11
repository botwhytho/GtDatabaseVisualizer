Trait {
	#name : #TDatabaseEntity,
	#instVars : [
		'valuable',
		'client',
		'query',
		'name'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
TDatabaseEntity >> client [

	^ client
]

{ #category : #accessing }
TDatabaseEntity >> client: anObject [

	client := anObject
]

{ #category : #accessing }
TDatabaseEntity >> getEntities [
	^ valuable ifNil: [ client query: self query ] ifNotNil: [ valuable value ]
]

{ #category : #accessing }
TDatabaseEntity >> getEntities: withArgs [
	^ valuable
		ifNil: [ withArgs
				ifNil: [ client query: self query ]
				ifNotNil: [ client query: self query withArguments: withArgs ] ]
		ifNotNil: [ withArgs
				ifNil: [ valuable value ]
				ifNotNil: [ valuable valueWithArguments: withArgs ] ]
]

{ #category : #accessing }
TDatabaseEntity >> name [

	^ name
]

{ #category : #accessing }
TDatabaseEntity >> name: anObject [

	name := anObject
]

{ #category : #accessing }
TDatabaseEntity >> query [

	^ query
]

{ #category : #accessing }
TDatabaseEntity >> query: anObject [

	query := anObject
]

{ #category : #accessing }
TDatabaseEntity >> valuable [

	^ valuable
]

{ #category : #accessing }
TDatabaseEntity >> valuable: anObject [

	valuable := anObject
]
