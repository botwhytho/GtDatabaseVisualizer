Trait {
	#name : #TObjectHierarchy,
	#instVars : [
		'hierarchyChildren',
		'hierarchyParent'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #view }
TObjectHierarchy >> gtHierarchyFor: aView [
	<gtView>
	| root |
	root := self hierarchyRoot.
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
	hierarchyChildren := anObject
]

{ #category : #accessing }
TObjectHierarchy >> hierarchyParent [
	self shouldBeImplemented
]

{ #category : #accessing }
TObjectHierarchy >> hierarchyParent: anObject [
	hierarchyParent := anObject
]

{ #category : #accessing }
TObjectHierarchy >> hierarchyRoot [
	| entity |
	entity := self.
	[ entity hierarchyParent ] whileNotNil: [ entity := entity hierarchyParent ].
	^ entity
]
