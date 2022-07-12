Class {
	#name : #DatabaseColumnAttribute,
	#superclass : #Object,
	#traits : 'TDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TDatabaseEntity classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'column',
		'value'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
DatabaseColumnAttribute >> column [

	^ column
]

{ #category : #accessing }
DatabaseColumnAttribute >> column: anObject [

	column := anObject
]

{ #category : #accessing }
DatabaseColumnAttribute >> hierarchyParent [
	^ parent ifNil: [ parent := self column ]
]

{ #category : #accessing }
DatabaseColumnAttribute >> printOn: aStream [
	aStream nextPutAll: self class name , '(' , name , ')'
]

{ #category : #accessing }
DatabaseColumnAttribute >> value [
	^ value
]

{ #category : #accessing }
DatabaseColumnAttribute >> value: aValue [
	value := aValue
]
