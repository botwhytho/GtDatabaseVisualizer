Trait {
	#name : #TObjectHierarchy,
	#instVars : [
		'children',
		'parent'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
TObjectHierarchy >> children [

	^ children
]

{ #category : #accessing }
TObjectHierarchy >> children: anObject [

	children := anObject
]

{ #category : #view }
TObjectHierarchy >> gtHierarchyFor: aView [
	<gtView>
	| root |
	root := thisContext receiver root.
	(root children isNil or: [ root children isEmpty ]) ifTrue: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Hierarchy';
		priority: 42;
		items: [ {root} ];
		children: [ :aNode | aNode children ];
		actionUpdateButtonTooltip: 'Update tree';
		column: 'Name' text: [ :aNode :anIndex | aNode asString ];
		column: 'Type' text: [ :aNode :anIndex | aNode class ]
]

{ #category : #accessing }
TObjectHierarchy >> parent [

	^ parent
]

{ #category : #accessing }
TObjectHierarchy >> parent: anObject [

	parent := anObject
]

{ #category : #accessing }
TObjectHierarchy >> root [
	| entity |
	entity := thisContext receiver.
	[ entity parent ] whileNotNil: [ entity := entity parent ].
	^ entity
]
