Class {
	#name : #PostgresDatabaseTable,
	#superclass : #DatabaseTable,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseTable >> gtTableNeighborsFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Table Neighbors';
		priority: 1;
		painting: [ :aMondrian | 
			| connections tableRelationships view |
			tableRelationships := self schema allForeignKeys
					collect: [ :each | 
						(self schema tables detect: [ :inner | inner name = each table_name ])
							-> (self schema tables detect: [ :inner | inner name = each foreign_table_name ]) ].
			connections := self schema allForeignKeys
					collect: [ :each | 
						((self schema tables detect: [ :inner | inner name = each table_name ]) columns
							detect: [ :inner | inner name = each column_name ])
							-> ((self schema tables detect: [ :inner | inner name = each foreign_table_name ])
									columns detect: [ :inner | inner name = each foreign_column_name ]) ].
			view := aMondrian.
			view nodes
				stencil: [ :each | GtMondrianUMLClassElement withDefaultContainer label: each name ];
				with: (tableRelationships
							select: [ :each | each key = self or: [ each value = self ] ]
							thenCollect: [ :each | 
								{each key.
									each value} ]) flattened asSet
					forEach: [ :table | 
						view nodes
							shape: [ :x | 
								BlTextElement new
									text: x name asRopedText;
									constraintsDo: [ :c | c horizontal matchParent ] ];
							with: table columns.
						view layout vertical ].	"Invisible edges that affect the tree layout."
			view edges
				shape: [ :x | BlLineElement new ];
				connect: tableRelationships
					from: [ :each | each key ]
					to: [ :each | each value ].
			view edges
				fromRightCenter;
				toLeftCenter;
				stencil: [ BlSigmoidElement new
						border: (BlBorder paint: (Color gray alpha: 0.5) width: 1);
						constraintsDo: [ :c | c ignoreByLayout ];
						toHead: (BlArrowheadSimpleArrow new
								arrowLengthFraction: 10;
								background: (Color blue alpha: 0.5);
								border: (BlBorder paint: (Color blue alpha: 0.5) width: 15));
						zIndex: -1 ];
				passive;
				connect: connections
					from: [ :each | each key ]
					to: [ :each | each value ].
			view layout horizontalDominanceTree
				levelDistance: 150;
				nodeDistance: 25;
				treesDistance: 75 ]
]

{ #category : #accessing }
PostgresDatabaseTable >> gtTableRelationsFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Table Relationships';
		priority: 2;
		painting: [ :aMondrian | 
			| connections tableRelationships view |
			tableRelationships := self schema allForeignKeys
					collect: [ :each | 
						(self schema tables detect: [ :inner | inner name = each table_name ])
							-> (self schema tables detect: [ :inner | inner name = each foreign_table_name ]) ].
			connections := self schema allForeignKeys
					collect: [ :each | 
						((self schema tables detect: [ :inner | inner name = each table_name ]) columns
							detect: [ :inner | inner name = each column_name ])
							-> ((self schema tables detect: [ :inner | inner name = each foreign_table_name ])
									columns detect: [ :inner | inner name = each foreign_column_name ]) ].
			view := aMondrian.
			view nodes
				stencil: [ :each | GtMondrianUMLClassElement withDefaultContainer label: each name ];
				with: schema tables
					forEach: [ :table | 
						view nodes
							shape: [ :x | 
								BlTextElement new
									text: x name asRopedText;
									constraintsDo: [ :c | c horizontal matchParent ] ];
							with: table columns.
						view layout vertical ].	"Invisible edges that affect the tree layout."
			view edges
				shape: [ :x | BlLineElement new ];
				connect: tableRelationships
					from: [ :each | each key ]
					to: [ :each | each value ].
			view edges
				fromRightCenter;
				toLeftCenter;
				stencil: [ BlSigmoidElement new
						border: (BlBorder paint: (Color gray alpha: 0.5) width: 1);
						constraintsDo: [ :c | c ignoreByLayout ];
						toHead: (BlArrowheadSimpleArrow new
								arrowLengthFraction: 10;
								background: (Color blue alpha: 0.5);
								border: (BlBorder paint: (Color blue alpha: 0.5) width: 15));
						zIndex: -1 ];
				passive;
				connect: connections
					from: [ :each | each key ]
					to: [ :each | each value ].
			view layout "force
				strength: 0.10;
				charge: -2500;
				length: 150."horizontalDominanceTree
				levelDistance: 150;
				nodeDistance: 25;
				treesDistance: 75 ]
]

{ #category : #accessing }
PostgresDatabaseTable >> populateColumns [
	| allColumns columnsInThisTable |
	self valuable: (MessageSend receiver: self schema selector: #allColumns).
	allColumns := self getEntities.
	columnsInThisTable := allColumns select: [ :column | column table_name = self name ].
	columnsInThisTable
		do: [ :aColumn | 
			self columns
				add: (PostgresDatabaseColumn new
						name: aColumn column_name;
						client: self client;
						table: self;
						populateColumnAtributes) ]
]
