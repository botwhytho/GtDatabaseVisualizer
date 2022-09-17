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
TGtDatabaseEntity >> gtSpotterEntitiesFor: aStep [
	<gtSearch>
	({GtDatabaseVisualizer.
		DatabaseServer.
		DatabaseInstance.
		DatabaseSchema} anySatisfy: [ :each | self isKindOf: each ])
		ifTrue: [ ^ self ].
	((self hierarchyParent deepCollect: #hierarchyChildren) groupedBy: #class)
		associations
		withIndexDo: [ :each :index | 
			each value: each value asSet.
			aStep listProcessor
				priority: index;
				allCandidates: [ each value ];
				title: each key name;
				candidatesLimit: Float infinity;
				itemName: #name;
				filter: GtFilterSubstring ].
	^ aStep
]

{ #category : #accessing }
TGtDatabaseEntity >> gtTableRelationsForHelper: aView withTables: someTables [
	^ aView mondrian
		painting: [ :aMondrian | 
			| view |
			view := aMondrian.
			view nodes
				stencil: [ :each | GtMondrianUMLClassElement withDefaultContainer label: each name ];
				with: someTables
					forEach: [ :aTable | 
						view nodes
							shape: [ :x | x asRelationsViewElement ];
							with: aTable columns.
						view layout vertical ].
			"Invisible edges that affect the tree layout."
			view edges
				stencil: [ BlLineElement new ];
				connect: (self findParentBySymbol: #schema) foreignKeys
					from: [ :each | each table ]
					to: [ :each | each foreignTable ].
			"Visible edges that are 'passive' and don't affect the tree layout."
			view edges
				fromRightCenter;
				toLeftCenter;
				stencil: [ :aForeignKey :fromElement :toElement | 
					BlSigmoidElement new
						border: (BlBorder paint: (Color gray alpha: 0.5) width: 2);
						constraintsDo: [ :c | c ignoreByLayout ];
						zIndex: -1;
						when: BlClickEvent
							do: [ :anEvent | 
								anEvent consumed: true.
								anEvent currentTarget phlow spawnObject: aForeignKey ] ];
				passive;
				connect: (self findParentBySymbol: #schema) foreignKeys
					from: [ :each | each column ]
					to: [ :each | each foreignColumn ].
			view layout horizontalDominanceTree
				levelDistance: 150;
				nodeDistance: 25;
				treesDistance: 75	"force
				strength: 0.10;
				charge: -2500;
				length: 150." ]
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
