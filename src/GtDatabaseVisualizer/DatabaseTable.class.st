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
	^ self getEntitiesWithArgs: nil
]

{ #category : #accessing }
DatabaseTable >> gtTableNeighborsFor: aView [
	<gtView>
	| neighboringTables |
	neighboringTables := ((self columns flatCollect: #foreignKeys)
			inject: #()
			into: [ :sum :each | 
				sum
					, {each table.
							each foreignTable} ]) asSet.
	^ (self gtTableRelationsForHelper: aView withTables: neighboringTables)
		title: 'Table Neighbors';
		priority: 1
]

{ #category : #accessing }
DatabaseTable >> gtTableRelationsFor: aView [
	<gtView>
	^ (self gtTableRelationsForHelper: aView withTables: schema tables)
		title: 'All Table Relationship';
		priority: 2
]

{ #category : #accessing }
DatabaseTable >> hierarchyChildren [
	^ hierarchyChildren ifNil: [ hierarchyChildren := self columns ]
]

{ #category : #accessing }
DatabaseTable >> hierarchyParent [
	^ schema
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
