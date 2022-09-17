Extension { #name : #GtInspector }

{ #category : #'*GtDatabaseVisualizer' }
GtInspector >> addObjectSpotterShortcut [
	self
		addShortcut: (BlShortcutWithAction new
				repeatable: true;
				combination: BlKeyCombinationBuilder new control shift return build;
				action: [ ((self childWithId: #toolbar) query // BrButton) result
						detect: [ :each | each label asString = 'Search' ]
						ifFound: [ :searchButton | searchButton dispatchEvent: BrDropdownShowWish new ] ])
]

{ #category : #'*GtDatabaseVisualizer' }
GtInspector >> initialize [
	super initialize.
	self initializeTitleNotifier.
	self initializeContentElement.
	self initializePlaygroundElement.
	self layout: BlLinearLayout vertical.
	self addChild: self contentElement as: #content.
	self addChild: self playgroundElement as: #playground.
	self addAptitude: (BrLayoutResizerAptitude inherit).
	self initializeListeners.
	self matchParent.
	self playgroundElement collapse.
	self addObjectSpotterShortcut
]
