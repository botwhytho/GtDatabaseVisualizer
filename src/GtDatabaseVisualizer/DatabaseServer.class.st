Class {
	#name : #DatabaseServer,
	#superclass : #Object,
	#traits : 'TGtDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TGtDatabaseEntity classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'databases'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
DatabaseServer class >> databaseConnectorClass [
	self subclassResponsibility
]

{ #category : #initialization }
DatabaseServer class >> databaseInstanceClass [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseServer class >> fromConnectionString: aString [
	| connector |
	connector := self databaseConnectorClass fromConnectionString: aString.
	^ self
		populateInBackground: (self new
				name: connector client asString;
				client: connector)
]

{ #category : #accessing }
DatabaseServer class >> fromConnectionString: aString withShortName: aShortName [
	| connector |
	connector := self databaseConnectorClass
			fromConnectionString: aString
			withShortName: aShortName.
	^ self
		populateInBackground: (self new
				name: aShortName;
				client: connector)
]

{ #category : #accessing }
DatabaseServer class >> populateInBackground: aDatabaseServer [
	| thisCoder |
	thisCoder := (thisContext stack
			detect: [ :each | each contextClass = GtPharoSourceCoder ]) receiver.
	[ self inform: 'Beginning import.'.
	[ aDatabaseServer populateDatabases ]
		ensure: [ aDatabaseServer client close ].
	self inform: 'Finished import.'.
	thisCoder
		notifyToolSpawn: (GtInspectorTool forObject: aDatabaseServer)
		withDestination: thisCoder spawnDestination ]
		forkAt: 29
		named: #GtDatabaseVisualizer
]

{ #category : #accessing }
DatabaseServer >> databases [
	^ databases ifNil: [ databases := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseServer >> databases: anObject [

	databases := anObject
]

{ #category : #accessing }
DatabaseServer >> getDatabases [
	^ self getEntitiesWithArgs: nil
]

{ #category : #accessing }
DatabaseServer >> hierarchyChildren [
	^ children ifNil: [ children := self databases ]
]

{ #category : #accessing }
DatabaseServer >> hierarchyParent [
	^ parent ifNil: [ parent := GtDatabaseVisualizer uniqueInstance ]
]

{ #category : #initialization }
DatabaseServer >> initialize [
	super initialize.
	GtDatabaseVisualizer uniqueInstance servers add: self
]

{ #category : #initialization }
DatabaseServer >> populateDatabases [
	| databaseNameColumn databasesNames |
	databasesNames := self getDatabases.
	databaseNameColumn := databasesNames columnHeaders indexOf: 'name'.
	databasesNames rows
		do: [ :aDatabase | 
			self
				flag: 'TODO: Need to implement error handling below for databases that the credentials don''t have rights to connect to'.
			(aDatabase at: databaseNameColumn) = 'template0'
				ifFalse: [ self client client database: (aDatabase at: databaseNameColumn).
					self databases
						add: (self class databaseInstanceClass new
								name: (aDatabase at: databaseNameColumn);
								client: self client;
								server: self;
								populateSchemas) ] ]
]

{ #category : #accessing }
DatabaseServer >> printOn: aStream [
	aStream nextPutAll: client asString
]
