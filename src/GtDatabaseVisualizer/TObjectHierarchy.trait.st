Trait {
	#name : #TObjectHierarchy,
	#instVars : [
		'hierarchyChildren',
		'hierarchyParent'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
TObjectHierarchy >> findNestedChildByName: anArrayOfNames [
	"Return nested child (or nil) by recursively searching children collections by provided names in order"

	anArrayOfNames ifEmpty: [ ^ nil ].
	^ anArrayOfNames allButFirst
		ifEmpty: [ self hierarchyChildren
				ifNil: [ nil ]
				ifNotNil: [ :collection | 
					collection
						detect: [ :each | [ each name = anArrayOfNames first ] on: SubscriptOutOfBounds do: [ nil ] ]
						ifNone: [ nil ] ] ]
		ifNotEmpty: [ :rest | 
			self hierarchyChildren
				ifNil: [ nil ]
				ifNotNil: [ :collection | 
					collection
						detect: [ :each | each name = anArrayOfNames first ]
						ifFound: [ :found | found findNestedChildByName: rest ]
						ifNone: [ nil ] ] ]
]

{ #category : #accessing }
TObjectHierarchy >> findParentBySymbol: aSymbol [
	"Return parent in the hierarchy that understands aSymbol."

	self
		flag: 'TODO: May clash with other methods with same name, should introspect into return of CompileMethod #hierarchyParent'.
	self hierarchyParent ifNil: [ ^ nil ].
	[ ^ self perform: aSymbol ]
		onDNU: aSymbol
		do: [ ^ self hierarchyParent findParentBySymbol: aSymbol ]
]

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
