Trait {
	#name : #TObjectHierarchy,
	#instVars : [
		'children',
		'parent'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #view }
TObjectHierarchy >> gtHierarchyFor: aView [
	<gtView>
	| root |
	root := thisContext receiver hierarchyRoot.
	(root hierarchyChildren isNil or: [ root hierarchyChildren isEmpty ])
		ifTrue: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Hierarchy';
		priority: 42;
		items: [ {root} ];
		children: [ :aNode | aNode hierarchyChildren ifNil: [ #() ] ];
		actionUpdateButtonTooltip: 'Update tree';
		column: 'Name' text: [ :aNode :anIndex | aNode asString ];
		column: 'Type' text: [ :aNode :anIndex | aNode class ]
]

{ #category : #accessing }
TObjectHierarchy >> hierarchyChildren [
	^ self shouldBeImplemented
]

{ #category : #accessing }
TObjectHierarchy >> hierarchyChildren: anObject [
	children := anObject
]

{ #category : #accessing }
TObjectHierarchy >> hierarchyParent [
	self shouldBeImplemented
]

{ #category : #accessing }
TObjectHierarchy >> hierarchyParent: anObject [
	parent := anObject
]

{ #category : #accessing }
TObjectHierarchy >> hierarchyRoot [
	| entity |
	entity := thisContext receiver.
	[ entity hierarchyParent ] whileNotNil: [ entity := entity hierarchyParent ].
	^ entity
]
