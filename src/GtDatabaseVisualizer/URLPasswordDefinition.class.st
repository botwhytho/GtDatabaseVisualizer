Class {
	#name : #URLPasswordDefinition,
	#superclass : #GtPharoMethodPasswordDefinition,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
URLPasswordDefinition >> startPositionFor: aMessage [
	"Return password start possition"

	| arg password url |
	arg := aMessage arguments at: self position.
	url := arg value value.
	password := url asUrl password.
	^ arg startPosition - 1 + (url findString: password)
]

{ #category : #accessing }
URLPasswordDefinition >> stopPositionFor: aMessage [
	"Return password start possition"

	| arg password url |
	arg := aMessage arguments at: self position.
	url := arg value value.
	password := url asUrl password.
	^ arg startPosition - 2 + (url findString: password) + password size
]
