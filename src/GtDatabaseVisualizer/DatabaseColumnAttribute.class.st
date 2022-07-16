Class {
	#name : #DatabaseColumnAttribute,
	#superclass : #Object,
	#traits : 'TGtDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TGtDatabaseEntity classTrait + TObjectHierarchy classTrait',
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
DatabaseColumnAttribute >> hierarchyChildren [
	^ nil
]

{ #category : #accessing }
DatabaseColumnAttribute >> hierarchyParent [
	^ hierarchyParent ifNil: [ hierarchyParent := self column ]
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
