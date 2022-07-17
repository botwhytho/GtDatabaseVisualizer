Class {
	#name : #PostgresDatabaseTable,
	#superclass : #DatabaseTable,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseTable class >> columnClass [
	^ PostgresDatabaseColumn
]

{ #category : #accessing }
PostgresDatabaseTable >> gtTableNeighborsFor: aView [
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
							shape: [ :x | 
								BlTextElement new
									text: x name asRopedText;
									constraintsDo: [ :c | c horizontal matchParent ] ];
							with: table columns.
						view layout vertical ].
			"Invisible edges that affect the tree layout."
			view edges
				shape: [ :x | BlLineElement new ];
				connect: self schema foreignKeys
					from: [ :each | each table ]
					to: [ :each | each foreignTable ].
			"Visible edges that are 'passive' and don't affect the tree layout."
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
				connect: self schema foreignKeys
					from: [ :each | each column ]
					to: [ :each | each foreignColumn ].
			view layout horizontalDominanceTree
				levelDistance: 150;
				nodeDistance: 25;
				treesDistance: 75 ]
]

{ #category : #accessing }
PostgresDatabaseTable >> gtTableRelationsFor: aView [
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
							shape: [ :x | 
								BlTextElement new
									text: x name asRopedText;
									constraintsDo: [ :c | c horizontal matchParent ] ];
							with: table columns.
						view layout vertical ].
			"Invisible edges that affect the tree layout."
			view edges
				shape: [ :x | BlLineElement new ];
				connect: self schema foreignKeys
					from: [ :each | each table ]
					to: [ :each | each foreignTable ].
			"Visible edges that are 'passive' and don't affect the tree layout."
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
