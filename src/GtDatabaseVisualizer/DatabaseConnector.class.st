Class {
	#name : #DatabaseConnector,
	#superclass : #Object,
	#instVars : [
		'client',
		'shortName'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
DatabaseConnector class >> fromConnectionString: aConnectionString [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseConnector class >> fromConnectionString: aConnectionString withShortName: aShortName [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseConnector >> client [

	^ client
]

{ #category : #accessing }
DatabaseConnector >> client: anObject [

	client := anObject
]

{ #category : #accessing }
DatabaseConnector >> close [
	client close
]

{ #category : #accessing }
DatabaseConnector >> closeConnection [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseConnector >> query: aString [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseConnector >> query: aString withArguments: args [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseConnector >> shortName [

	^ shortName
]

{ #category : #accessing }
DatabaseConnector >> shortName: anObject [

	shortName := anObject
]

{ #category : #accessing }
DatabaseConnector >> testConnection [
	"Returns true if connection to the database is working."

	self subclassResponsibility
]
