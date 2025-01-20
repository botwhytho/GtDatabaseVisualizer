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
