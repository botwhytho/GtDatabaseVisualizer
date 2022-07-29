Class {
	#name : #DatabaseTable,
	#superclass : #Object,
	#traits : 'TGtDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TGtDatabaseEntity classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'columns',
		'schema'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
DatabaseTable class >> columnClass [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseTable >> columns [
	^ columns ifNil: [ columns := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseTable >> columns: anObject [

	columns := anObject
]

{ #category : #accessing }
DatabaseTable >> getColumns [
	^ self getEntitiesWithArgs: nil
]

{ #category : #accessing }
DatabaseTable >> gtTableNeighborsFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Table Neighbors';
		priority: 1;
		painting: [ :aMondrian | 
			| view |
			view := aMondrian.
			view nodes
				stencil: [ :each | GtMondrianUMLClassElement withDefaultContainer label: each name ];
				with: ((self columns flatCollect: #foreignKeys)
							inject: #()
							into: [ :sum :each | 
								sum
									, {each table.
											each foreignTable} ]) asSet
					forEach: [ :table | 
						view nodes
							shape: [ :x | x asRelationsViewElement ];
							with: table columns.
						view layout vertical ].
			"Invisible edges that affect the tree layout."
			view edges
				stencil: [ BlLineElement new ];
				connect: self schema foreignKeys
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
				connect: self schema foreignKeys
					from: [ :each | each column ]
					to: [ :each | each foreignColumn ].
			view layout horizontalDominanceTree
				levelDistance: 150;
				nodeDistance: 25;
				treesDistance: 75 ]
]

{ #category : #accessing }
DatabaseTable >> gtTableRelationsFor: aView [
	<gtView>
	^ aView mondrian
		title: 'All Table Relationships';
		priority: 2;
		painting: [ :aMondrian | 
			| view |
			view := aMondrian.
			view nodes
				stencil: [ :each | GtMondrianUMLClassElement withDefaultContainer label: each name ];
				with: schema tables
					forEach: [ :table | 
						view nodes
							shape: [ :x | x asRelationsViewElement ];
							with: table columns.
						view layout vertical ].
			"Invisible edges that affect the tree layout."
			view edges
				stencil: [ BlLineElement new ];
				connect: self schema foreignKeys
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
				connect: self schema foreignKeys
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
DatabaseTable >> hierarchyChildren [
	^ hierarchyChildren ifNil: [ hierarchyChildren := self columns ]
]

{ #category : #accessing }
DatabaseTable >> hierarchyParent [
	^ schema
]

{ #category : #accessing }
DatabaseTable >> populateColumns [
	| columnQueryResult |
	columnQueryResult := self getColumns.
	columnQueryResult rows
		associationsDo: [ :aColumn | 
			self columns
				add: (self class columnClass new
						name: aColumn key;
						client: self client;
						table: self;
						queryResult: (TransformedQueryResult new
								columnHeaders: columnQueryResult columnHeaders;
								rows: aColumn value);
						populateColumnAttributes) ]
]

{ #category : #accessing }
DatabaseTable >> printOn: aStream [
	aStream nextPutAll: self class name , '(' , name , ')'
]

{ #category : #accessing }
DatabaseTable >> schema [

	^ schema
]

{ #category : #accessing }
DatabaseTable >> schema: anObject [

	schema := anObject
]
