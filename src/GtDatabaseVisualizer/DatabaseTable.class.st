Class {
	#name : #DatabaseTable,
	#superclass : #Object,
	#traits : 'TGtDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TGtDatabaseEntity classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'columns',
		'schema'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
DatabaseTable class >> columnClass [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseTable >> columns [
	^ columns ifNil: [ columns := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseTable >> columns: anObject [

	columns := anObject
]

{ #category : #accessing }
DatabaseTable >> getColumns [
	^ self
		getEntitiesWithArgs: {self schema name.
				self name}
]

{ #category : #accessing }
DatabaseTable >> hierarchyChildren [
	^ children ifNil: [ children := self columns ]
]

{ #category : #accessing }
DatabaseTable >> hierarchyParent [
	^ parent ifNil: [ parent := schema ]
]

{ #category : #accessing }
DatabaseTable >> populateColumns [
	| columnQueryResult |
	columnQueryResult := self getColumns.
	columnQueryResult rows
		associationsDo: [ :aColumn | 
			self columns
				add: (self class columnClass new
						name: aColumn key;
						client: self client;
						table: self;
						queryResult: (TransformedQueryResult new
								columnHeaders: columnQueryResult columnHeaders;
								rows: aColumn value);
						populateColumnAttributes) ]
]

{ #category : #accessing }
DatabaseTable >> printOn: aStream [
	aStream nextPutAll: self class name , '(' , name , ')'
]

{ #category : #accessing }
DatabaseTable >> schema [

	^ schema
]

{ #category : #accessing }
DatabaseTable >> schema: anObject [

	schema := anObject
]
